import 'package:example/config.dart';
import 'package:fluo/fluo.dart';
import 'package:fluo/fluo_onboarding.dart';
import 'package:fluo/l10n/fluo_localizations.dart';
import 'package:fluo/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatefulWidget {
  const ExampleApp({super.key});

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
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
      // Very important to add 'FluoLocalizations.localizationsDelegates'
      // to make sure that the Fluo SDK works correctly.
      localizationsDelegates: FluoLocalizations.localizationsDelegates,
      supportedLocales: FluoLocalizations.supportedLocales,
      home: FutureBuilder(
        // Put your own API key here.
        future: Fluo.init(Config.apiKey),
        builder: (context, snapshot) {
          if (!Fluo.isInitialized) {
            return const Scaffold(backgroundColor: Colors.white);
          }

          if (!Fluo.instance.isUserReady()) {
            return FluoOnboarding(
              theme: _fluoTheme(),
              onUserReady: () {
                setState(() {});
              },
            );
          }

          return ConnectedScreen(
            onSignOut: () async {
              await Fluo.instance.clearSession();
              setState(() {});
            },
          );
        },
      ),
    );
  }

  FluoTheme _fluoTheme() {
    if (kIsWeb) {
      return FluoTheme.web(
        primaryColor: Colors.black,
        inversePrimaryColor: Colors.white,
      );
    }
    return FluoTheme.native(
      primaryColor: Colors.black,
      inversePrimaryColor: Colors.white,
    );
  }
}

class ConnectedScreen extends StatelessWidget {
  const ConnectedScreen({
    super.key,
    required this.onSignOut,
  });

  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You are connected'),
            FilledButton(
              onPressed: onSignOut,
              child: const Text('Sign out'),
            ),
          ],
        ),
      ),
    );
  }
}
