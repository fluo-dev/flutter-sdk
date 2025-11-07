import 'package:fluo/widgets/round_button.dart';
import 'package:flutter/material.dart';

class FluoNavigatorStyle {
  const FluoNavigatorStyle({
    this.topBarPadding = const EdgeInsets.only(
      left: 20,
      right: 20,
    ),
    this.backButtonColor = Colors.black,
    this.progressIndicatorMinHeight = 6,
    this.progressIndicatorBorderRadius = const BorderRadius.all(
      Radius.circular(3),
    ),
    this.progressIndicatorColor = Colors.black,
    this.progressIndicatorBackgroundColor = const Color(0x10000000),
  });

  final EdgeInsets topBarPadding;
  final Color backButtonColor;
  final double progressIndicatorMinHeight;
  final BorderRadiusGeometry progressIndicatorBorderRadius;
  final Color progressIndicatorColor;
  final Color progressIndicatorBackgroundColor;
}

class FluoNavigator extends StatefulWidget {
  const FluoNavigator({
    super.key,
    required this.initialRoute,
    required this.totalSteps,
    required this.onGenerateRoute,
    this.style = const FluoNavigatorStyle(),
    this.introOnFirstRoute = true,
  });

  final String initialRoute;
  final int totalSteps;
  final RouteFactory? onGenerateRoute;
  final FluoNavigatorStyle style;
  final bool introOnFirstRoute;

  @override
  State<FluoNavigator> createState() => FluoNavigatorState();
}

class FluoNavigatorState extends State<FluoNavigator> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  final List<int> _stepIncrements = [];

  @override
  void initState() {
    super.initState();
    if (!widget.introOnFirstRoute) {
      // If the first route is not used as an intro screen,
      // it means that the first route is a step of the flow
      // and we need to reflect that in the progress bar.
      _stepIncrements.add(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          spacing: 20,
          children: [
            AnimatedOpacity(
              opacity: _stepIncrements.isEmpty ? 0 : 1,
              duration: const Duration(milliseconds: 300),
              child: Padding(
                padding: widget.style.topBarPadding,
                child: Row(
                  spacing: 20,
                  children: [
                    RoundButton(
                      onPressed: pop,
                      color: widget.style.backButtonColor,
                    ),
                    Expanded(
                      child: TweenAnimationBuilder<double>(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        tween: Tween<double>(
                          begin: 0,
                          end: _stepIncrementsSum() / widget.totalSteps,
                        ),
                        builder: (context, value, _) => LinearProgressIndicator(
                          value: value,
                          minHeight: 6,
                          color: widget.style.progressIndicatorColor,
                          backgroundColor:
                              widget.style.progressIndicatorBackgroundColor,
                          borderRadius:
                              widget.style.progressIndicatorBorderRadius,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Navigator(
                key: _navigatorKey,
                initialRoute: widget.initialRoute,
                onGenerateRoute: widget.onGenerateRoute,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void pop() {
    _navigatorKey.currentState?.pop();
    _stepIncrements.removeLast();
    setState(() {});
  }

  void pushNamed(
    String routeName, {
    int stepIncrement = 1,
    Object? arguments,
  }) {
    _navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
    _stepIncrements.add(stepIncrement);
    setState(() {});
  }

  int _stepIncrementsSum() {
    return _stepIncrements.fold(0, (a, b) => a + b);
  }
}
