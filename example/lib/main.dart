import 'package:example/config.dart';
import 'package:fluo/fluo.dart';
import 'package:fluo/fluo_onboarding.dart';
import 'package:fluo/l10n/fluo_localizations.dart';
import 'package:fluo/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ExampleApp());
}

class ExampleApp extends StatelessWidget {
  ExampleApp({super.key});

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: const ColorScheme.light(
          surface: Colors.white,
          primary: Colors.black,
        ),
      ),
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      localizationsDelegates: FluoLocalizations.localizationsDelegates,
      supportedLocales: FluoLocalizations.supportedLocales,
      home: FluoOnboarding(
        apiKey: Config.apiKey,
        theme: _theme(),
        introBuilder: _introScreen,
        onUserReady: _onUserReady,
      ),
    );
  }

  FluoTheme _theme() {
    return FluoTheme.native(
      primaryColor: Colors.black,
      inversePrimaryColor: Colors.white,
      connectButtonStyle: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.grey.shade200),
        foregroundColor: WidgetStateProperty.all(Colors.black),
        minimumSize: WidgetStateProperty.all(const Size(200, 54)),
      ),
      connectButtonStyleApple: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.black),
        foregroundColor: WidgetStateProperty.all(Colors.white),
        minimumSize: WidgetStateProperty.all(const Size(200, 54)),
      ),
      connectButtonIconApple: const Icon(
        Icons.apple,
        color: Colors.white,
        size: 20,
      ),
      connectButtonTextStyleApple: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _introScreen(
    BuildContext context,
    bool initializing,
    bool signingIn,
    double bottomContainerHeight,
  ) {
    if (signingIn) {
      return Container(
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.only(bottom: 100),
        child: const CircularProgressIndicator(),
      );
    }
    return Center(
      child: AnimatedOpacity(
        opacity: initializing ? 0.0 : 1.0,
        duration: const Duration(seconds: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 00, bottom: 30),
              child: Text(
                '5 lines of code\nto get these',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  fontFamily: 'Caveat',
                  height: 1.2,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60, right: 160),
              child: Image.asset(
                'assets/images/arrow-down.png',
                width: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onUserReady(Fluo fluo) {
    _navigatorKey.currentState?.push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return Scaffold(
          backgroundColor: Colors.grey.shade100,
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle_rounded,
                      size: 25,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'You are connected',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        fontFamily: 'Caveat',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: 290,
                  child: Text(
                    'Now that you got to experience Fluo, are you ready for the next step?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const SizedBox(
                  width: 270,
                  child: Text(
                    'Go to dashboard.fluo.dev',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                ),
                const Spacer(),
                FilledButton(
                  onPressed: () async {
                    await fluo.clearSession();
                    _navigatorKey.currentState
                        ?.popUntil((route) => route.isFirst);
                  },
                  child: const Text('Sign out'),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        );
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    ));
  }
}
