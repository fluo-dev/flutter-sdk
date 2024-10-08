import 'package:example/connect_screen.dart';
import 'package:example/home_screen.dart';
import 'package:example/theme.dart';
import 'package:fluo/fluo.dart';
import 'package:fluo/l10n/fluo_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  static const String fluoApiKey = 'your-api-key';

  @override
  Widget build(BuildContext context) {
    return FutureProvider(
      initialData: null,
      create: (_) => Fluo.init(fluoApiKey),
      child: Consumer<Fluo?>(
        builder: (context, fluo, child) {
          if (fluo == null) {
            return const CircularProgressIndicator();
          }

          return MaterialApp(
            localizationsDelegates: FluoLocalizations.localizationsDelegates,
            supportedLocales: FluoLocalizations.supportedLocales,
            debugShowCheckedModeBanner: false,
            theme: ExampleAppTheme.defaultTheme(context),
            home: FutureBuilder(
              future: fluo.getAccessToken(forceRefresh: true),
              builder: (context, snapshot) {
                // Uncomment here to clear the session
                // fluo.clearSession();
                final accessToken = snapshot.data;
                if (accessToken == null) {
                  return const ConnectScreen();
                }
                return const HomeScreen();
              },
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(const ExampleApp());
}
