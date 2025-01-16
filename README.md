# Fluo

- [Introduction](#introduction)
- [Getting started](#getting-started)
- [Usage](#usage)
- [Theming](#theming)

## Introduction

User onboarding for Flutter.

Integrate the Fluo SDK in minutes and get a complete UI flow to authenticate and register your users.

<img src="https://fluo.dev/img/fluo-onboarding-screenshot.png" alt="Fluo Onboarding" width="300">

**Great UX principles**

- Passwordless
- Single input screens
- Seamless authentication

---

**Auth methods**

- E-mail + code (code is sent by the Fluo backend)
- Mobile + code (soon)
- Google sign in (soon)
- Apple sign in (soon)

---

**Registration**

- Smart "get or create user" logic
- Collect first name and last name
- Save users in firebase
- Save users in supabase (soon)

## Getting started

**STEP 1** — Get an api key from the [Fluo dashboard](https://dashboard.fluo.dev/signup).

**STEP 2** — Add the package to your dependencies:

```bash
flutter pub add fluo
```

## Usage

Add the `FluoOnboarding` component in your app:

```dart
FluoOnboarding(
  apiKey: 'your-api-key',
  onUserReady: (fluo) async {
    // Sign the user in using firebase
    final firebaseToken = fluo.getFirebaseToken();
    await FirebaseAuth.instance.signInWithCustomToken(firebaseToken);
  },
  onInitError: (error) {
    // Optional - Handle network or server error
  }
  introBuilder: (context, initializing, bottomContainerHeight) {
    // Optional - Present your app on the connection screen
    //   use 'initializing' if you want to show a loading indicator
    //   use 'bottomContainerHeight' if you need to position content above the buttons
  },
)
```

Below is a more complete example:

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
        // ...other delegates...
        FluoLocalizations.delegate,
      ],
      supportedLocales: FluoLocalizations.supportedLocales,
      theme: FluoTheme.defaultTheme(context, FluoTheme.lightColorScheme),
      home: FluoOnboarding(
        apiKey: 'your-api-key',
        onUserReady: (fluo) async {
          // Sign the user in using firebase
          final firebaseToken = fluo.getFirebaseToken();
          await FirebaseAuth.instance.signInWithCustomToken(firebaseToken);
        },
        onInitError: (error) {
          // Optional - Handle network or server error
        }
        introBuilder: (context, initializing, bottomContainerHeight) {
          // Optional - Present your app on the connection screen
          //   use 'initializing' if you want to show a loading indicator
          //   use 'bottomContainerHeight' if you need to position content above the buttons
        },
      ),
    );
  }
}
```

## Theming

The `FluoTheme` can be extended as shown below:

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
