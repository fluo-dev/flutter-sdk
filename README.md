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

- E-mail + code (done)
- Google sign in (will be done in March)
- Apple sign in (will be done in April)
- Mobile + code (will be done in May)

> **Note:** You don't need to set up an email service. Fluo sends emails on your behalf using your app name.

**Registration**

- Intuitive "get or create user" logic
- Collect first name, last name, both, or none
- Integration with Firebase
- Integration with Supabase

## Getting started

**STEP 1** — Get an api key from the [Fluo dashboard](https://dashboard.fluo.dev/signup).

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

Use the `fluo.firebaseToken` as below:

```dart
FluoOnboarding(
  // ...other properties...
  onUserReady: (fluo) async {
    // Initialize the Firebase client, then use 'signInWithCustomToken' here
    await FirebaseAuth.instance.signInWithCustomToken(fluo.firebaseToken!);
  },
)
```

## Integrating Supabase

Use the `fluo.supabaseSession` as below:

```dart
FluoOnboarding(
  // ...other properties...
  onUserReady: (fluo) async {
    // Initialize the Supabase client, then use 'recoverSession' here
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
