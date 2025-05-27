<img src="https://fluo.dev/img/fluo-github-header.png" alt="fluo introduction">

# Fluo

- [Getting started](#getting-started)
- [Integrating with Firebase](#integrating-with-firebase)
- [Integrating with Supabase](#integrating-with-supabase)
- [Integrating with any backend](#integrating-with-any-backend)
- [Customizing the theme](#Customizing-the-theme)

## Getting started

**STEP 1** — Get an api key from the [Fluo dashboard](https://dashboard.fluo.dev/signup)

**STEP 2** — Add the package to your dependencies:

```bash
flutter pub add fluo
```

**STEP 3** — Add the `FluoOnboarding` widget in your app:

```dart
import 'package:fluo/fluo.dart';
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
        // Important: add this one
        FluoLocalizations.delegate,
        // ...other delegates...
      ],
      home: FluoOnboarding(
        apiKey: 'your-api-key',
        onUserReady: (fluo) {
          // Here, your user is onboarded, so do your own things!

          // When you need to sign the user out, you can use the
          // fluo.clearSession() method. It's async so you can decide
          // to use await depending on your use case.
          fluo.clearSession();
        },
        onInitError: (error) {
          // Optional - Handle network or server error
          //   for example, you could decide to show a toast or dialog
        }
        introBuilder: (context, initializing, bottomContainerHeight) {
          // Optional - Present your app on the connection screen
          //   use 'initializing' if you want to show a loading indicator
          //   use 'bottomContainerHeight' if you need to position content above the buttons
        },
        theme: FluoTheme.native(
          // Optional - Customize the look & feel
          primaryColor: Colors.black,
          inversePrimaryColor: Colors.white,
          // ...lots more to customize...
        ),
      ),
    );
  }
}
```

**For macOS**, make sure you have networking allowed by adding this key to both `{your-app}/macos/Runner/DebugProfile.entitlements` and `{your-app}/macos/Runner/Release.entitlements`:

```xml
<dict>
	<!-- Add this key set to true -->
	<key>com.apple.security.network.client</key>
	<true/>
</dict>
```

## Integrating with Firebase

Create a new app from the [Fluo dashboard](https://dashboard.fluo.dev/new), select 'Firebase' and follow the instructions. Once complete, when users are onboarded, Fluo forwards their information to (1) the Firebase Authentication service and (2) a `users` table created automatically in the Firestore Database. As such, make sure the Firestore Database is initialized.

Back to your app code, to initialize correctly the Firebase session, use the `fluo.firebaseToken` as below:

```dart
FluoOnboarding(
  // ...other properties...
  onUserReady: (fluo) async {
    // 1. Initialize the Firebase client somewhere in your code
    // 2. Use 'signInWithCustomToken' as below:
    await FirebaseAuth.instance.signInWithCustomToken(fluo.firebaseToken!);
  },
)
```

## Integrating with Supabase

Create a new app from the [Fluo dashboard](https://dashboard.fluo.dev/new), select 'Supabase' and follow the instructions. Once complete, when users are onboarded, Fluo forwards their information to (1) the Supabase Authentication service and (2) a `users` table that you will create as part of the Supabase setup (no worries, it's a simple copy-paste).

Back to your app code, to initialize correctly the Supabase session, use the `fluo.supabaseSession` as below:

```dart
FluoOnboarding(
  // ...other properties...
  onUserReady: (fluo) async {
    // 1. Initialize the Supabase client somewhere in your code
    // 2. Use 'recoverSession' as below:
    await Supabase.instance.client.auth.recoverSession(fluo.supabaseSession!);
  },
)
```

## Integrating with any backend

Create a new app from the [Fluo dashboard](https://dashboard.fluo.dev/new), select 'Custom' and follow the instructions. The general idea is to use the JWT access token provided by Fluo. Once decoded (using your secret key), it provides the user information which you can store in your database.

Here is a full example to understand how it works:

[1] In the `onUserReady` callback, pass the `fluo` instance to your preferred dependency management system, so that it is accessible in other parts of your app.

```dart
import 'package:get_it/get_it.dart';

FluoOnboarding(
  apiKey: '{apiKey}',
  onUserReady: (fluo) {
    // Here we use GetIt as an example
    GetIt.instance.registerSingleton<Fluo>(fluo);
  },
)
```

[2] Now, wherever you need it, call `fluo.getAccessToken()` to get the JWT access token generated by Fluo and send it to your backend.

```dart
import 'package:http/http.dart' as http;

// Example of a function that gets a user. If the user
// doesn't exist yet, it should create it first.
Future<User> getOrCreateUser() async {
  final fluo = GetIt.instance<Fluo>();
  // This method returns an access token which is valid for
  // 1 hour and auto-refreshed using a single-use refresh token
  final accessToken = await fluo.getAccessToken();
  final response = await http.get(
    Uri.parse('https://your-backend.com/api/user/me'),
    headers: {
      'authorization': 'Bearer $accessToken',
    },
  );
  return User.fromJson(jsonDecode(response.body));
}
```

[3] In your backend, decode the access token to get the JWT payload. The payload contains the user id (sub) and email. Depending on your configuration, it may also contain the first name and last name.

```js
const jwt = require("jsonwebtoken")

// This is your JWT secret key (do not share it with anyone)
const SECRET_KEY = "{jwtSecret}"

// Following on the example, here is the corresponding endpoint.
// Note that this is simplified and does not handle all edge cases.
app.get("/api/user/me", async (req, res) => {
  const accessToken = req.headers["authorization"].split(" ")[1]

  // Decode the access token using your secret key
  const payload = jwt.verify(accessToken, SECRET_KEY)

  // 'payload.sub' contains a unique user id generated by Fluo
  const userId = payload.sub

  // Find the user by id
  let user = await User.findOne({ id: userId })

  // If the user doesn't exist, create it
  if (!user) {
    user = await User.create({
      id: userId,
      email: payload.email,
      firstName: payload.firstName,
      lastName: payload.lastName,
    })
  }

  return res.status(200).json(user)
})
```

[4] If you need to go further, here is a complete example of the payload. For example, for increased security, you might want to verify that the token has not expired.

```js
{
  "iat": 1744039599, // issued at
  "exp": 1744043199, // expires 1 hour after being issued
  "iss": "fluo.dev", // issuer
  "sub": "2rztxukf57pnjz9", // user id
  "email": "peter@marvel.com", // user email
  "firstName": "Peter", // user first name
  "lastName": "Parker", // user last name
}
```

## Customizing the theme

Pass a `FluoTheme` to the `FluoOnboarding` component:

```dart
FluoOnboarding(
  // ...other properties...
  theme: FluoTheme.native( // or FluoTheme.web()
    primaryColor: null,
    inversePrimaryColor: null,
    accentColor: null,
    screenPadding: null,
    connectButtonStyle: null,
    connectButtonStyleGoogle: null,
    connectButtonStyleApple: null,
    connectButtonTextStyle: null,
    connectButtonTextStyleGoogle: null,
    connectButtonTextStyleApple: null,
    connectButtonIconSize: null,
    connectButtonIconEmail: null,
    connectButtonIconGoogle: null,
    connectButtonIconApple: null,
    legalTextStyle: null,
    legalTextPadding: null,
    modalTitleTextStyle: null,
    titleStyle: null,
    inputDecoration: null,
    inputTextStyle: null,
    inputErrorStyle: null,
    inputTextAlignVertical: null,
    nextButtonStyle: null,
    nextButtonProgressIndicatorSize: null,
    nextButtonProgressIndicatorColor: null,
    nextButtonProgressIndicatorStrokeWidth: null,
    codeInputThemeDefault: null,
    codeInputThemeFocused: null,
    codeInputThemeSubmitted: null,
    codeInputThemeFollowing: null,
    codeInputThemeDisabled: null,
    codeInputThemeError: null,
  ),
)
```

> **Note:** If you have questions or need `FluoTheme` to be extended, please do not hesitate to contact me at jordan @ fluo.dev
