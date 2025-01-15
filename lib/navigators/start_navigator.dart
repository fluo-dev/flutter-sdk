import 'package:flutter/material.dart';

import '../api/models/session.dart';
import 'auth_user_navigator.dart';
import 'create_profile_navigator.dart';

const routeAuthUser = '/';
const routeCreateProfile = '/create-profile';

class StartNavigator extends StatefulWidget {
  const StartNavigator({
    super.key,
    required this.onExit,
    required this.onSessionReady,
    required this.onUserReady,
  });

  final Function() onExit;
  final Function(Session session) onSessionReady;
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
      page = AuthUserNavigator(
        onExit: () {
          widget.onExit();
        },
        onUserAuthenticated: (session) {
          widget.onSessionReady(session);
          if (session.userProfileComplete) {
            widget.onUserReady();
          } else {
            _navigator().popAndPushNamed(routeCreateProfile);
          }
        },
      );
    } else if (settings.name == routeCreateProfile) {
      page = CreateProfileNavigator(
        onProfileComplete: () {
          widget.onUserReady();
        },
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
