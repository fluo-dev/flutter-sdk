/// Provides the Fluo SDK for Flutter applications.
///
/// This library allows developers to integrate Fluo authentication and user management
/// features into their Flutter apps. It handles session management, social sign-ins,
/// and provides access to user data.
library;

import 'dart:io';

import 'package:fluo/api/api_client.dart';
import 'package:fluo/api/models/app_config.dart';
import 'package:fluo/api/models/apple_web_options.dart';
import 'package:fluo/api/models/auth_method.dart';
import 'package:fluo/api/models/session.dart';
import 'package:fluo/fluo_sign_in_style.dart';
import 'package:fluo/fluo_theme.dart';
import 'package:fluo/managers/country_manager.dart';
import 'package:fluo/managers/session_manager.dart';
import 'package:fluo/presentation/auth/auth_navigator.dart';
import 'package:fluo/presentation/register/register_navigator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class Fluo {
  Fluo._(this._apiClient, this._sessionManager);

  static Fluo? _instance;

  final ApiClient _apiClient;

  final SessionManager _sessionManager;

  AppConfig? _appConfig;

  static Future<void> initWithApiKey(
    String apiKey, {
    bool useSecureStorage = true,
  }) async {
    final apiClient = ApiClient(apiKey);

    SessionManager sessionManager;
    try {
      sessionManager = await SessionManager.init(
        useSecureStorage: useSecureStorage,
      );
    } catch (e) {
      throw Exception('Failed to initialize session: $e');
    }

    _instance = Fluo._(apiClient, sessionManager);
  }

  /// This method is async because it tries to load a potential
  /// session object from the secure storage and load the app configuration.
  @Deprecated('migrate to initWithApiKey() for better control')
  static Future<void> init(String apiKey) async {
    await Fluo.initWithApiKey(apiKey);
    await Fluo.instance.loadAppConfig();
    await Fluo.instance.refreshSession();
  }

  static Fluo get instance {
    if (_instance == null) {
      throw Exception('Fluo has not been initialized.');
    }
    return _instance!;
  }

  static bool get isInitialized => _instance != null;

  /// Returns the current application configuration.
  ///
  /// Throws a [StateError] if the application configuration has not been loaded yet.
  /// Make sure to call [loadAppConfig()] before accessing this getter.
  AppConfig get appConfig {
    if (_appConfig == null) {
      throw StateError('loadAppConfig() needs to be called before');
    }
    return _appConfig!;
  }

  bool get appConfigLoaded => _appConfig != null;

  /// Loads the application configuration from the backend and
  /// updates the current app configuration.
  ///
  /// Throws an [Exception] if unable to load the app configuration.
  Future<void> loadAppConfig() async {
    try {
      _appConfig = await _apiClient.getAppConfig();
    } catch (e) {
      throw Exception('Failed to load app config: $e');
    }
  }

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

    final steps = appConfig.registrationSteps;
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

  /// Deletes the user info stored in the Fluo backend.
  ///
  /// Usually, you should call `clearSession` right after.
  Future<void> deleteUser(String accessToken) async {
    await _apiClient.deleteUser(
      accessToken: accessToken,
    );
  }

  /// Shows the connect with email flow.
  ///
  /// This is a modal dialog which takes care of collecting the user's email,
  /// sending an otp, and validating the session.
  ///
  @Deprecated('Use signInWithEmail instead')
  void showConnectWithEmailFlow({
    required BuildContext context,
    required FluoTheme theme,
    required VoidCallback onExit,
    required VoidCallback onUserReady,
  }) {
    signInWithEmail(
      context: context,
      style: _convertThemeToSignInStyle(theme),
      onExit: onExit,
      onUserReady: onUserReady,
    );
  }

  /// Starts the email sign-in flow.
  ///
  /// This displays a modal dialog that collects the user's email,
  /// sends a verification code, and validates the session.
  ///
  /// Parameters:
  /// - [context]: The build context.
  /// - [style]: Optional style configuration for the sign-in screens.
  ///   If not provided, uses default native or web style based on platform.
  /// - [onExit]: Called when the user dismisses the flow without completing.
  /// - [onUserReady]: Called when the user successfully signs in and
  ///   completes all required registration steps.
  ///
  void signInWithEmail({
    required BuildContext context,
    FluoSignInStyle? style,
    required VoidCallback onExit,
    required VoidCallback onUserReady,
  }) {
    style ??= kIsWeb ? FluoSignInStyle.web() : FluoSignInStyle.native();
    _showNavigator(
      context: context,
      style: style,
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
            _showRegisterFlow(
              context: context,
              style: style!,
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
  @Deprecated('Use signInWithMobile instead')
  void showConnectWithMobileFlow({
    required BuildContext context,
    required FluoTheme theme,
    required VoidCallback onExit,
    required VoidCallback onUserReady,
  }) {
    signInWithMobile(
      context: context,
      style: _convertThemeToSignInStyle(theme),
      onExit: onExit,
      onUserReady: onUserReady,
    );
  }

  /// Starts the mobile sign-in flow.
  ///
  /// This displays a modal dialog that collects the user's mobile number,
  /// sends a verification code via SMS, and validates the session.
  ///
  /// Parameters:
  /// - [context]: The build context.
  /// - [style]: Optional style configuration for the sign-in screens.
  ///   If not provided, uses default native or web style based on platform.
  /// - [onExit]: Called when the user dismisses the flow without completing.
  /// - [onUserReady]: Called when the user successfully signs in and
  ///   completes all required registration steps.
  ///
  void signInWithMobile({
    required BuildContext context,
    FluoSignInStyle? style,
    required VoidCallback onExit,
    required VoidCallback onUserReady,
  }) {
    CountryManager.init();
    style ??= kIsWeb ? FluoSignInStyle.web() : FluoSignInStyle.native();
    _showNavigator(
      context: context,
      style: style,
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
            _showRegisterFlow(
              context: context,
              style: style!,
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
        .firstWhere((method) => method.id == AuthMethodId.google)
        .googleClientId!;
    if (kIsWeb) {
      return googleClientId.web;
    }
    if (Platform.isIOS || Platform.isMacOS) {
      return googleClientId.ios;
    }
    if (Platform.isAndroid) {
      return googleClientId.android;
    }
    return '';
  }

  AppleWebOptions? getAppleWebOptions() {
    if (!kIsWeb && Platform.isIOS) {
      return null;
    }
    return appConfig.authMethods
        .firstWhere((method) => method.id == AuthMethodId.apple)
        .appleWebOptions;
  }

  /// Shows the Google Sign-in flow.
  ///
  /// This is a modal dialog which takes care of signing in the user's google
  /// account and creating the fluo session.
  ///
  @Deprecated('Use signInWithGoogle instead')
  Future<bool> showConnectWithGoogleFlow({
    required BuildContext context,
    required FluoTheme theme,
    required VoidCallback onBeforeSessionCreation,
    required VoidCallback onUserReady,
    List<String> scopes = const ['email'],
  }) async {
    return signInWithGoogle(
      context: context,
      style: _convertThemeToSignInStyle(theme),
      onBeforeSessionCreation: onBeforeSessionCreation,
      onUserReady: onUserReady,
      scopes: scopes,
    );
  }

  /// Starts the Google sign-in flow.
  ///
  /// This uses the native Google Sign-In UI to authenticate the user
  /// and creates a Fluo session.
  ///
  /// Parameters:
  /// - [context]: The build context.
  /// - [style]: Optional style configuration for registration screens
  ///   (shown if user needs to complete registration after sign-in).
  /// - [onBeforeSessionCreation]: Called after Google authentication is successful
  ///   but before creating the Fluo session. This provides an opportunity to show
  ///   a loading indicator while Fluo processes the authentication.
  /// - [onUserReady]: Called when the Fluo session is successfully created and
  ///   all registration parameters (like first name and last name) have been
  ///   collected and verified.
  /// - [scopes]: OAuth scopes to request. Defaults to ['email'].
  ///
  /// Returns `true` if sign-in was successful, `false` if the user cancelled.
  ///
  Future<bool> signInWithGoogle({
    required BuildContext context,
    FluoSignInStyle? style,
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

    style ??= kIsWeb ? FluoSignInStyle.web() : FluoSignInStyle.native();
    await _createSession(
      context: context,
      style: style,
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
  @Deprecated('Use signInWithApple instead')
  Future<bool> showConnectWithAppleFlow({
    required BuildContext context,
    required FluoTheme theme,
    required VoidCallback onBeforeSessionCreation,
    required VoidCallback onUserReady,
  }) async {
    return signInWithApple(
      context: context,
      style: _convertThemeToSignInStyle(theme),
      onBeforeSessionCreation: onBeforeSessionCreation,
      onUserReady: onUserReady,
    );
  }

  /// Starts the Apple sign-in flow.
  ///
  /// This uses the native Apple Sign-In UI to authenticate the user
  /// and creates a Fluo session.
  ///
  /// Parameters:
  /// - [context]: The build context.
  /// - [style]: Optional style configuration for registration screens
  ///   (shown if user needs to complete registration after sign-in).
  /// - [onBeforeSessionCreation]: Called after Apple authentication is successful
  ///   but before creating the Fluo session. This provides an opportunity to show
  ///   a loading indicator while Fluo processes the authentication.
  /// - [onUserReady]: Called when the Fluo session is successfully created and
  ///   all registration parameters (like first name and last name) have been
  ///   collected and verified.
  ///
  /// Returns `true` if sign-in was successful, `false` if the user cancelled.
  ///
  Future<bool> signInWithApple({
    required BuildContext context,
    FluoSignInStyle? style,
    required VoidCallback onBeforeSessionCreation,
    required VoidCallback onUserReady,
  }) async {
    try {
      WebAuthenticationOptions? webAuthOptions;
      final webConfig = getAppleWebOptions();
      if (webConfig != null) {
        webAuthOptions = WebAuthenticationOptions(
          clientId: webConfig.clientId,
          redirectUri: Uri.parse(webConfig.redirectUri),
        );
      }
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: webAuthOptions,
      );

      if (!context.mounted) {
        return false;
      }

      onBeforeSessionCreation();

      style ??= kIsWeb ? FluoSignInStyle.web() : FluoSignInStyle.native();
      await _createSession(
        context: context,
        style: style,
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
  @Deprecated('This method is for internal use. Use signInWith* methods instead.')
  Future<void> createSession({
    required BuildContext context,
    required FluoTheme theme,
    required VoidCallback onUserReady,
    String? googleIdToken,
    String? appleIdToken,
    String? firstName,
    String? lastName,
  }) async {
    await _createSession(
      context: context,
      style: _convertThemeToSignInStyle(theme),
      onUserReady: onUserReady,
      googleIdToken: googleIdToken,
      appleIdToken: appleIdToken,
      firstName: firstName,
      lastName: lastName,
    );
  }

  Future<void> _createSession({
    required BuildContext context,
    required FluoSignInStyle style,
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
      _showRegisterFlow(
        context: context,
        style: style,
        onUserReady: onUserReady,
      );
    }
  }

  /// Shows the register flow.
  ///
  /// This is a modal dialog which takes care of registering an already
  /// authenticated user.
  ///
  @Deprecated('Use signInWith* methods instead, which handle registration automatically.')
  void showRegisterFlow({
    required BuildContext context,
    required FluoTheme theme,
    required VoidCallback onUserReady,
  }) {
    _showRegisterFlow(
      context: context,
      style: _convertThemeToSignInStyle(theme),
      onUserReady: onUserReady,
    );
  }

  void _showRegisterFlow({
    required BuildContext context,
    required FluoSignInStyle style,
    required VoidCallback onUserReady,
  }) {
    _showNavigator(
      context: context,
      style: style,
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
    required FluoSignInStyle style,
    required Widget navigator,
  }) {
    _apiClient.language = Localizations.localeOf(context).toLanguageTag();

    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final isSafeMacOS = !kIsWeb && Platform.isMacOS;
            final showBox = constraints.maxWidth > 500 || isSafeMacOS;
            return Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: showBox ? 400 : double.infinity,
                  maxHeight: showBox ? 420 : double.infinity,
                ),
                decoration: BoxDecoration(
                  color: style.backgroundColor,
                  borderRadius: BorderRadius.circular(showBox ? 8 : 0),
                ),
                clipBehavior: Clip.antiAlias,
                child: MultiProvider(
                  providers: [
                    Provider(create: (_) => _apiClient),
                    Provider(create: (_) => _sessionManager),
                    Provider(create: (_) => _appConfig),
                    Provider(create: (_) => style),
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

  /// Converts a FluoTheme to FluoSignInStyle for backwards compatibility.
  FluoSignInStyle _convertThemeToSignInStyle(FluoTheme theme) {
    return FluoSignInStyle(
      padding: theme.screenPadding,
      backButtonColor: theme.primaryColor,
      titleTextStyle: theme.titleStyle,
      inputTextStyle: theme.inputTextStyle,
      inputTextAlignVertical: theme.inputTextAlignVertical,
      inputErrorTextStyle: theme.inputErrorStyle,
      codeInputThemeDefault: theme.codeInputThemeDefault,
      codeInputThemeFocused: theme.codeInputThemeFocused,
      codeInputThemeSubmitted: theme.codeInputThemeSubmitted,
      codeInputThemeFollowing: theme.codeInputThemeFollowing,
      codeInputThemeDisabled: theme.codeInputThemeDisabled,
      codeInputThemeError: theme.codeInputThemeError,
      continueButtonStyle: theme.continueButtonStyle,
      continueButtonProgressIndicatorSize: theme.continueButtonProgressIndicatorSize,
      continueButtonProgressIndicatorColor: theme.continueButtonProgressIndicatorColor,
      continueButtonProgressIndicatorStrokeWidth: theme.continueButtonProgressIndicatorStrokeWidth,
      countryItemPadding: theme.countryItemPadding,
      countryItemHighlightColor: theme.countryItemHighlightColor,
      countryTextStyle: theme.countryTextStyle,
    );
  }
}
