/// Provides the Fluo SDK for Flutter applications.
///
/// This library allows developers to integrate Fluo authentication and user management
/// features into their Flutter apps. It handles session management, social sign-ins,
/// and provides access to user data.
library fluo;

import 'dart:io';

import 'package:fluo/api/api_client.dart';
import 'package:fluo/api/models/app_config.dart';
import 'package:fluo/api/models/session.dart';
import 'package:fluo/fluo_theme.dart';
import 'package:fluo/managers/session_manager.dart';
import 'package:fluo/presentation/auth/auth_navigator.dart';
import 'package:fluo/presentation/register/register_navigator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class Fluo {
  Fluo._(this._apiClient, this._sessionManager, this._appConfig);

  static Fluo? _instance;

  final ApiClient _apiClient;

  final SessionManager _sessionManager;

  final AppConfig _appConfig;

  AppConfig get appConfig => _appConfig;

  /// This method is async because it tries to load a potential
  /// session object from the secure storage and load the app configuration.
  static Future<void> init(String apiKey) async {
    final apiClient = ApiClient(apiKey);

    SessionManager sessionManager;
    try {
      sessionManager = await SessionManager.init();
      await sessionManager.getSession(
        apiClient: apiClient,
        forceRefresh: true,
      );
    } catch (e) {
      throw Exception('Failed to initialize session: $e');
    }

    AppConfig appConfig;
    try {
      appConfig = await apiClient.getAppConfig();
    } catch (e) {
      throw Exception('Failed to load app config: $e');
    }

    _instance = Fluo._(apiClient, sessionManager, appConfig);
  }

  static Fluo get instance {
    if (_instance == null) {
      throw Exception(
          'Fluo has not been initialized. Call Fluo.init(apiKey) first.');
    }
    return _instance!;
  }

  static bool get isInitialized => _instance != null;

  /// Returns the current session.
  Session? get session => _sessionManager.session;

  /// Returns whether a current session exists.
  bool hasSession() {
    return _sessionManager.session != null;
  }

  /// Refreshes the current session.
  Future<void> refreshSession() async {
    await _sessionManager.getSession(
      apiClient: _apiClient,
      forceRefresh: true,
    );
  }

  /// Clears the session saved in secure storage.
  ///
  /// This method can be useful if the user is stuck on an old session
  /// and you want to force the start of a brand new session, for example
  /// after a migration.
  ///
  Future<void> clearSession() async {
    await _sessionManager.clearSession();
  }

  /// Returns whether the current user is ready.
  bool isUserReady() {
    final session = _sessionManager.session;
    if (session == null) {
      return false;
    }

    final steps = _appConfig.registrationSteps;
    for (var i = 0; i < steps.length; ++i) {
      final step = steps[i];
      if (step.id == 'firstName' && step.selected) {
        final firstName = session.user.firstName;
        if (firstName == null || firstName.length < 2) {
          return false;
        }
      }
      if (step.id == 'lastName' && step.selected) {
        final lastName = session.user.lastName;
        if (lastName == null || lastName.length < 2) {
          return false;
        }
      }
    }

    return true;
  }

  /// Returns the access token or null if there is no valid session.
  ///
  /// If `null` is returned, you should show the connect flow by calling
  /// [showConnectWithEmailFlow], [showConnectWithGoogleFlow], or [showConnectWithAppleFlow].
  ///
  /// More details below.
  ///
  /// First, it tries to load a previously saved session from the secure
  /// user storage. If there is none, it returns null.
  ///
  /// If there is a saved session and [forceRefresh] is `false`, then it
  /// asks the server to refresh both the access and refresh tokens only
  /// if the access token is older than one hour.
  ///
  /// If there is a saved session and [forceRefresh] is `true`, then it
  /// asks the server to refresh both the access and refresh tokens.
  ///
  Future<String?> getAccessToken({
    bool forceRefresh = false,
  }) async {
    final session = await _sessionManager.getSession(
      apiClient: _apiClient,
      forceRefresh: forceRefresh,
    );
    return session?.accessToken;
  }

  /// Shows the connect with email flow.
  ///
  /// This is a modal dialog which takes care of collecting the user's email,
  /// sending an otp, and validating the session.
  ///
  void showConnectWithEmailFlow({
    required BuildContext context,
    required FluoTheme theme,
    required VoidCallback onExit,
    required VoidCallback onUserReady,
  }) {
    _showNavigator(
      context: context,
      theme: theme,
      navigator: AuthNavigator(
        initialRoute: AuthNavigator.routeEnterEmail,
        onExit: () {
          onExit();
          Navigator.of(context).pop();
        },
        onUserAuthenticated: () {
          if (isUserReady()) {
            onUserReady();
            Navigator.of(context).pop();
          } else {
            Navigator.of(context).pop();
            showRegisterFlow(
              context: context,
              theme: theme,
              onUserReady: onUserReady,
            );
          }
        },
      ),
    );
  }

  /// Shows the connect with mobile flow.
  ///
  /// This is a modal dialog which takes care of collecting the user's mobile number,
  /// sending an otp, and validating the session.
  ///
  void showConnectWithMobileFlow({
    required BuildContext context,
    required FluoTheme theme,
    required VoidCallback onExit,
    required VoidCallback onUserReady,
  }) {
    _showNavigator(
      context: context,
      theme: theme,
      navigator: AuthNavigator(
        initialRoute: AuthNavigator.routeEnterMobile,
        onExit: () {
          onExit();
          Navigator.of(context).pop();
        },
        onUserAuthenticated: () {
          if (isUserReady()) {
            onUserReady();
            Navigator.of(context).pop();
          } else {
            Navigator.of(context).pop();
            showRegisterFlow(
              context: context,
              theme: theme,
              onUserReady: onUserReady,
            );
          }
        },
      ),
    );
  }

  /// Returns the Google client ID for the current platform.
  ///
  /// This method checks the app configuration to determine the appropriate
  /// Google client ID based on the platform. It supports web, iOS, and Android.
  ///
  /// Returns:
  /// - The Google client ID for the current platform.
  String getGoogleClientId() {
    final googleClientId = appConfig.authMethods
        .firstWhere((method) => method.id == 'google')
        .googleClientId!;
    if (kIsWeb) {
      return googleClientId.web;
    }
    if (Platform.isIOS) {
      return googleClientId.ios;
    }
    if (Platform.isAndroid) {
      return googleClientId.android;
    }
    return '';
  }

  /// Shows the Google Sign-in flow.
  ///
  /// This is a modal dialog which takes care of signing in the user's google
  /// account and creating the fluo session.
  ///
  /// Parameters:
  /// - [onBeforeSessionCreation]: Called after Google authentication is successful
  ///   but before creating the Fluo session. This provides an opportunity to show
  ///   a loading dialog while Fluo processes the authentication.
  /// - [onUserReady]: Called when the Fluo session is successfully created and
  ///   all registration parameters (like first name and last name) have been
  ///   collected and verified.
  ///
  Future<bool> showConnectWithGoogleFlow({
    required BuildContext context,
    required FluoTheme theme,
    required VoidCallback onBeforeSessionCreation,
    required VoidCallback onUserReady,
    List<String> scopes = const ['email'],
  }) async {
    final clientId = getGoogleClientId();
    if (clientId.isEmpty) {
      throw Exception(
          'No google client id for ${kIsWeb ? "web" : Platform.operatingSystem}');
    }

    final googleSignIn = GoogleSignIn(
      clientId: clientId,
      scopes: scopes.contains('email') ? scopes : [...scopes, 'email'],
    );

    final googleAccount = await googleSignIn.signIn();
    if (googleAccount == null) {
      // User cancelled the sign in dialog
      return false;
    }

    final googleAuth = await googleAccount.authentication;
    final googleIdToken = googleAuth.idToken;
    if (googleIdToken == null) {
      throw Exception('No google id token found');
    }

    if (!context.mounted) {
      return false;
    }

    onBeforeSessionCreation();

    await createSession(
      context: context,
      theme: theme,
      onUserReady: onUserReady,
      googleIdToken: googleIdToken,
    );

    return true;
  }

  /// Shows the Apple Sign-in flow.
  ///
  /// This is a modal dialog which takes care of signing in the user's apple
  /// account and creating the fluo session.
  ///
  /// Parameters:
  /// - [onBeforeSessionCreation]: Called after Apple authentication is successful
  ///   but before creating the Fluo session. This provides an opportunity to show
  ///   a loading dialog while Fluo processes the authentication.
  /// - [onUserReady]: Called when the Fluo session is successfully created and
  ///   all registration parameters (like first name and last name) have been
  ///   collected and verified.
  ///
  Future<bool> showConnectWithAppleFlow({
    required BuildContext context,
    required FluoTheme theme,
    required VoidCallback onBeforeSessionCreation,
    required VoidCallback onUserReady,
  }) async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      if (!context.mounted) {
        return false;
      }

      onBeforeSessionCreation();

      await createSession(
        context: context,
        theme: theme,
        onUserReady: onUserReady,
        appleIdToken: credential.identityToken,
        firstName: credential.givenName,
        lastName: credential.familyName,
      );

      return true;
    } on SignInWithAppleAuthorizationException {
      // User cancelled the dialog
      return false;
    } on SignInWithAppleException catch (e) {
      throw Exception('There was an exception while signing in with Apple: $e');
    }
  }

  /// Creates a session with the given parameters.
  ///
  /// Once the session is created, it will show the register flow if the user
  /// is not complete. Otherwise, it will call the [onUserReady] callback.
  ///
  Future<void> createSession({
    required BuildContext context,
    required FluoTheme theme,
    required VoidCallback onUserReady,
    String? googleIdToken,
    String? appleIdToken,
    String? firstName,
    String? lastName,
  }) async {
    final session = await _apiClient.createSession(
      googleIdToken: googleIdToken,
      appleIdToken: appleIdToken,
      firstName: firstName,
      lastName: lastName,
    );

    await _sessionManager.setSession(session);

    if (isUserReady()) {
      onUserReady();
    } else if (context.mounted) {
      showRegisterFlow(
        context: context,
        theme: theme,
        onUserReady: onUserReady,
      );
    }
  }

  /// Shows the register flow.
  ///
  /// This is a modal dialog which takes care of registering an already
  /// authenticated user.
  ///
  void showRegisterFlow({
    required BuildContext context,
    required FluoTheme theme,
    required VoidCallback onUserReady,
  }) {
    _showNavigator(
      context: context,
      theme: theme,
      navigator: RegisterNavigator(
        onUserReady: () {
          onUserReady();
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void _showNavigator({
    required BuildContext context,
    required FluoTheme theme,
    required Widget navigator,
  }) {
    _apiClient.language = Localizations.localeOf(context).toLanguageTag();

    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 500;
            return Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: isWide ? 400 : double.infinity,
                  maxHeight: isWide ? 370 : double.infinity,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(isWide ? 8 : 0),
                ),
                clipBehavior: Clip.antiAlias,
                child: MultiProvider(
                  providers: [
                    Provider(create: (_) => _apiClient),
                    Provider(create: (_) => _sessionManager),
                    Provider(create: (_) => _appConfig),
                    Provider(create: (_) => theme),
                  ],
                  child: navigator,
                ),
              ),
            );
          },
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}
