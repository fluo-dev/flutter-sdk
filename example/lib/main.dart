import 'package:example/theme.dart';
import 'package:fluo/fluo.dart';
import 'package:fluo/l10n/fluo_localizations.dart';
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
      theme: ExampleAppTheme.defaultTheme(context),
      home: const Scaffold(
        body: ConnectScreen(),
      ),
    );
  }
}

const String fluoApiKey = 'your-api-key';

class ConnectScreen extends StatefulWidget {
  const ConnectScreen({super.key});

  @override
  State<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  Fluo? _fluo;
  bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    Fluo.init(fluoApiKey).then((fluo) async {
      final accessToken = await fluo.getAccessToken();
      setState(() {
        _fluo = fluo;
        _isAuthenticated = accessToken != null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _createContent(context),
      ),
    );
  }

  Widget _createContent(BuildContext context) {
    if (_fluo == null) {
      return const CircularProgressIndicator();
    }

    if (!_isAuthenticated) {
      return FilledButton(
        onPressed: () => _onConnect(context),
        child: const Text('Connect'),
      );
    }

    return const Text('You are connected');
  }

  void _onConnect(BuildContext context) {
    _fluo!.showConnectFlow(
      context: context,
      onUserReady: () async {
        setState(() {
          _isAuthenticated = true;
        });
      },
    );
  }
}
