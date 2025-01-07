import 'package:fluo/fluo_onboarding.dart';
import 'package:fluo/l10n/fluo_localizations.dart';
import 'package:fluo/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        // ...other delegates...
        FluoLocalizations.delegate,
      ],
      supportedLocales: FluoLocalizations.supportedLocales,
      theme: FluoTheme.defaultTheme(context, FluoTheme.lightColorScheme),
      home: FluoOnboarding(
        apiKey: 'your-api-key',
        onUserReady: (fluo) async {
          // Use 'fluo' to get an access token as below:
          // final accessToken = await fluo.getAccessToken();
        },
        child: Center(
          child: Text(
            'Welcome',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
      ),
    );
  }
}
