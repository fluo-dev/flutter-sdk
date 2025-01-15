import 'package:fluo/fluo.dart';
import 'package:fluo/fluo_onboarding.dart';
import 'package:fluo/l10n/fluo_localizations.dart';
import 'package:fluo/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ExampleApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Fluo.clearSession();
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        // ...other delegates...
        FluoLocalizations.delegate,
      ],
      supportedLocales: FluoLocalizations.supportedLocales,
      theme: FluoTheme.defaultTheme(context, FluoTheme.lightColorScheme),
      home: FluoOnboarding(
        apiKey: '9XkkhHRlJk7K3BBq1DCPzB-EFm20m8V357QdFORWVao=',
        onUserReady: _onUserReady,
        child: Container(
          // color: Colors.yellow.shade200,
          width: double.infinity,
          padding: const EdgeInsets.all(30.0),
          alignment: Alignment.center,
          child: Text(
            'Fluo + Firebase',
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
      ),
    );
  }

  void _onUserReady(Fluo fluo) {
    navigatorKey.currentState?.push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return Scaffold(
          backgroundColor: Colors.grey.shade100,
          body: const Center(
            child: Icon(
              Icons.check_circle_rounded,
              size: 60,
            ),
          ),
        );
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Fade transition
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    ));
  }
}
