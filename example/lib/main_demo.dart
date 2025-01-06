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
      debugShowCheckedModeBanner: false,
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
  String? _accessToken;

  @override
  void initState() {
    super.initState();
    Fluo.clearSession();
    Fluo.init(fluoApiKey).then((fluo) async {
      final accessToken = await fluo.getAccessToken();
      setState(() {
        _fluo = fluo;
        _accessToken = accessToken;
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

    if (_accessToken == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: FilledButton(
              style: const ButtonStyle(
                  minimumSize: WidgetStatePropertyAll(Size(220, 55))),
              onPressed: () => _onConnect(context),
              child: const Text('Connect'),
            ),
          ),
          Row(
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
                padding: const EdgeInsets.only(top: 20, right: 130),
                child: Image.asset(
                  'assets/images/arrow-up.png',
                  width: 50,
                ),
              ),
            ],
          ),
        ],
      );
    }

    return const Text('You are connected');
  }

  void _onConnect(BuildContext context) {
    _fluo!.showConnectFlow(
      context: context,
      onUserReady: () async {
        final accessToken = await _fluo!.getAccessToken();
        setState(() => _accessToken = accessToken);
      },
    );
  }
}
