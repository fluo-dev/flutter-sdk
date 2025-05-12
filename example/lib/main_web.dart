import 'package:fluo/fluo.dart';
import 'package:fluo/fluo_onboarding.dart';
import 'package:fluo/l10n/fluo_localizations.dart';
import 'package:fluo/theme.dart';
import 'package:flutter/material.dart';

import 'config.dart'; // Import the config file

void main() {
  runApp(ExampleApp());
}

class ExampleApp extends StatelessWidget {
  ExampleApp({super.key});

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      localizationsDelegates: FluoLocalizations.localizationsDelegates,
      supportedLocales: FluoLocalizations.supportedLocales,
      theme: ThemeData(
        fontFamily: 'Geist',
      ),
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: 700,
            height: 300,
            child: FluoOnboarding(
              apiKey: Config.apiKey,
              theme: _theme(),
              onUserReady: _onUserReady,
            ),
          ),
        ),
      ),
    );
  }

  FluoTheme _theme() {
    final defaultTheme = FluoTheme.light();

    return FluoTheme(
      primaryColor: Colors.black,
      inversePrimaryColor: Colors.white,
      connectButtonStyle: defaultTheme.connectButtonStyle.copyWith(
        backgroundColor: WidgetStateProperty.all(Colors.grey.shade200),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
        ),
        minimumSize: WidgetStateProperty.all(const Size(600, 70)),
      ),
      inputDecoration: defaultTheme.inputDecoration.copyWith(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 17.0,
          horizontal: 15.0,
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 2,
          ),
        ),
      ),
      legalTextStyle: defaultTheme.legalTextStyle.copyWith(
        fontSize: 15,
      ),
      nextButtonStyle: defaultTheme.nextButtonStyle.copyWith(
        minimumSize: WidgetStateProperty.all(const Size(600, 60)),
        backgroundColor: WidgetStateProperty.all(Colors.black),
        foregroundColor: WidgetStateProperty.all(Colors.white),
        textStyle: WidgetStateProperty.all(
          const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Geist',
          ),
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
