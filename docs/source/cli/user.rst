user commands
=============

``spire user create``
---------------------

Create a new user.

Flags:

* ``--email``

  The user's email address.

* ``--name``

  The user's first name.

* ``--surname``

  The user's surname.

* ``--displayname``

  The user's display name. If not specified, will be set automatically to be the first name and surname combined.

* ``--organisation``

  The ID of the organisation for this user.

.. note:: If the command is run in an interactive terminal and no flags have been specified, the user will be prompted to provide values. Only the email address is a required value.

``spire user describe``
-----------------------

Displays details of the authorised user or an alternative user if ``--user`` is specified with a user ID and the authorised user has permission to retrieve the details of that user.

Flags:

* ``--output``

  One of ``basic``, ``subs``, ``seats`` or ``perms``.
  
  ``basic`` (the default) displays the user's name, email address, ID and optional org ID.

  ``subs`` adds the details of any subscriptions that the user has access to.

  ``seats`` adds the details of any seats in those subscriptions.

  ``perms`` adds the details of any permissions in those seats.

.. note:: If ``--json`` is specified, the output level will be ``subs``.

``spire user list``
-------------------

If used in interactive mode, presents the user with a paginated list of users and selecting a user will display that user's details as if ``user describe --perms`` had been used.

If used in non-interactive mode or if ``--json`` is specified, the list of users is output in JSON format.

``spire user create-pat``
-------------------------

Creates a personal access token (PAT) for the authorised user. A user can hold up to 15 unexpired PATs.

Flags:

* ``--name`` (required)

  A name for the token. It must be unique among the user's tokens.

* ``--expires`` (required)

  When the token expires, at most 12 months from now. Accepts a duration from now (``30d``, ``8w``, ``6m``, ``1y``), a date (``YYYY-MM-DD``, meaning 00:00 UTC on that day) or an RFC 3339 timestamp such as ``2026-12-31T17:00:00Z``.

* ``--subscription`` or ``-s``

  Restricts the token to one subscription, given by its ID.

* ``--service``

  Restricts the token to one service, given by its ID.

* ``--json``

  Outputs the token together with its details in JSON format.

Only the token value is written to standard output, so it can be captured directly, for example ``TOKEN=$(spire user create-pat --name ci --expires 6m)``.

.. warning:: The token value is shown only once, when it is created. It cannot be retrieved later, so store it securely straight away. If it is lost, delete the token and create a new one.

.. note:: An error will be generated if a token with the same name already exists or if the user already holds 15 unexpired tokens.

``spire user list-pats``
------------------------

Lists the authorised user's personal access tokens, newest first. For each token, it shows the ID, name, hint (the first characters of the token), expiry date, status and scope. Token values are never shown.

The status is ``active``, ``expired`` or ``legacy``. Legacy tokens were created before users could hold more than one token.

Flags:

* ``--json``

  Outputs the list in JSON format.

``spire user delete-pat``
-------------------------

Deletes one of the authorised user's personal access tokens, given by its ID, for example ``spire user delete-pat pat:<uuid>``. Use ``spire user list-pats`` to find the ID.

Deleting a token also ends any sessions that were created with it. Once deleted, the token cannot be used or restored.

.. note:: An error will be generated if no token with that ID belongs to the user.

``spire user get-pat``
----------------------

This command has been retired. Personal access tokens can no longer be retrieved after they are created. Use ``spire user list-pats`` to see your tokens or ``spire user create-pat`` to create a new one.

.. note:: The ``create-pat``, ``list-pats`` and ``delete-pat`` commands only work after authenticating with ``spire auth login``. They cannot be used in a session obtained with ``spire auth token``.
