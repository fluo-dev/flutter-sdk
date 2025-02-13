import 'package:fluo/api/models/app_config.dart';
import 'package:fluo/presentation/register/enter_first_name_screen.dart';
import 'package:fluo/presentation/register/enter_last_name_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  late final AppConfig _config;

  @override
  void initState() {
    super.initState();
    _config = context.read<AppConfig>();
  }

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
    final screen = _screenForRouteName(settings.name!);

    return MaterialPageRoute(
      settings: settings,
      builder: (context) {
        return screen;
      },
    );
  }

  Widget _screenForRouteName(String routeName) {
    late Widget screen;

    final steps = _config.registrationSteps;
    final stepIndex = _stepIndexForRouteName(routeName);

    Function()? onBackButtonPressed;
    if (stepIndex > 0) {
      onBackButtonPressed = () => _navigator().pop();
    }

    onStepComplete() {
      final nextStepIndex = stepIndex + 1;
      if (nextStepIndex < steps.length) {
        final nextStep = steps[nextStepIndex];
        _navigator().pushNamed(nextStep.path);
      } else {
        FocusManager.instance.primaryFocus?.unfocus();
        widget.onUserReady();
      }
    }

    final step = steps[stepIndex];
    if (step.id == 'firstName') {
      screen = EnterFirstNameScreen(
        onBackButtonPressed: onBackButtonPressed,
        onFirstNameSubmitted: onStepComplete,
      );
    } else if (step.id == 'lastName') {
      screen = EnterLastNameScreen(
        onBackButtonPressed: onBackButtonPressed,
        onLastNameSubmitted: onStepComplete,
      );
    }

    return screen;
  }

  int _stepIndexForRouteName(String routeName) {
    final steps = _config.registrationSteps;
    if (steps.isEmpty) {
      return -1;
    }

    if (routeName == '/') {
      return 0;
    }

    for (var i = 0; i < steps.length; ++i) {
      if (steps[i].path == routeName) {
        return i;
      }
    }

    return -1;
  }
}
