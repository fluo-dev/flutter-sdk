import 'package:flutter/material.dart';

import '../api/models/partial_session.dart';
import '../api/models/session.dart';
import '../screens/enter_code_screen.dart';
import '../screens/enter_email_screen.dart';

const routeEnterEmail = '/';
const routeEnterCode = '/enter-code';

class AuthUserNavigator extends StatefulWidget {
  const AuthUserNavigator({
    super.key,
    required this.onExit,
    required this.onUserAuthenticated,
  });

  final Function() onExit;
  final Function(Session session) onUserAuthenticated;

  @override
  State<AuthUserNavigator> createState() => AuthUserNavigatorState();
}

class AuthUserNavigatorState extends State<AuthUserNavigator> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  PartialSession? _partialSession;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      onGenerateRoute: _onGenerateRoute,
    );
  }

  NavigatorState _navigator() {
    return _navigatorKey.currentState!;
  }

  Route<Widget> _onGenerateRoute(RouteSettings settings) {
    late Widget page;

    if (settings.name == routeEnterEmail) {
      page = EnterEmailScreen(
        onBackButtonPressed: () {
          widget.onExit();
        },
        onEmailSubmitted: (partialSession) {
          _partialSession = partialSession;
          _navigator().pushNamed(routeEnterCode);
        },
      );
    } else if (settings.name == routeEnterCode) {
      page = EnterCodeScreen(
        partialSession: _partialSession!,
        onBackButtonPressed: _navigator().pop,
        onCodeVerified: (session) {
          widget.onUserAuthenticated(session);
        },
      );
    }

    return MaterialPageRoute(
      builder: (context) {
        return page;
      },
      settings: settings,
    );
  }
}
