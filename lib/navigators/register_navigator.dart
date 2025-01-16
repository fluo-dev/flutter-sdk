import 'package:fluo/screens/enter_first_name_screen.dart';
import 'package:fluo/screens/enter_last_name_screen.dart';
import 'package:flutter/material.dart';

const routeEnterFirstName = '/';
const routeEnterLastName = '/enter-last-name';

class RegisterNavigator extends StatefulWidget {
  const RegisterNavigator({
    super.key,
    required this.onUserReady,
  });

  final Function() onUserReady;

  @override
  State<RegisterNavigator> createState() => RegisterNavigatorState();
}

class RegisterNavigatorState extends State<RegisterNavigator> {
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

    if (settings.name == routeEnterFirstName) {
      page = EnterFirstNameScreen(
        onBackButtonPressed: null,
        onFirstNameSubmitted: () {
          _navigator().pushNamed(routeEnterLastName);
        },
      );
    } else if (settings.name == routeEnterLastName) {
      page = EnterLastNameScreen(
        onBackButtonPressed: _navigator().pop,
        onLastNameSubmitted: () {
          FocusManager.instance.primaryFocus?.unfocus();
          widget.onUserReady();
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
