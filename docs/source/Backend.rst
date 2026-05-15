Backend
=======

Overview
--------

The backend is written in **Python Django**. Incoming requests hit a central API Gateway, which works out which manager should handle them and passes the request along. All data goes into a **PostgreSQL** database.

There are five managers, each owning a distinct slice of the app:

- **Account Manager**: registration, login, and role-based access
- **Review Manager**: create, edit, moderate, and respond to society reviews
- **Voting Manager**: poll creation, anonymous voting, and result collection
- **Society Manager**: society CRUD operations and membership
- **Notification Manager**: email subscriptions and notification preferences

Architecture
------------

Every request from the Flutter app goes through the same path:

::

  Flutter GUI
       │
       ▼
  API Gateway  (routes requests to the correct manager)
       │
       ├──► Account Manager
       ├──► Review Manager  (Admin / Member)
       ├──► Voting Manager  (Admin / Member)
       ├──► Society Manager
       └──► Notification Manager
                │
                ▼
           PostgreSQL Database

The gateway is the only entry point the frontend ever calls. It receives the request, figures out which manager owns it, and hands it off. The manager does the actual work and talks to the database.

.. _apiGateway:

API Gateway
-----------

All URL definitions live in Django's ``urls.py``. Each ``include()`` points at a separate app's URL file, which then maps to the right view.

.. code-block:: python

  # unify/urls.py
  from django.urls import path, include

  urlpatterns = [
      path('api/auth/',       include('account.urls')),
      path('api/reviews/',    include('reviews.urls')),
      path('api/voting/',     include('voting.urls')),
      path('api/societies/',  include('societies.urls')),
      path('api/notify/',     include('notifications.urls')),
  ]



.. _accountManager:

Account Manager
---------------

This manager covers registration, login, and profile updates. The two user roles are **society members** (regular users) and **society leaders** (admins). The difference is: if a UP number starts with ``A``, the account gets leader access.

.. code-block:: python

  # account/models.py
  from django.contrib.auth.models import AbstractUser
  from django.db import models

  class UnifyUser(AbstractUser):
      up_number   = models.CharField(max_length=20, unique=True)
      is_leader   = models.BooleanField(default=False)
      email_sub   = models.BooleanField(default=False)

      def save(self, *args, **kwargs):
          if self.up_number.startswith('A'):
              self.is_leader = True
          super().save(*args, **kwargs)

``UnifyUser`` builds on Django's ``AbstractUser`` with three extra fields: a UP number, an ``is_leader`` flag, and an ``email_sub`` flag for the mailing list. The ``save()`` override sets ``is_leader`` automatically whenever the UP number starts with ``A``, so there's no admin step required.

.. code-block:: python

  # account/views.py
  from django.contrib.auth.hashers import make_password, check_password
  from rest_framework.decorators import api_view
  from rest_framework.response import Response
  from .models import UnifyUser

  @api_view(['POST'])
  def register(request):
      data = request.data
      if UnifyUser.objects.filter(username=data['username']).exists():
          return Response({'error': 'Username already taken'}, status=400)

      user = UnifyUser.objects.create(
          username   = data['username'],
          email      = data['email'],
          up_number  = data['up_number'],
          password   = make_password(data['password']),
          email_sub  = data.get('email_sub', False),
      )
      return Response({'message': 'Account created', 'user_id': user.id}, status=201)

  @api_view(['POST'])
  def login_view(request):
      data = request.data
      try:
          user = UnifyUser.objects.get(username=data['username'])
      except UnifyUser.DoesNotExist:
          return Response({'error': 'Invalid credentials'}, status=401)

      if not check_password(data['password'], user.password):
          return Response({'error': 'Invalid credentials'}, status=401)

      return Response({
          'user_id':   user.id,
          'is_leader': user.is_leader,
          'token':     generate_auth_token(user),
      })

Passwords are hashed with ``make_password`` before anything gets written to the database. On login, ``check_password`` does the comparison; the raw password never touches storage. A successful login returns a token and the user's role, which tells the Flutter client whether to open the member or leader dashboard.

.. _membershipCheck:

Membership Validation
---------------------

Before a user can vote or review, the backend checks two things: they're actually in the society, and they've been there for at least **14 days**.

.. code-block:: python

  # societies/utils.py
  from datetime import date, timedelta
  from .models import Membership

  def is_eligible_to_review(user_id, society_id):
      try:
          membership = Membership.objects.get(
              user_id=user_id,
              society_id=society_id
          )
      except Membership.DoesNotExist:
          return False, 'You are not a member of this society.'

      days_since_join = (date.today() - membership.joined_on).days
      if days_since_join < 14:
          return False, 'You must be a member for at least 2 weeks to leave a review.'

      return True, None

Both checks happen in a single lookup. The function returns a ``(bool, error_message)`` tuple so the caller gets a ready-to-send error string. The 14-day rule is enforced at the backend and the frontend can't bypass it.

.. _reviewManager:

Review Manager
--------------

Members can create, edit, and like reviews. Admins can remove them or post a response underneath. Both sides use the same ``Review`` model.

.. code-block:: python

  # reviews/models.py
  from django.db import models
  from account.models import UnifyUser

  class Review(models.Model):
      user        = models.ForeignKey(UnifyUser, on_delete=models.CASCADE)
      society_id  = models.IntegerField()
      text        = models.TextField(blank=True)
      star_rating = models.PositiveSmallIntegerField(null=True)
      is_active   = models.BooleanField(default=True)
      created_at  = models.DateTimeField(auto_now_add=True)
      admin_response = models.TextField(blank=True, null=True)

      class Meta:
          unique_together = ('user', 'society_id')

The ``unique_together`` constraint on ``(user, society_id)`` means the database itself prevents duplicate reviews. One per member per society, regardless of what the frontend sends.

Submitting a review
~~~~~~~~~~~~~~~~~~~

.. code-block:: python

  # reviews/views.py
  BANNED_WORDS = ['badword1', 'badword2']  # loaded from DB in production

  @api_view(['POST'])
  def submit_review(request):
      user_id    = request.data['user_id']
      society_id = request.data['society_id']

      eligible, error = is_eligible_to_review(user_id, society_id)
      if not eligible:
          return Response({'error': error}, status=403)

      text = request.data.get('text', '')
      if any(word in text.lower() for word in BANNED_WORDS):
          return Response({'error': 'Review contains prohibited content.'}, status=400)

      Review.objects.create(
          user_id    = user_id,
          society_id = society_id,
          text       = text,
          star_rating = request.data.get('star_rating'),
      )
      update_society_average_rating(society_id)
      return Response({'message': 'Review submitted.'}, status=201)

The view runs the eligibility check first, then filters the text against the banned-words list. If either fails, nothing gets written. If both pass, the review is created and the society's average rating is recalculated.

Admin moderation
~~~~~~~~~~~~~~~~

.. code-block:: python

  @api_view(['POST'])
  def admin_remove_review(request):
      user    = get_user_from_token(request)
      if not user.is_leader:
          return Response({'error': 'Insufficient permissions.'}, status=403)

      review_id = request.data['review_id']
      try:
          review = Review.objects.get(id=review_id, society_id=request.data['society_id'])
      except Review.DoesNotExist:
          return Response({'error': 'Review not found.'}, status=404)

      review.is_active = False
      review.save()
      return Response({'message': 'Review removed.'})

  @api_view(['POST'])
  def admin_respond_to_review(request):
      user = get_user_from_token(request)
      if not user.is_leader:
          return Response({'error': 'Insufficient permissions.'}, status=403)

      response_text = request.data.get('response_text', '').strip()
      if not response_text:
          return Response({'error': 'Response text cannot be empty.'}, status=400)

      review = Review.objects.get(id=request.data['review_id'])
      review.admin_response = response_text
      review.save()
      return Response({'message': 'Response posted.'})

Removal sets ``is_active = False`` rather than deleting the row outright. The record stays in the database for auditing purposes, and the average rating can still be recalculated correctly. Responding just writes the admin's text directly onto the review row, so members see it on the next page load.

.. _votingManager:

Voting Manager
--------------

Society leaders create polls, members vote on them anonymously. A member can change their vote, but only within **5 minutes** of casting it.

.. code-block:: python

  # voting/models.py
  from django.db import models

  class Poll(models.Model):
      society_id  = models.IntegerField()
      title       = models.CharField(max_length=200)
      description = models.TextField(max_length=500)
      created_by  = models.IntegerField()
      created_at  = models.DateTimeField(auto_now_add=True)
      closes_at   = models.DateTimeField()
      is_active   = models.BooleanField(default=True)

  class PollOption(models.Model):
      poll    = models.ForeignKey(Poll, related_name='options', on_delete=models.CASCADE)
      text    = models.CharField(max_length=200)
      votes   = models.PositiveIntegerField(default=0)

  class Vote(models.Model):
      poll      = models.ForeignKey(Poll, on_delete=models.CASCADE)
      user_id   = models.IntegerField()
      option    = models.ForeignKey(PollOption, on_delete=models.CASCADE)
      cast_at   = models.DateTimeField(auto_now_add=True)

      class Meta:
          unique_together = ('poll', 'user_id')

``Vote`` uses ``unique_together`` to stop the same user voting twice on one poll. ``PollOption.votes`` is a count updated on every vote, which means displaying results never requires a ``COUNT`` across every vote row.

Creating a poll
~~~~~~~~~~~~~~~

.. code-block:: python

  # voting/views.py
  from datetime import timedelta
  from django.utils import timezone

  @api_view(['POST'])
  def create_poll(request):
      user = get_user_from_token(request)
      if not user.is_leader:
          return Response({'error': 'Only society leaders can create polls.'}, status=403)

      description = request.data.get('description', '')
      if len(description) > 500:
          return Response({'error': 'Description must not exceed 500 characters.'}, status=400)

      options = request.data.get('options', [])
      if len(options) < 2:
          return Response({'error': 'A poll must have at least two options.'}, status=400)

      closes_at = timezone.now() + timedelta(days=request.data.get('duration_days', 7))
      poll = Poll.objects.create(
          society_id  = request.data['society_id'],
          title       = request.data['title'],
          description = description,
          created_by  = user.id,
          closes_at   = closes_at,
      )
      for option_text in options:
          PollOption.objects.create(poll=poll, text=option_text)

      return Response({'message': 'Poll created.', 'poll_id': poll.id}, status=201)

The 500-character limit and the two-option minimum are both validated before any database write. The poll's closing time is calculated server-side, so the client doesn't get to decide when a poll ends.

Casting a vote
~~~~~~~~~~~~~~

.. code-block:: python

  @api_view(['POST'])
  def cast_vote(request):
      user_id   = request.data['user_id']
      poll_id   = request.data['poll_id']
      option_id = request.data['option_id']

      poll = Poll.objects.get(id=poll_id)
      if not poll.is_active or timezone.now() > poll.closes_at:
          return Response({'error': 'This poll is no longer open.'}, status=400)

      existing = Vote.objects.filter(poll_id=poll_id, user_id=user_id).first()
      if existing:
          change_window = existing.cast_at + timedelta(minutes=5)
          if timezone.now() > change_window:
              return Response({'error': 'The 5-minute vote-change window has passed.'}, status=400)
          # Decrement old option, update vote
          existing.option.votes = models.F('votes') - 1
          existing.option.save()
          existing.option = PollOption.objects.get(id=option_id)
          existing.save()
      else:
          Vote.objects.create(poll_id=poll_id, user_id=user_id, option_id=option_id)

      PollOption.objects.filter(id=option_id).update(votes=models.F('votes') + 1)
      return Response({'message': 'Vote recorded anonymously.'})

The view checks the poll is still open and the change window hasn't expired before writing anything.
.. _societyManager:

Society Manager
---------------

Leaders can create, update, and delete societies. Members can browse and join them.

.. code-block:: python

  # societies/models.py
  from django.db import models

  class Society(models.Model):
      name          = models.CharField(max_length=100, unique=True)
      description   = models.TextField()
      leader_id     = models.IntegerField()
      member_count  = models.PositiveIntegerField(default=0)
      average_rating = models.FloatField(default=0.0)
      created_at    = models.DateTimeField(auto_now_add=True)

  class Membership(models.Model):
      user_id    = models.IntegerField()
      society    = models.ForeignKey(Society, on_delete=models.CASCADE)
      joined_on  = models.DateField(auto_now_add=True)

      class Meta:
          unique_together = ('user_id', 'society')

Joining a society
~~~~~~~~~~~~~~~~~

.. code-block:: python

  @api_view(['POST'])
  def join_society(request):
      user_id    = request.data['user_id']
      society_id = request.data['society_id']

      if Membership.objects.filter(user_id=user_id, society_id=society_id).exists():
          return Response({'error': 'You are already a member of this society.'}, status=400)

      Membership.objects.create(user_id=user_id, society_id=society_id)
      Society.objects.filter(id=society_id).update(
          member_count=models.F('member_count') + 1
      )
      return Response({'message': 'Joined society.'}, status=201)

``member_count`` is stored directly on the ``Society`` row so browsing the society list doesn't need a join. It's updated with ``F('member_count') + 1`` which avoids race conditions.

.. _notificationManager:

Notification Manager
--------------------

Users can opt in or out of emails at any time. Members who are subscribed get notified when a new poll opens and receive a monthly prompt to rate their societies. Leaders get a monthly summary of their society's rating trend.

.. code-block:: python

  # notifications/views.py
  from django.core.mail import send_mail
  from account.models import UnifyUser

  @api_view(['POST'])
  def update_email_preference(request):
      user = UnifyUser.objects.get(id=request.data['user_id'])
      user.email_sub = request.data['subscribe']
      user.save()
      return Response({'message': 'Email preference updated.'})

  def send_poll_notification(society_id, poll_title, closing_date):
      members = UnifyUser.objects.filter(
          membership__society_id=society_id,
          email_sub=True,
          is_leader=False,
      )
      recipient_list = [m.email for m in members]
      send_mail(
          subject = f'New poll: {poll_title}',
          message = f'A new poll is open in your society. Voting closes on {closing_date}.',
          from_email = 'no-reply@unify.ac.uk',
          recipient_list = recipient_list,
          fail_silently  = True,
      )

``update_email_preference`` flips the ``email_sub`` flag, which is what ``send_poll_notification`` checks when it builds the recipient list. ``fail_silently=True`` means an email server problem won't surface as an error to the user. The poll still gets created; the notification just doesn't go out.

.. _trendAnalysis:

Monthly Trend Analysis
----------------------

Leaders can check how their society's average rating has moved from month to month.

.. code-block:: python

  # societies/views.py
  from django.db.models import Avg
  from django.db.models.functions import TruncMonth
  from reviews.models import Review

  @api_view(['GET'])
  def monthly_trend(request, society_id):
      user = get_user_from_token(request)
      if not user.is_leader:
          return Response({'error': 'Access denied.'}, status=403)

      trend = (
          Review.objects
          .filter(society_id=society_id, is_active=True, star_rating__isnull=False)
          .annotate(month=TruncMonth('created_at'))
          .values('month')
          .annotate(avg_rating=Avg('star_rating'))
          .order_by('month')
      )

      if trend.count() < 2:
          return Response({'error': 'Not enough data — at least 2 months of ratings required.'}, status=400)

      return Response({'trend': list(trend)})

The query groups active, star-rated reviews by calendar month and averages the ratings in one database trip. If there's less than two months of data, it returns an error because there's no meaningful trend to show with a single data point. The result is a list of ``{month, avg_rating}`` objects, which the Flutter chart widget reads directly.

.. _database:

Database
--------

The backend uses **PostgreSQL**. Django generates the SQL and handles migrations; PostgreSQL enforces foreign key constraints between tables.

Important tables:

- ``unifyuser``: credentials, UP number, role flag, and email preference
- ``society``: society metadata, with a stored member count and average rating
- ``membership``: links users to societies, with a join date used for the 14-day check
- ``review``: review text, star rating, active status, and any admin response
- ``poll`` / ``polloption`` / ``vote``: poll data, options, and anonymous vote records

.. code-block:: python

  # Running migrations
  python manage.py makemigrations
  python manage.py migrate

``makemigrations`` reads your model changes and generates a migration file. ``migrate`` runs it against the database. No manual SQL needed.
