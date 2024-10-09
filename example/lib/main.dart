import 'package:example/connect_screen.dart';
import 'package:example/home_screen.dart';
import 'package:example/theme.dart';
import 'package:fluo/fluo.dart';
import 'package:fluo/l10n/fluo_localizations.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  static const String fluoApiKey = 'your-api-key';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: FluoLocalizations.localizationsDelegates,
      supportedLocales: FluoLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: ExampleAppTheme.defaultTheme(context),
      home: Scaffold(
        body: FutureBuilder(
          future: Fluo.init(fluoApiKey),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final fluo = snapshot.data!;
            return FutureBuilder(
              future: fluo.getAccessToken(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final accessToken = snapshot.data;
                if (accessToken == null) {
                  return ConnectScreen(fluo: fluo);
                }

                return const HomeScreen();
              },
            );
          },
        ),
      ),
    );
  }
}
