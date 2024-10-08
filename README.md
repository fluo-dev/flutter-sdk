# Fluo

## Installation

Add the package to your dependencies:

```bash
flutter pub add fluo
```

Add the `FluoLocalizations.delegate` to your App:

```dart
import 'package:fluo/l10n/fluo_localizations.dart';

MaterialApp(
  localizationsDelegates: const [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    FluoLocalizations.delegate, // Add this line
  ],
  // ...
)
```

## Usage

```dart
import 'package:fluo/fluo.dart';

// Initialize fluo.
final fluo = await Fluo.init('your-api-key');

// Get the stored access token to determine if you should present
// the connect flow to the user.
String? accessToken = await fluo.getAccessToken();
if (accessToken == null) {
  // There is no valid token, show the connect flow.
  fluo.showConnectFlow(
    context: context,
    onUserReady: () {
      // You're good to go. By the way, you should never store the
      // access token, but always retrieve it using the `getAccessToken`
      // method because it takes care of refreshing it if it has expired.
      // This is why this method is async.
      accessToken = await fluo.getAccessToken();
    },
  );
} else {
  // You're good to go. You can use the access token to communicate
  // with your backend.
}
```
