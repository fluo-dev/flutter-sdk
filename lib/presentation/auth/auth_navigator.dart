import 'package:fluo/api/models/partial_session.dart';
import 'package:fluo/managers/session_manager.dart';
import 'package:fluo/presentation/auth/enter_code_screen.dart';
import 'package:fluo/presentation/auth/enter_email_screen.dart';
import 'package:fluo/presentation/auth/enter_mobile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthNavigator extends StatefulWidget {
  const AuthNavigator({
    super.key,
    required this.initialRoute,
    required this.onExit,
    required this.onUserAuthenticated,
  });

  static const routeEnterEmail = '/enter-email';
  static const routeEnterMobile = '/enter-mobile';
  static const routeEnterCode = '/enter-code';

  final String initialRoute;
  final VoidCallback onExit;
  final VoidCallback onUserAuthenticated;

  @override
  State<AuthNavigator> createState() => AuthNavigatorState();
}

class AuthNavigatorState extends State<AuthNavigator> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  PartialSession? _partialSession;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      initialRoute: widget.initialRoute,
      onGenerateRoute: _onGenerateRoute,
    );
  }

  NavigatorState _navigator() {
    return _navigatorKey.currentState!;
  }

  Route<Widget> _onGenerateRoute(RouteSettings settings) {
    late Widget page;

    if (settings.name == AuthNavigator.routeEnterEmail) {
      page = EnterEmailScreen(
        onBack: () {
          widget.onExit();
        },
        onEmailSubmitted: (partialSession) {
          _partialSession = partialSession;
          _navigator().pushNamed(AuthNavigator.routeEnterCode);
        },
      );
    } else if (settings.name == AuthNavigator.routeEnterMobile) {
      page = EnterMobileScreen(
        onBack: () {
          widget.onExit();
        },
        onMobileSubmitted: (partialSession) {
          _partialSession = partialSession;
          _navigator().pushNamed(AuthNavigator.routeEnterCode);
        },
      );
    } else if (settings.name == AuthNavigator.routeEnterCode) {
      page = EnterCodeScreen(
        partialSession: _partialSession!,
        onBack: _navigator().pop,
        onCodeVerified: (session) async {
          await context.read<SessionManager>().setSession(session);
          widget.onUserAuthenticated();
        },
      );
    } else {
      // This is to avoid an exception because navigators always start
      // with a "/" route even when an initial route is set.
      page = const SizedBox.shrink();
    }

    return MaterialPageRoute(
      settings: settings,
      builder: (context) {
        return page;
      },
    );
  }
}
