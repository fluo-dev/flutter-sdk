import 'package:fluo/managers/session_manager.dart';
import 'package:fluo/navigators/auth_navigator.dart';
import 'package:fluo/navigators/register_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const routeAuthUser = '/';
const routeCreateProfile = '/create-profile';

class StartNavigator extends StatefulWidget {
  const StartNavigator({
    super.key,
    required this.onExit,
    required this.onUserReady,
  });

  final Function() onExit;
  final Function() onUserReady;

  @override
  State<StartNavigator> createState() => _StartNavigatorState();
}

class _StartNavigatorState extends State<StartNavigator> {
  final _navigatorKey = GlobalKey<NavigatorState>();

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

    if (settings.name == routeAuthUser) {
      page = AuthNavigator(
        onExit: () {
          widget.onExit();
        },
        onUserAuthenticated: () {
          if (context.read<SessionManager>().isUserComplete()) {
            widget.onUserReady();
          } else {
            _navigator().popAndPushNamed(routeCreateProfile);
          }
        },
      );
    } else if (settings.name == routeCreateProfile) {
      page = RegisterNavigator(
        onUserReady: widget.onUserReady,
      );
    }

    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return page;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      settings: settings,
    );
  }
}
