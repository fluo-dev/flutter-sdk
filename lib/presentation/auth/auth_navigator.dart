import 'package:fluo/api/models/partial_session.dart';
import 'package:fluo/managers/session_manager.dart';
import 'package:fluo/presentation/auth/enter_code_screen.dart';
import 'package:fluo/presentation/auth/enter_email_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const routeEnterEmail = '/';
const routeEnterCode = '/enter-code';

class AuthNavigator extends StatefulWidget {
  const AuthNavigator({
    super.key,
    required this.onExit,
    required this.onUserAuthenticated,
  });

  final Function() onExit;
  final Function() onUserAuthenticated;

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
        onCodeVerified: (session) async {
          await context.read<SessionManager>().setSession(session);
          widget.onUserAuthenticated();
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
