auth commands
=============

The CLI tool requires authentication before other commands can be used. The
tokens created after authenticating are cached and can be used until they
expire.

``spire auth login``
--------------------

Authenticate using web browser login.

``spire auth refresh``
----------------------

Force a refresh of the access token and the authorization token.

``spire auth status``
---------------------

Shows the current authentication status. An optional flag ``--decode`` will
produce a table showing the permissions in the authorization token.

``spire auth token``
--------------------

Authenticate using a personal access token (PAT). See ``spire user create-pat`` for how to create one.

Flags:

* ``--email``

  The user's email address. Can also be set with the ``SPIRE_EMAIL`` environment variable.

* ``--pat``

  The personal access token. Can also be set with the ``SPIRE_PAT`` environment variable.

* ``--subscription`` or ``-s``

  Limits the session to one subscription, given by its ID. Can also be set with the ``SPIRE_SUBSCRIPTION`` environment variable.

* ``--service``

  Limits the session to one service, given by its ID. Can also be set with the ``SPIRE_SERVICE`` environment variable.

Using the environment variables avoids exposing the token in process listings and shell history.

If the token is restricted to a subscription or service, that restriction is always applied. Requesting a different subscription or service than the token allows produces an error.

.. note:: A session obtained with ``spire auth token`` cannot create, list or delete personal access tokens. Use ``spire auth login`` for that.
