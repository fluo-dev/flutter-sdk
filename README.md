# Fluo

## Getting started

**STEP 1** — Get an api key by creating an account on the [Fluo dashboard](https://dashboard.fluo.dev/signup).

**STEP 2** — Add the package to your dependencies:

```bash
flutter pub add fluo
```

**STEP 3** — Add the `FluoLocalizations.delegate` to your App:

```dart
import 'package:fluo/l10n/fluo_localizations.dart';

MaterialApp(
  localizationsDelegates: const [
    // ...other delegates...
    FluoLocalizations.delegate, // Add this line
  ],
)
```

## Usage

Here is a basic snippet to get the idea:

```dart
final fluo = await Fluo.init('your-api-key');
final accessToken = await fluo.getAccessToken();
if (accessToken == null) {
  fluo.showConnectFlow(
    context: context,
    onUserReady: () async {
      final accessToken = await fluo.getAccessToken();
      // All good, you can pass 'accessToken' to your server requests
    },
  );
} else {
  // All good, you can pass 'accessToken' to your server requests
}
```

Always use `getAccessToken` to get a _fresh_ access token:

```dart
void _onUpdateFirstName(String firstName) async {
  final accessToken = await fluo.getAccessToken();
  await apiClient.updateUser(
    accessToken: accessToken,
    firstName: firstName,
  );
}
```

Below is a more comprehensive example:

```dart
import 'package:fluo/fluo.dart';
import 'package:flutter/material.dart';

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
    Fluo.init('your-api-key').then((fluo) async {
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
        final accessToken = await _fluo!.getAccessToken();
        setState(() => _accessToken = accessToken);
      },
    );
  }
}
```

## Advanced topics

### Theming

If you like the Fluo theme, you can keep most of it and extend some components, as shown below:

```dart
import 'package:fluo/theme.dart';
import 'package:flutter/material.dart';

class ExampleAppTheme {
  static ThemeData defaultTheme(BuildContext context) {
    final colorScheme = ColorScheme.light(
      surface: Colors.white,
      onSurface: Colors.black,
      surfaceContainer: Colors.white24,
      primary: Colors.black,
      onPrimary: Colors.white,
      secondary: Colors.black45,
      error: Colors.red.shade400,
    );

    final fluoTheme = FluoTheme.defaultTheme(context, colorScheme);
    final fluoExtended = fluoTheme.copyWith(
      colorScheme: colorScheme,
      textTheme: fluoTheme.textTheme.copyWith(
        headlineLarge: fluoTheme.textTheme.headlineLarge?.copyWith(
          fontSize: 60,
          fontWeight: FontWeight.w700,
          height: 1,
          letterSpacing: -2,
        ),
        displaySmall: fluoTheme.textTheme.displaySmall?.copyWith(
          fontSize: 40,
          fontWeight: FontWeight.w700,
          height: 1,
          letterSpacing: -1,
        ),
      ),
    );
    return fluoExtended;
  }
}
```
