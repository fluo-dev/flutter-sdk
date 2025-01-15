import 'package:example/theme.dart';
import 'package:fluo/fluo.dart';
import 'package:fluo/fluo_onboarding.dart';
import 'package:fluo/l10n/fluo_localizations.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ExampleApp());
}

class ExampleApp extends StatelessWidget {
  ExampleApp({super.key});

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      localizationsDelegates: FluoLocalizations.localizationsDelegates,
      supportedLocales: FluoLocalizations.supportedLocales,
      theme: ExampleAppTheme.defaultTheme(context),
      home: FluoOnboarding(
        apiKey: '-fLPzO4S2LFoD8I_GzMnVSDvKIwTsFxCdQyO3WdHAdQ=',
        onUserReady: _onUserReady,
        child: _tryMe(),
      ),
    );
  }

  Widget _tryMe() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 65, right: 20),
          child: Text(
            'Try me',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 30,
              fontFamily: 'Caveat',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 120, right: 100),
          child: Image.asset(
            'assets/images/arrow-down.png',
            width: 50,
          ),
        ),
      ],
    );
  }

  void _onUserReady(Fluo fluo) {
    navigatorKey.currentState?.push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return Scaffold(
          backgroundColor: Colors.grey.shade100,
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                  width: 250,
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
                  width: 250,
                  child: Text(
                    'Click "Get started" in the top bar',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                    ),
                  ),
                ),
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
