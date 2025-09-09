# Fluo

> **📝 Looking for the full documentation?
> [Check out the new Fluo SDK docs →](https://docs.page/fluo-dev/flutter-sdk)**

- [Getting started](#getting-started)
- [More about the SDK](#more-about-the-sdk)
- [Integrating with Firebase](#integrating-with-firebase)
- [Integrating with Supabase](#integrating-with-supabase)
- [Integrating with any backend](#integrating-with-any-backend)
- [Customizing the theme](#Customizing-the-theme)

## Getting started

Add the package to your dependencies:

```bash
flutter pub add fluo
```

Add the `FluoLocalizations.delegate` to your app's `localizationsDelegates`:

```dart
MaterialApp(
  // ...other properties...
  localizationsDelegates: const [
    FluoLocalizations.delegate,
    // ...other delegates...
  ],
)
```

Use the Fluo SDK:

```dart
import 'package:fluo/fluo.dart';
import 'package:fluo/fluo_onboarding.dart';

FutureBuilder(
  // Get your api key from https://dashboard.fluo.dev (it's free)
  future: Fluo.init('YOUR_API_KEY'),
  builder: (context, snapshot) {
    // Check if Fluo is initialized.
    if (!Fluo.isInitialized) {
      return const Scaffold();
    }

    // Fluo is initialized. Check if the user is ready.
    if (!Fluo.instance.isUserReady()) {
      return FluoOnboarding(
        fluoTheme: FluoTheme.native(), // or FluoTheme.web()
        onUserReady: () => setState(() {}), // force build
      );
    }

    // User is ready!
    // An example `ConnectedScreen` widget is available in
    // the example/lib/main.dart file.
    return ConnectedScreen(
      onSignOut: () async {
        await Fluo.instance.clearSession();
        setState(() {});
      },
    );
  },
)
```

**For macOS**, make sure you have networking allowed by adding this key to both `{your-app}/macos/Runner/DebugProfile.entitlements` and `{your-app}/macos/Runner/Release.entitlements`:

```xml
<dict>
	<!-- Add this key set to true -->
	<key>com.apple.security.network.client</key>
	<true/>
</dict>
```

## More about the SDK

Below are the most important methods to know:

```dart
// Initialize the SDK
await Fluo.init('YOUR_API_KEY');

// Check if init is done
if (Fluo.isInitialized) {
  // ...
}

// Check if user is ready (valid session + complete user attributes)
if (Fluo.instance.isUserReady()) {
  // ...
}

// Only check if a session exists
if (Fluo.instance.hasSession()) {
  // ...
}

// Get a certified fresh access token. "Certified fresh" means that
// if the access token has expired, Fluo will first refresh it before
// returning it. This is an important method if you selected a "custom"
// backend.
String accessToken = await Fluo.instance.getAccessToken();

// Force refresh the session. Generally, you should not need it because
// `Fluo.instance.getAccessToken()` handles refreshing the session.
await Fluo.instance.refreshSession();

// Clear the locally stored token. This is equivalent to a sign out.
await Fluo.instance.clearSession();

// User data
String userId = Fluo.instance.session.user.id; // "jzi8w7bdou4m0kq"
String email = Fluo.instance.session.user.email; // "peter.parker@marvel.com"
String mobileE164 = Fluo.instance.session.user.mobileE164; // "+14155556766"
String mobileIso2 = Fluo.instance.session.user.mobileIso2; // "US"
String firstName = Fluo.instance.session.user.firstName; // "Peter"
String lastName = Fluo.instance.session.user.lastName; // "Parker"

// If you build your own connect screen (and don't use FluoOnboarding)
// When authentication is done, these flows will automatically show the
// registration steps (you don't need to call `showRegisterFlow`).
Fluo.instance.showConnectWithEmailFlow(/* ... */)
Fluo.instance.showConnectWithMobileFlow(/* ... */)
Fluo.instance.showConnectWithGoogleFlow(/* ... */)
Fluo.instance.showConnectWithAppleFlow(/* ... */)

// Force show the registration steps. Generally, you should not need it.
Fluo.instance.showRegisterFlow(/* ... */)
```

## Integrating with Firebase

Select 'Firebase' for your backend. Once complete, when users are onboarded, Fluo forwards their info to:

1. the Firebase Authentication service
2. a `users` table created automatically in the Firestore Database (make sure the Firestore Database is initialized)

Back to your app code, to initialize correctly the Firebase session, use the `Fluo.instance.session.firebaseToken` as below:

```dart
// 1. Initialize the Firebase client somewhere in your code
// 2. Make sure Fluo is initialized and has a session
// 3. Use 'signInWithCustomToken' as shown below
if (Fluo.isInitialized) {
  final fluoSession = Fluo.instance.session;
  if (fluoSession != null) {
    final firebaseToken = fluoSession.firebaseToken!;
    await FirebaseAuth.instance.signInWithCustomToken(firebaseToken);
  }
}
```

## Integrating with Supabase

Select 'Supabase' for your backend. Once complete, when users are onboarded, Fluo forwards their info to:

1. the Supabase Authentication service
2. a `users` table that you will create as part of the Supabase setup (no worries, it's a simple copy-paste)

Back to your app code, to initialize correctly the Supabase session, use the `Fluo.instance.session.supabaseSession` as below:

```dart
// 1. Initialize the Supabase client somewhere in your code
// 2. Make sure Fluo is initialized and has a session
// 3. Use 'recoverSession' as shown below
if (Fluo.isInitialized) {
  final fluoSession = Fluo.instance.session;
  if (fluoSession != null) {
    final supabaseSession = fluoSession.supabaseSession!;
    await Supabase.instance.client.auth.recoverSession(supabaseSession);
  }
}
```

## Integrating with any backend

Select 'Custom' for your backend. The general idea is to use the JWT access token provided by Fluo to get a unique user id via the `"sub"` JWT claim.

Here is a full example to understand how it works:

1. Wherever you need it, call `Fluo.instance.getAccessToken()` to get the JWT access token generated by Fluo and send it to your backend.

```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

// Example of a function that gets a user. If the user
// doesn't exist yet, it should create it first.
Future<User> getOrCreateUser() async {
  final accessToken = await Fluo.instance.getAccessToken();
  final response = await http.post(
    Uri.parse('https://your-backend.com/api/user/me'),
    // Send the JWT access token to securely authenticate
    // the user and retrieve the user id.
    headers: {
      'authorization': 'Bearer $accessToken',
    },
    // Send the user data to create or update the user if
    // the object does not exist yet.
    body: jsonEncode(Fluo.instance.session.user),
  );
  return User.fromJson(jsonDecode(response.body));
}
```

2. In your backend, decode the access token to get the JWT payload.

```js
const jwt = require("jsonwebtoken")

// This is your JWT secret key (do not share it with anyone)
// You can find it on https://dashboard.fluo.dev/backend
const SECRET_KEY = "YOUR_SECRET_KEY"

// Following on the example, here is the corresponding endpoint.
// Note that this is simplified and does not handle all edge cases.
app.post("/api/user/me", async (req, res) => {
  const accessToken = req.headers["authorization"].split(" ")[1]

  // Decode the access token using your secret key
  const payload = jwt.verify(accessToken, SECRET_KEY)

  // 'payload.sub' contains a unique user id generated by Fluo
  const userId = payload.sub

  // Find the user by id
  let user = await User.findOne({ id: userId }) // or { fluoId: userId }

  // If the user doesn't exist, create it
  if (!user) {
    const { email, mobileE164, mobileIso2, firstName, lastName } = req.body
    user = await User.create({
      id: userId,
      email: email,
      mobileE164: mobileE164,
      mobileIso2: mobileIso2,
      firstName: firstName,
      lastName: lastName,
    })
  }

  return res.status(200).json(user)
})
```

3. If you need to go further, here is a complete example of the payload. For example, for increased security, you might want to verify that the token has not expired.

```js
{
  "sub": "2rztxukf57pnjz9", // user id
  "iat": 1744039599, // issued at
  "exp": 1744043199, // expires 1 hour after being issued
  "iss": "fluo.dev", // issuer
}
```

## Customizing the theme

Pass a `FluoTheme` to the `FluoOnboarding` component.

**For iOS, Android, macOS**

```dart
FluoOnboarding(
  // ...other properties...
  fluoTheme: FluoTheme.native(/* parameters */),
)
```

**For web**

```dart
FluoOnboarding(
  // ...other properties...
  fluoTheme: FluoTheme.web(/* parameters */),
)
```

**Parameters**

```dart
{
  Color? primaryColor,
  Color? inversePrimaryColor,
  Color? accentColor,
  EdgeInsets? screenPadding,
  ButtonStyle? connectButtonStyle,
  ButtonStyle? connectButtonStyleGoogle,
  ButtonStyle? connectButtonStyleApple,
  TextStyle? connectButtonTextStyle,
  TextStyle? connectButtonTextStyleGoogle,
  TextStyle? connectButtonTextStyleApple,
  double? connectButtonIconSize,
  Widget? connectButtonIconEmail,
  Widget? connectButtonIconMobile,
  Widget? connectButtonIconGoogle,
  Widget? connectButtonIconApple,
  TextStyle? legalTextStyle,
  EdgeInsets? legalTextPadding,
  TextStyle? modalTitleTextStyle,
  TextStyle? titleStyle,
  InputDecorationTheme? inputDecorationTheme,
  TextStyle? inputTextStyle,
  TextStyle? inputErrorStyle,
  TextAlignVertical? inputTextAlignVertical,
  ButtonStyle? continueButtonStyle,
  Size? continueButtonProgressIndicatorSize,
  Color? continueButtonProgressIndicatorColor,
  double? continueButtonProgressIndicatorStrokeWidth,
  EdgeInsets? countryItemPadding,
  Color? countryItemHighlightColor,
  TextStyle? countryTextStyle,
  PinTheme? codeInputThemeDefault,
  PinTheme? codeInputThemeFocused,
  PinTheme? codeInputThemeSubmitted,
  PinTheme? codeInputThemeFollowing,
  PinTheme? codeInputThemeDisabled,
  PinTheme? codeInputThemeError,
}
```
