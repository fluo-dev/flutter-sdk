import 'package:flutter/material.dart';

import '../screens/enter_first_name_screen.dart';
import '../screens/enter_last_name_screen.dart';

const routeEnterFirstName = '/';
const routeEnterLastName = '/enter-last-name';

class CreateProfileNavigator extends StatefulWidget {
  const CreateProfileNavigator({
    super.key,
    required this.onProfileComplete,
  });

  final Function() onProfileComplete;

  @override
  State<CreateProfileNavigator> createState() => CreateProfileNavigatorState();
}

class CreateProfileNavigatorState extends State<CreateProfileNavigator> {
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
          widget.onProfileComplete();
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
