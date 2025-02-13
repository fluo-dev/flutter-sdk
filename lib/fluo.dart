library fluo;

import 'package:fluo/api/api_client.dart';
import 'package:fluo/api/models/app_config.dart';
import 'package:fluo/managers/session_manager.dart';
import 'package:fluo/presentation/auth/auth_navigator.dart';
import 'package:fluo/presentation/register/register_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Fluo {
  Fluo._(this._apiClient, this._sessionManager, this._appConfig);

  final ApiClient _apiClient;

  final SessionManager _sessionManager;

  final AppConfig _appConfig;

  /// [Fluo] is the class that provides the interface for managing the
  /// user session. This method is async because it tries to load a potential
  /// session object from the secure storage and load the app configuration.
  static Future<Fluo> init(String apiKey) async {
    final apiClient = ApiClient(apiKey);
    final sessionManager = await SessionManager.init();
    await sessionManager.getSession(
      apiClient: apiClient,
      forceRefresh: true,
    );
    final appConfig = await apiClient.getAppConfig();
    return Fluo._(apiClient, sessionManager, appConfig);
  }

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

  /// Returns whether the current user is complete.
  bool isUserComplete() {
    final session = _sessionManager.session;
    if (session == null) {
      return false;
    }

    final steps = _appConfig.registrationSteps;
    for (var i = 0; i < steps.length; ++i) {
      final step = steps[i];
      if (step.fieldKey == 'firstName') {
        final firstName = session.user.firstName;
        if (firstName == null || firstName.length < 2) {
          return false;
        }
      }
      if (step.fieldKey == 'lastName') {
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
  /// [showConnectFlow].
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

  /// Returns a firebase custom token or null if there is none.
  ///
  /// Use it like this:
  ///
  ///     await FirebaseAuth.instance.signInWithCustomToken(fluo.firebaseToken!);
  ///
  /// For more information, visit: [Firebase custom tokens documentation](https://firebase.google.com/docs/auth/admin/create-custom-tokens#sign_in_using_custom_tokens_on_clients)
  String? get firebaseToken => _sessionManager.session?.firebaseToken;

  /// Returns a supabase session string or null if there is none.
  ///
  /// Use it like this:
  ///
  ///     await Supabase.instance.client.auth.recoverSession(fluo.supabaseSession!);
  ///
  String? get supabaseSession => _sessionManager.session?.supabaseSession;

  /// Shows the connect with email flow.
  ///
  /// This is a modal dialog which takes care of collecting the user's email,
  /// sending an otp, and validating the session.
  ///
  void showConnectWithEmailFlow({
    required BuildContext context,
    required Function() onUserReady,
  }) {
    _showNavigator(
      context: context,
      navigator: AuthNavigator(
        onExit: () => Navigator.of(context).pop(),
        onUserAuthenticated: () {
          Navigator.of(context).pop();
          if (isUserComplete()) {
            onUserReady();
          } else {
            showRegisterFlow(
              context: context,
              onUserReady: onUserReady,
            );
          }
        },
      ),
    );
  }

  /// Shows the register flow.
  ///
  /// This is a modal dialog which takes care of registering an already
  /// authenticated user.
  ///
  void showRegisterFlow({
    required BuildContext context,
    required Function() onUserReady,
  }) {
    _showNavigator(
      context: context,
      navigator: RegisterNavigator(
        onUserReady: onUserReady,
      ),
    );
  }

  void _showNavigator({
    required BuildContext context,
    required Widget navigator,
  }) {
    _apiClient.language = Localizations.localeOf(context).toLanguageTag();

    showGeneralDialog(
      context: context,
      barrierColor: Theme.of(context).colorScheme.surface,
      pageBuilder: (context, animation, secondaryAnimation) {
        return MultiProvider(
          providers: [
            Provider(create: (_) => _apiClient),
            Provider(create: (_) => _sessionManager),
            Provider(create: (_) => _appConfig),
          ],
          child: navigator,
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
