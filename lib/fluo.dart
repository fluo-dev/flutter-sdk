library fluo;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'api/api_client.dart';
import 'api/models/app_config.dart';
import 'managers/session_manager.dart';
import 'navigators/start_navigator.dart';

class Fluo {
  Fluo._(this._apiClient, this._sessionManager, this._appConfig);

  final ApiClient _apiClient;

  final SessionManager _sessionManager;

  final AppConfig _appConfig;

  /// [Fluo] is the class that provides the interface for managing the
  /// user session and showing onboarding flows. This method is async
  /// because it tries to load a potential session object from the secure
  /// storage. It also gets the remote config of your app from the Fluo
  /// server.
  ///
  /// Use it like this:
  ///
  ///     final fluo = await Fluo.init('yourApiKey');
  ///     final accessToken = await fluo.getAccessToken();
  static Future<Fluo> init(String apiKey) async {
    final apiClient = ApiClient(apiKey);
    final sessionManager = await SessionManager.init();
    final appConfig = await apiClient.getAppConfig();
    return Fluo._(apiClient, sessionManager, appConfig);
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

  /// Clears the session saved in secure storage.
  ///
  /// This method can be useful if the user is stuck on an old session
  /// and you want to force the start of a brand new session, for example
  /// after a migration.
  ///
  static Future<void> clearSession() async {
    await SessionManager.clearSession();
  }

  /// Shows the connect flow.
  ///
  /// This is a modal dialog which takes care of everything to get
  /// a valid user session.
  ///
  void showConnectFlow({
    required BuildContext context,
    required Function() onUserReady,
  }) {
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
          child: StartNavigator(
            onExit: () => Navigator.of(context).pop(),
            onSessionReady: (session) async {
              await _sessionManager.setSession(session);
            },
            onUserReady: onUserReady,
          ),
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
