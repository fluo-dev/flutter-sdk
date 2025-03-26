# Fluo

- [Introduction](#introduction)
- [Getting started](#getting-started)
- [Integrating Firebase](#integrating-firebase)
- [Integrating Supabase](#integrating-supabase)
- [Customizing the theme](#Customizing-the-theme)

## Introduction

User onboarding for Flutter.

Integrate the Fluo SDK in minutes and get a complete UI flow to authenticate and register your users.

<img src="https://fluo.dev/img/fluo-onboarding-screenshot.png" alt="Fluo Onboarding" width="300">

**UX principles**

- Passwordless
- Single input screens
- Seamless authentication

**Auth methods**

| Method             | Status   | Note                                                                    |
| ------------------ | -------- | ----------------------------------------------------------------------- |
| Email + Code       | ✔️ Done  | Fluo sends emails on your behalf using your app name                    |
| Google Sign-in     | ✔️ Done  | Set it up in the [Fluo dashboard](https://dashboard.fluo.dev/app-setup) |
| Sign in with Apple | Not done | Plan is to ship by the end of April                                     |
| Mobile + Code      | Not done | Plan is to ship in May                                                  |

**Registration**

- Intuitive "get or create user" logic
- Collect first name, last name, both, or none
- Integration with Firebase
- Integration with Supabase

## Getting started

**STEP 1** — Get an api key from the [Fluo dashboard](https://dashboard.fluo.dev/signup)

**STEP 2** — Add the package to your dependencies:

```bash
flutter pub add fluo
```

**STEP 3** — Add the `FluoOnboarding` component in your app:

```dart
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
        theme: FluoTheme(
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

## Integrating Firebase

Integrate Firebase in the ['Backend' page of the dashboard](https://dashboard.fluo.dev/backend). Once complete, when users are onboarded, Fluo securely forwards their information to:

- the Firebase Authentication service
- a 'users' table created automatically in the Firestore Database

> **Important:** Make sure the Firestore Database is initialized.

To initialize correctly the Firebase session in your app, use the `fluo.firebaseToken` as below:

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

## Integrating Supabase

Integrate Supabase in the ['Backend' page of the dashboard](https://dashboard.fluo.dev/backend). Once complete, when users are onboarded, Fluo securely forwards their information to:

- the Supabase Authentication service
- a 'users' table that you will create as part of the Supabase setup in the Fluo dashboard (don't worry, it's a simple copy-paste)

To initialize correctly the Supabase session in your app, use the `fluo.supabaseSession` as below:

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

## Customizing the theme

Pass a `FluoTheme` to the `FluoOnboarding` component:

```dart
FluoOnboarding(
  // ...other properties...
  theme: FluoTheme(
    // Required
    primaryColor: Colors.black,
    inversePrimaryColor: Colors.white,
    // Optional
    screenPadding: null,
    connectButtonStyle: null,
    connectButtonTextStyle: null,
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
