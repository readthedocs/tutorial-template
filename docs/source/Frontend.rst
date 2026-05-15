Frontend
=============

Overview
--------

The frontend of the Unify application is designed to provide a consistent, responsive, and user-friendly experience across multiple platforms. While the exact visual output may differ slightly depending on the operating system or device, the overall layout, functionality, and interaction patterns remain consistent throughout the app.
This document outlines the key frontend design decisions, implementation details, and user interface components used in the application. It also explains how these elements contribute to usability, accessibility, and maintainability.

Fonts
-----

Android: Roboto

iOS/macOS: San Francisco

Windows: Segoe UI

Linux/web: platform/browser default sans-serif chosen by Flutter

Using platform-specific fonts improves readability and ensures that the application aligns with user expectations on each device.

Colours
-------

One consistent colour theme, featuring the colours represented in the University of Portsmouth logo.

Seed colour: 0xFF003087

Primary colour: 0xFF003087

Secondary colour: 0xFF7B2D8E

Background colour: 0x29FFFFFF 

Error colour: 0xFFBA1A1A

Text colour: Not fixed, readable contrast via code:

.. code-block:: dart

  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
    fontWeight: FontWeight.w700,

This approach ensures that text remains legible across different themes and devices.

main.dart
----------


.. _theme:

Theme
------

.. code-block:: dart

  class UnifyApp extends StatelessWidget {
    const UnifyApp({super.key});
  
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Unify - University of Portsmouth Societies',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF003087), // UoP Blue
            primary: const Color(0xFF003087), // UoP Blue
            secondary: const Color(0xFF7B2D8E), // UoP Purple
          ),
          appBarTheme: const AppBarTheme(
            foregroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.white),
          ),
          useMaterial3: true,
        ),
        home: const HomePage(),
      );
    }

This section of code initialises the color scheme throughout the whole program, the navigation bar color scheme, and ensures it is the first page shown to the user when starting the app. The colour scheme is decided through the use of ``colorScheme.fromSeed()``, which chooses 3 colours to base the theme off of. For the Navigation bar, its theme is tetermined by foregroundColor and iconTheme. To ensure the first page is the home page, we use home:const HomePage().

.. _loginData:

User login data
----------------

.. code-block:: dart

  class _HomePageState extends State<HomePage> {
    static const String _sessionUserStorageKey = 'unify.current_user';

This section of code uses a const key for saving/loading the user login data by storing it in local storage. This allows the application to persist user sessions between app launches, improving convenience and reducing the need for repeated logins.

.. _navBar:

Navigation Bar
---------------

.. code-block:: dart

  IconButton(
            tooltip: 'Account',
            onPressed: _openAuthPage,
            icon: const Icon(Icons.person, color: Colors.white),
          ),
          TextButton(
            onPressed: _openAboutUsPage,
            child: const Text(
              'About Us',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(_showHeaderSearch ? 72 : 0),
          child: _showHeaderSearch
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  child: TextField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    textInputAction: TextInputAction.search,
                    onSubmitted: _openSearchResultsPage,
                    decoration: InputDecoration(
                      hintText: 'Search societies, e.g. "Art", "Gaming"',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        onPressed: _openSearchResultsPage,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ),

This section of code creates the Navigation Bar at the top of the page. It creates a Account button which links to the login page, an About us button which links to the About Us page, and a search bar used to search for societies. These are all in the far right of the navigation bar, and the search bar extends when pressed. To prompt the user to search for societies, we use the hintText paramater to encourage user to search for societies. 

.. _welcomeText: 

Intro Text
-----------

.. code-block:: dart

  body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome${_currentUser == null ? '' : ', ${_currentUser!['name'] ?? 'back'}'}',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Find societies that match your interests and connect with students faster.',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(height: 1.35),
            ),

This code displays the text at the top of the page, "Welcome" and "Find societies that match your interests and connect with students faster". The welcome string is optionally personalised to show a plain "Welcome" when ``_currentUser`` is null, or show "Welcome, <name>" when _currentUser exists. If the stored name is null it falls back to "back". The secondary text in the SizedBox adds a height of 8 for vertical spacing.

.. _socList: 

Joined societies list - Logged in + Not in any society
-------------------------------------------------------


.. code-block:: dart

  if (joined.isEmpty) {
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              const Icon(Icons.info_outline),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'You haven\'t joined any societies yet',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Tap "Find societies" to browse and join groups.',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: _openSocietiesPage,
                child: const Text('Find societies'),
              ),
            ],
          ),
        ),
      );
    }

If you are logged in and not in a society, a menu appears which prompts the users to search for societies and connect with more students. This is checked through the if statement joined.IsEmpty - if the current user has no joined societies, returns a Card shown in-place promopting the user to join a society. Tapping the TextButton calls ``_openSocietiesPage``, which navigates to the societies browsing page.

Joined societies list - Logged in + In a society
------------------------------------------------

.. code-block:: dart

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your societies',
          style: Theme.of(context).textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 140,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: joined.length,
            separatorBuilder: (_, __) =>
                const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final s = joined[index];
              return InkWell(
                onTap: () => _navigateToSocietyDetails(
                  s,
                  initialJoined: true,
                ),
                child: SizedBox(
                  width: 220,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            child: Icon(s.icon, size: 28),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [
                                Text(
                                  s.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                  overflow:
                                      TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  '${s.memberCount} members · ${s.rating} ★',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                  ),

Users who have joined societies see a horizontally scrollable list. Each society is represented by a card which displays name, icon, member count, and rating. Clicking a card opens detailed information

This design improves accessibility and allows quick navigation through user memberships.

Not Logged in
--------------

.. code-block:: dart

  if (_currentUser == null) ...[
    const SizedBox(height: 8),
    Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            const Icon(Icons.login),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Sign in to see your societies',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Create an account or sign in to quickly access societies you\'ve joined.',
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: _openAuthPage,
              child: const Text('Sign in'),
            ),
          ],
        ),
      ),
    ),
    const SizedBox(height: 12),
  ],

If the user is not logged in, the box prompts the user to sign in or create an account to quickly access societies you've joined. We can see this by checking if ``_currentUser == null``, meaning that the user has not logged in. Pressing the text button opens the login page, where you can either log in or sign up.

.. _heroCarousel:

Hero Carousel
---------------

.. code-block:: dart

 const SizedBox(height: 18),
  Text(
    'Featured this week',
    style: Theme.of(
      context,
    ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
  ),
  const SizedBox(height: 6),
  Text(
    'Explore popular student groups on campus',
    style: TextStyle(color: Colors.grey.shade700),
  ),

This text is before the hero carousel and tells the user what to expect. It uses text to display "Featured this week".

.. code-block:: dart

  class _HeroCarouselState extends State<HeroCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;
  bool _hovering = false;
  List<Society> get _societies => widget.societies;

  void _openSocietyDetails(Society society) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SocietyDetailsPage(
          name: society.name,
          description: society.description,
          imageUrl: society.imageUrl,
          icon: society.icon,
          initialMemberCount: society.memberCount,
          initialAverageRating: society.rating,
          userEmail: widget.userEmail,
          userAuthToken: widget.userAuthToken,
        ),
      ),
    );
  }

This is the instantiation of the Hero Carousel. It takes the society name, description, imageURL, icon, member count, average rating, user email and their auth token. The hero carousel generates 14 societies with all this information and automatically scrolls through each one automatically, allowing users to quickly view societies at a glance. Clicking on the society in the hero carousel brings you to the society page, where the user can join the society.

about_us.dart
--------------

Banner
------

.. code-block:: dart

  class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'About Us',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                children: [
                  Icon(Icons.groups, size: 64, color: Colors.white),
                  SizedBox(height: 12),
                  Text(
                    'Unify',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Connecting students through societies',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

This code creates the main banner. It is located in the top centre of the page, with large white text saying "About Us", and serves as an introduction to the main page. It has a fradiend background and a clear tagline.

Mission
------

.. code-block:: dart

    _SectionCard(
      icon: Icons.flag_outlined,
      title: 'Our Mission',
      content:
          'Unify is a platform built to help University of Portsmouth students '
          'discover, join, and engage with student societies. We believe that '
          'university life is about more than just studying — it\'s about '
          'building friendships, developing skills, and finding your community.',
    ),

This section of text is located with a card. It includes a title and content text, and layed out in a paragraph format. It explains the purpose of the application:

Encourages community building

Highlights student engagement

Emphasises social and academic benefits


What we offer
--------------

.. code-block:: dart

  _SectionCard(
      icon: Icons.star_outline,
      title: 'What We Offer',
      content: null,
      child: const Column(
        children: [
          _FeatureItem(
            icon: Icons.search,
            text: 'Browse and search all student societies in one place',
          ),
          _FeatureItem(
            icon: Icons.rate_review_outlined,
            text: 'Read and write honest reviews for any society',
          ),
          _FeatureItem(
            icon: Icons.how_to_vote_outlined,
            text: 'Participate in society polls and decisions',
          ),
          _FeatureItem(
            icon: Icons.notifications_outlined,
            text: 'Stay up to date with society news and events',
          ),
        ],
      ),
    ),

This text is what we offer to our users. It is formatted in bullet points, using columns to seperate each point.

Team
-----

.. code-block:: dart
  
  _SectionCard(
    icon: Icons.people_outline,
    title: 'The Team',
    content:
        'Unify was created by a team of University of Portsmouth students '
        'as part of a software engineering project. Our goal was to build '
        'a real, useful tool for the student community using modern '
        'technologies including Flutter and Django.',
  ),

This section describes us as a team, the software engineers working on the project

Contact
--------

.. code-block:: dart

  _SectionCard(
    icon: Icons.mail_outline,
    title: 'Contact Us',
    content:
        'Have a question, suggestion, or spotted a bug? We\'d love to hear '
        'from you.\n\nEmail: unify-support@placeholder.port.ac.uk\n'
        'Website: www.placeholder-unify.port.ac.uk',
  ),

This text tells the user how to contact us. Currently, they are just placeholders.

profile.dart
-------------

Login

.. code-block:: dart

  Widget _buildLoginPage() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: _loginKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            TextFormField(
              controller: _loginEmail,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (val) {
                if (val == null || val.trim().isEmpty)
                  return 'Email is required';
                if (!_isValidEmail(val.trim()))
                  return 'Enter a valid email address';
                return null;
              },
            ),

This part of the code is used to validate email addresses. We check using the function (not) _isValidEmail. If the result is True, then the email is not valid and a new one must be inputted. Authentication is handled asynchronously, with loading states and user feedback.

.. code-block:: dart

            const SizedBox(height: 16),
            TextFormField(
              controller: _loginPassword,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              validator: (val) {
                if (val == null || val.isEmpty) return 'Password is required';
                return null;
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isLoading
                  ? null
                  : () async {
                      if (!_loginKey.currentState!.validate()) return;

                      setState(() => _isLoading = true);
                      final result = await _authService.login(
                        email: _loginEmail.text.trim(),
                        password: _loginPassword.text,
                      );
                      setState(() => _isLoading = false);

                      if (result['success'] == true) {
                        _showMessage('Login successful');
                        Navigator.of(context).pop(result['user']);
                      } else {
                        _showMessage(result['message'] ?? 'Login failed.');
                      }
                    },
              child: const Text('Login'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => setState(() => _showSignUp = true),
              child: const Text('Not a member? Sign up now'),

This part of the code is used for the password and authentication. We check that there is a value in the field before being checked against the database.

Logged in
----------

.. code-block:: dart

  Widget _buildLoggedInView() {
    final email = widget.currentUser?['email'] as String? ?? '';
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.person, size: 64),
            const SizedBox(height: 16),
            const Text(
              'You are currently signed in as',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              email,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () async {
                final updated = await Navigator.of(context)
                    .push<Map<String, dynamic>?>(
                      MaterialPageRoute(
                        builder: (_) => AccountSettingsPage(
                          currentUser: widget.currentUser,
                        ),
                      ),
                    );
                if (updated != null && updated.containsKey('user')) {
                  Navigator.of(context).pop(updated['user']);
                }
              },
              icon: const Icon(Icons.settings),
              label: const Text('Account settings'),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pop({'__logout__': true});
              },
              icon: const Icon(Icons.logout),
              label: const Text('Sign out'),

If you are already logged in and access this page, alternative text is shown. It shows your username, and a button to sign out.

Sign up
--------

.. code-block:: dart

   Widget _buildSignUpPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: _regKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            TextFormField(
              controller: _regName,
              decoration: const InputDecoration(
                labelText: 'Preferred name',
                border: OutlineInputBorder(),
                helperText: 'Maximum 50 characters',
              ),
              maxLength: 50,
              inputFormatters: [LengthLimitingTextInputFormatter(50)],
              validator: (val) {
                if (val == null || val.trim().isEmpty)
                  return 'Preferred name is required';
                if (val.trim().length > 50)
                  return 'Name must be 50 characters or fewer';
                return null;

This code is for the login screen. It uses an input box to allow the user to choose a preferred name, which the website will refer to them as. The value has to not be null and less than 50 characters.

.. code-block:: dart

  const SizedBox(height: 12),
    TextFormField(
      controller: _regEmail,
      decoration: const InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (val) {
        if (val == null || val.trim().isEmpty)
          return 'Email is required';
        if (!_isValidEmail(val.trim()))
          return 'Enter a valid email address';
        return null;
      },

Similarly, there is an input for the email. The email needs to have the @ and . symbol with correct formatting, and we check that with a function.

.. code-block: dart

  const SizedBox(height: 16),
    TextFormField(
      controller: _regPassword,
      decoration: const InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(),
      ),
      obscureText: true,
      validator: (val) {
        if (val == null || val.isEmpty) return 'Password is required';
        return null;
      },
    ),
    const SizedBox(height: 16),
    TextFormField(
      controller: _regConfirm,
      decoration: const InputDecoration(
        labelText: 'Confirm password',
        border: OutlineInputBorder(),
      ),
      obscureText: true,
      validator: (val) {
        if (val == null || val.isEmpty)
          return 'Please confirm your password';
        if (val != _regPassword.text) return 'Passwords do not match';
        return null;
      },
    ),

This is the password section for signing up. The user must input two passwords that match and not be empty.

Mailing List
-------------

.. code-block:: dart
  
  const SizedBox(height: 12),
    CheckboxListTile(
      value: _regOptIn,
      onChanged: (v) => setState(() => _regOptIn = v ?? false),
      title: const Text('Join the mailing list for updates'),
      controlAffinity: ListTileControlAffinity.leading,
    ),

If the user wants to join a mailing list, they can check the box.


Login Page Button
------------------

.. code-block:: dart

  const SizedBox(height: 16),
    TextButton(
      onPressed: () => setState(() => _showSignUp = false),
      child: const Text('Already a member? Log in'),

This button takes you to the login page if you are already a member.

account_settings.dart
----------------------

Account Settings
-----------------

.. code-block:: dart

  class AccountSettingsPage extends StatefulWidget {
    final Map<String, dynamic>? currentUser;
    const AccountSettingsPage({super.key, this.currentUser});

    @override
    State<AccountSettingsPage> createState() => _AccountSettingsPageState();
  }

This is the account settings page. It takes the current user's data as a parameter so it can pre-fill the fields before the user makes any changes.

.. code-block:: dart

  @override
  void initState() {
    super.initState();
    final user = widget.currentUser;
    if (user != null) {
      _optIn = user['opt_in_email'] == true;
      _newEmail.text = user['email'] ?? '';
    }
  }

When the page loads, ``initState`` pulls the user's existing email and mailing list preference and fills them in. The user sees their current values rather than blank fields.

Email
------

.. code-block:: dart

  TextFormField(
    controller: _newEmail,
    decoration: const InputDecoration(
      labelText: 'Email',
      border: OutlineInputBorder(),
    ),
    keyboardType: TextInputType.emailAddress,
    validator: (val) {
      if (val == null || val.trim().isEmpty)
        return 'Email is required';
      if (!val.contains('@') || !val.contains('.'))
        return 'Enter a valid email address';
      return null;
    },
  ),

The email field is pre-filled from the current user data. It checks that the value contains both ``@`` and ``.`` before allowing a save.

Current Password
-----------------

.. code-block:: dart

  TextFormField(
    controller: _currentPassword,
    decoration: const InputDecoration(
      labelText: 'Current password',
      border: OutlineInputBorder(),
    ),
    obscureText: true,
    validator: (val) {
      if (val == null || val.isEmpty)
        return 'Enter your current password';
      return null;
    },
  ),

The current password is required to save any changes at all. It can't be left blank, which stops someone from updating account details on an unattended device.

New Password
-------------

.. code-block:: dart

  TextFormField(
    controller: _newPassword,
    decoration: const InputDecoration(
      labelText: 'New password (optional)',
      border: OutlineInputBorder(),
    ),
    obscureText: true,
    validator: (val) {
      if (val != null && val.isNotEmpty && val.length < 8)
        return 'Password must be at least 8 characters';
      return null;
    },
  ),

New password is optional. If left blank the existing password stays. If filled in, it has to be at least 8 characters.

Save Settings
--------------

.. code-block:: dart

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    final result = await _authService.updateSettings(
      authToken: authToken,
      email: widget.currentUser?['email'] as String?,
      currentPassword: _currentPassword.text.isEmpty
          ? null
          : _currentPassword.text,
      newEmail: _newEmail.text.isEmpty ? null : _newEmail.text.trim(),
      newPassword: _newPassword.text.isEmpty ? null : _newPassword.text,
      optInEmail: _optIn,
    );

    setState(() => _isLoading = false);

    if (result['success'] == true) {
      _showMessage('Settings updated');
      Navigator.of(context).pop({'user': result['user']});
    } else {
      _showMessage(result['message'] ?? 'Update failed');
    }
  }

When the save button is pressed, ``_submit`` runs the form validators first. If they pass, it calls ``_authService.updateSettings`` with only the fields that have values, passing ``null`` for anything left blank. On success it pops back to the profile page and passes the updated user object back, so the rest of the app reflects the changes straight away.

.. code-block:: dart

  ElevatedButton(
    onPressed: _isLoading ? null : _submit,
    child: _isLoading
        ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          )
        : const Text('Save settings'),
  ),

The save button disables itself and shows a small loading spinner while the request is in flight. This stops the user from tapping it twice and sending duplicate requests.

socieites.dart
---------------

Societies
----------

.. code-block:: dart

  class SocietySummary {
    final String name;
    final String description;
    final String category;
    final String imageUrl;
    final IconData icon;
    final int memberCount;
    final double averageRating;
    final bool joined;
  
    const SocietySummary({
      required this.name,
      required this.description,
      required this.category,
      required this.imageUrl,
      required this.icon,
      required this.memberCount,
      required this.averageRating,
      this.joined = false,
    });

This is the instantiation of the society summaries. They include the name, description, category etc, and hold all relevant data for the society. Initially when creating your account, you will have joined no societies, so this.joined will be false for all societies. 

Filters
-------

.. code-block:: dart

  enum SocietySortOption {
    alphabeticalAsc,
    alphabeticalDesc,
    memberCountHighLow,
    ratingHighLow,
  }
  
  enum SocietyRatingFilter {
    any,
    atLeastOne,
    atLeastTwo,
    atLeastThree,
    atLeastFour,
  }

We can filter societies using these filters. They help the user find the societies they want. They can also use the search bar from the main page.

Society List
------------

.. code-block:: 

  Future<void> _loadSocieties() async {
      try {
        final res = await _societyService.listSocieties();
        if (res['success'] == true) {
          final List<dynamic> raw = res['societies'] as List<dynamic>? ?? [];
          final mapped = raw.map((e) {
            final Map<String, dynamic> obj = e as Map<String, dynamic>;
            final name = (obj['name'] ?? obj['title'] ?? '').toString();
            final description = (obj['description'] ?? '').toString();
            final category = (obj['category'] ?? 'General').toString();
            final rawImage = (obj['image_url'] ?? obj['image'] ?? obj['imageUrl'] ?? obj['picture'] ?? '').toString();
            final imageUrl = _normalizeImageUrl(rawImage);
            final memberCount = (obj['member_count'] ?? obj['members'] ?? 0) as int? ?? 0;
            final avg = ((obj['average_rating'] ?? obj['rating']) as num?)?.toDouble() ?? 0.0;
            return SocietySummary(
              name: name,
              description: description,
              category: category,
              imageUrl: imageUrl,
              icon: Icons.group,
              memberCount: memberCount,
              averageRating: avg,
            );
          }).toList();
          if (!mounted) return;
          setState(() {
            _allSocieties = mapped;
            _filteredSocieties = List.from(_allSocieties);
          });
          return;
        }
      } catch (_) {
        // ignore
      }
      if (mounted) setState(() {});
    }

To show the user the list of societies, we pull values from the datgabase including the name, description, image URL, and average ratings. At the top of the page there is a filter that can be used to search throguh these societies more efficeintly, such as through alphabetical ascending or descending, average rating and nnumber of reviews.

Reviews/Comments
-----------------

.. code-block:: dart

  const SizedBox(height: 4),
    Text('${'★' * r.rating}${'☆' * (5 - r.rating)}'),
    const SizedBox(height: 8),
    Text(r.comment),
    const SizedBox(height: 12),

Comments for each society are displayed in SizedBoxes with a star rating and comment. These values are pulled from the database and help the user gauge an idea of what the society is like.

.. code-blocks:: dart

  if (_joined &&
    widget.userEmail != null &&
    _canCreateReview) ...[
  Text(
    'Write a review',
    style: Theme.of(context).textTheme.titleLarge,
  ),
  const SizedBox(height: 8),
  TextField(
    controller: _reviewName,
    decoration: const InputDecoration(
      labelText: 'Name (optional)',
      border: OutlineInputBorder(),
    ),
  ),
  const SizedBox(height: 12),
  DropdownButtonFormField<int>(
    initialValue: _rating,
    decoration: const InputDecoration(
      labelText: 'Rating',
      border: OutlineInputBorder(),
    ),
    items: const [1, 2, 3, 4, 5]
        .map(
          (v) => DropdownMenuItem<int>(
            value: v,
            child: Text('$v / 5'),
          ),
        )

To create a review, you must be logged in and be in the society for two weeks. This is checked using userEmail to check if not null, and ``_canCreateReview`` as a function to check if the user has been in for two weeks. The user can input their name, comment text, and a rating out of 5.

Polls
------

Members can vote on polls creted by society admins

.. code-block:: dart

  Future<void> _voteOnPoll(_SocietyPoll poll, _SocietyPollOption option) async {
    final email = widget.userEmail;
    if (email == null || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please log in before voting.')),
      );
      return;
    }

    if (poll.viewerVoteOptionId != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You can only vote once per poll.')),
      );
      return;
    }

    final result = await _societyService.votePoll(
      email: email,
      pollId: poll.id,
      optionId: option.id,
      authToken: widget.userAuthToken,
    );

    if (!mounted) return;

    if (result['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message']?.toString() ?? 'Vote recorded.'),
        ),
      );
      await _loadPolls();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            result['message']?.toString() ?? 'Could not vote on poll.',
          ),
        ),
      );
    }
  }

Users can only vote one per poll and ahve to be logged in and part of the society. The poll gives a list of options, and when the user selects and submits their vote it is recorded and sent to the database

Society Admins
--------------

Society admins have special permissions within the society page. They can create polls, reply and delete to comments, and view rating analytics.

To create a poll, the user must be an admin for the society.

  Future<void> _showCreatePollDialog() async {
    final email = widget.userEmail;
    if (email == null || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please log in as an admin to create polls.'),
        ),
      );
      return;
    }


.. code-block:: dart

  const SizedBox(height: 12),
    if (_loading)
      const Center(child: CircularProgressIndicator())
    else if (_infoItems.isEmpty && _polls.isEmpty)
      Card(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Text(
            (_canCreatePoll || _canCreateInfo)
                ? 'No posts yet. Use the top buttons to add information or a poll.'
                : 'No posts available right now.',
            style: TextStyle(color: Colors.grey.shade700),
          ),
        ),
      )

This code shows current polls. If there are no polls active at the time, the user is prompted to create one using buttons at the top.

.. code-block:: dart

  if (_canCreatePoll)
    PopupMenuButton<String>(
      tooltip: 'Manage poll',
      onSelected: (value) async {
        if (value == 'add_option') {
          await _showAddOptionDialog(poll);
        } else if (value == 'delete_option') {
          await _showDeleteOptionDialog(poll);
        } else if (value == 'delete_poll') {
          await _deletePoll(poll);
        }
      },
      itemBuilder: (context) => const [
        PopupMenuItem<String>(
          value: 'add_option',
          child: Text('Add option'),
        ),
        PopupMenuItem<String>(
          value: 'delete_option',
          child: Text('Delete option'),
        ),
        PopupMenuItem<String>(
          value: 'delete_poll',
          child: Text('Delete poll'),
        ),
      ],
    ),

This code is how the admin can manage new and existing polls. They can add or delete options, or delete the poll entirely.

.. code-block:: dart

  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Expanded(
            child: Text(
              info.title.isEmpty ? 'Message' : info.title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          const Chip(
            visualDensity: VisualDensity.compact,
            label: Text('Info'),
          ),
          if (_canCreateInfo)
            IconButton(
              tooltip: 'Delete message',
              onPressed: () => _deleteInfo(info),
              icon: const Icon(Icons.delete_outline),
            ),
        ],
      ),
      const SizedBox(height: 4),
      Text(info.content),
      const SizedBox(height: 6),
      Text(
        'Posted by ${info.adminDisplayName}',
        style: TextStyle(color: Colors.grey.shade700),
      ),

Admins can leave messages to society members. This includes a title, text, and who it was posted by.

.. code-block::

  final stats = result['stats'] as Map<String, dynamic>? ?? {};
  final int totalMembers = stats['total_members'] as int? ?? 0;
  final int adminCount = stats['admin_count'] as int? ?? 0;
  final int totalAnnouncements = stats['total_announcements'] as int? ?? 0;
  final int totalPolls = stats['total_polls'] as int? ?? 0;
  final int totalReviews = stats['total_reviews'] as int? ?? 0;
  final int totalReactions = stats['total_reactions'] as int? ?? 0;

Admins can view analytics of their society using a button at th top. This is shown in a popup window, with details such as total members, announcewments, reviews etc.

Additional analytics such as graphs of members and reviews over time are also viewable:

.. code-block:: dart

  const SizedBox(height: 16),
    Text(
      'Trends',
      style: Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(fontWeight: FontWeight.w700),
    ),
    const SizedBox(height: 12),
    Card(
      color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Members and reviews over time',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: trends.isEmpty
                  ? null
                  : () => _showMembersReviewsTrendDialog(
                        context: context,
                        rawTrends: trends,
                      ),
              icon: const Icon(Icons.show_chart),
              label: const Text('View line graph'),
            ),
            if (trends.isEmpty) ...[
              const SizedBox(height: 8),
              Text(
                'No trend data available yet.',
                style: Theme.of(context).textTheme.bodySmall,
              ),

This shows the data in a line graph, which is easier to understand for admins and allows them to understand the ratings within their society and whether they ahve improved or not.
