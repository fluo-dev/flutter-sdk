# Fluo

A Flutter SDK for building beautiful onboarding flows with minimal code.

This SDK and documentation are optimized for coding agents (Claude, Cursor, Copilot, etc.) to quickly understand and generate onboarding flows. Just describe what you want and let your agent build it.

**Example prompt:**

> Create an onboarding flow for my meditation app using the flutter-sdk repo of fluo.dev. I want:
> - A welcome screen with a calming message
> - A question asking about their experience level (new to meditation, some experience, regular practice)
> - A question about their main goals (reduce stress, sleep better, improve focus, manage anxiety - multiple choice)
> - A question asking what time they prefer to meditate (morning, afternoon, evening)
> - A features screen highlighting guided sessions, sleep stories, and progress tracking
> - An info screen about enabling notifications for daily reminders
> - A rating screen at the end

## Installation

```bash
flutter pub add fluo
```

---

## Step 1: Create a FluoNavigator

Start with a `FluoNavigator`. It handles navigation and displays a progress bar.

```dart
import 'package:fluo/fluo_navigator.dart';

class OnboardingScreen extends StatelessWidget {
  final navigatorKey = GlobalKey<FluoNavigatorState>();

  @override
  Widget build(BuildContext context) {
    return FluoNavigator(
      key: navigatorKey,
      initialRoute: 'welcome',
      totalSteps: 3,
      onGenerateRoute: (settings) {
        Widget page;

        if (settings.name == 'welcome') {
          page = Center(child: Text('Welcome!'));
        } else {
          page = Center(child: Text('Unknown'));
        }

        return MaterialPageRoute(
          settings: settings,
          builder: (context) => page,
        );
      },
    );
  }
}
```

---

## Step 2: Add a question screen

Use `FluoQuestionScreen` to ask questions with selectable answers.

```dart
import 'package:fluo/fluo_question_screen.dart';

if (settings.name == 'role') {
  page = FluoQuestionScreen(
    title: 'What describes you best?',
    answers: [
      FluoAnswer(
        id: 'developer',
        title: 'Developer',
        icon: Icon(Icons.code, size: 16),
      ),
      FluoAnswer(
        id: 'designer',
        title: 'Designer',
        icon: Icon(Icons.palette, size: 16),
      ),
      FluoAnswer(
        id: 'other',
        title: 'Other',
        icon: Icon(Icons.person, size: 16),
      ),
    ],
    onContinue: (answerIds) {
      navigatorKey.currentState!.pushNamed('next_screen');
    },
  );
}
```

For multiple selection, set `singleChoice: false`:

```dart
FluoQuestionScreen(
  title: 'What are your interests?',
  singleChoice: false,  // Shows a Continue button
  answers: [...],
  onContinue: (answerIds) {
    // answerIds contains all selected answers
  },
)
```

---

## Step 3: Other template screens

Fluo provides 4 template screens. They all work similarly.

### FluoInfoScreen

Display information with an icon and subtitle.

```dart
import 'package:fluo/fluo_info_screen.dart';

FluoInfoScreen(
  icon: Icon(Icons.check_circle, size: 80),
  title: "You're all set!",
  subtitle: 'Your account has been created.',
  onContinue: () {
    navigatorKey.currentState!.pushNamed('next');
  },
)
```

### FluoFeaturesScreen

Display a list of features with checkmarks.

```dart
import 'package:fluo/fluo_features_screen.dart';

FluoFeaturesScreen(
  title: 'What you get',
  features: [
    'Unlimited projects',
    'Priority support',
    'Advanced analytics',
  ],
  onContinue: () {
    navigatorKey.currentState!.pushNamed('next');
  },
)
```

### FluoRatingScreen

Prompt users to rate your app.

```dart
import 'package:fluo/fluo_rating_screen.dart';

FluoRatingScreen(
  title: 'Enjoying the app?',
  appStoreId: '123456789',
  userPhoto: AssetImage('assets/reviewer.png'),
  userName: 'John Doe',
  userReview: 'This app changed my life!',
  onContinue: () {
    navigatorKey.currentState!.pushNamed('next');
  },
)
```

---

## Step 4: Add a custom screen

You can use any widget as a screen. Just make sure to call `navigatorKey.currentState!.pushNamed()` to navigate.

```dart
if (settings.name == 'custom') {
  page = MyCustomScreen(
    onContinue: () {
      navigatorKey.currentState!.pushNamed('next');
    },
  );
}
```

---

## Step 5: Mix templates and custom screens

Combine template screens and custom screens in any order.

```dart
onGenerateRoute: (settings) {
  Widget page;

  if (settings.name == 'intro') {
    page = MyCustomIntroScreen(onContinue: () => goTo('question1'));
  }

  if (settings.name == 'question1') {
    page = FluoQuestionScreen(
      title: 'How did you hear about us?',
      answers: [...],
      onContinue: (ids) => goTo('features'),
    );
  }

  if (settings.name == 'features') {
    page = FluoFeaturesScreen(
      title: 'What you get',
      features: [...],
      onContinue: () => goTo('custom_setup'),
    );
  }

  if (settings.name == 'custom_setup') {
    page = MyCustomSetupScreen(onContinue: () => goTo('done'));
  }

  return MaterialPageRoute(settings: settings, builder: (_) => page);
}

void goTo(String route) {
  navigatorKey.currentState!.pushNamed(route);
}
```

---

## Step 6: Branching with stepIncrement

Skip steps based on user answers using `stepIncrement`.

```dart
FluoQuestionScreen(
  title: 'Are you a professional?',
  answers: [
    FluoAnswer(id: 'yes', title: 'Yes', icon: Icon(Icons.work)),
    FluoAnswer(id: 'no', title: 'No', icon: Icon(Icons.person)),
  ],
  onContinue: (answerIds) {
    if (answerIds.first == 'yes') {
      // Go to professional questions (1 step)
      navigatorKey.currentState!.pushNamed(
        'pro_details',
        stepIncrement: 1,
      );
    } else {
      // Skip professional questions, jump ahead (3 steps)
      navigatorKey.currentState!.pushNamed(
        'general_info',
        stepIncrement: 3,
      );
    }
  },
)
```

The progress bar will update accordingly based on `stepIncrement`.

---

## Styling

Each screen has its own style class. Pass a style to customize appearance.

```dart
FluoQuestionScreen(
  style: FluoQuestionScreenStyle(
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    continueButtonStyle: FilledButton.styleFrom(backgroundColor: Colors.blue),
  ),
  title: '...',
  answers: [...],
  onContinue: (ids) {},
)
```

Available style classes:
- `FluoQuestionScreenStyle` + `FluoAnswerStyle`
- `FluoInfoScreenStyle`
- `FluoFeaturesScreenStyle`
- `FluoRatingScreenStyle`
- `FluoNavigatorStyle`
- `FluoSignInStyle` (for sign-in flows)

Check the source code for all available style properties.

---

## Authentication (optional)

If you need authentication, add the localization delegate and use the sign-in methods.

All authentication settings are configured in the [Fluo Dashboard](https://dashboard.fluo.dev/) — including Firebase/Supabase setup, Google and Apple credentials, Prelude API key for SMS, and session management.

Add `FluoLocalizations.delegate` to your app:

```dart
MaterialApp(
  // ...other properties...
  localizationsDelegates: const [
    FluoLocalizations.delegate,
    // ...other delegates...
  ],
)
```

Initialize Fluo and start a sign-in flow:

```dart
import 'package:fluo/fluo.dart';

// Initialize once at app start
await Fluo.initWithApiKey('YOUR_API_KEY');
await Fluo.instance.loadAppConfig();

// Start a sign-in flow
Fluo.instance.signInWithEmail(
  context: context,
  onExit: () => print('User cancelled'),
  onUserReady: () => print('User signed in!'),
);

// Or use Mobile/Google/Apple
Fluo.instance.signInWithMobile(
  context: context,
  onExit: () => print('User cancelled'),
  onUserReady: () => print('User signed in!'),
);

// For mobile sign-in, Fluo uses Prelude (https://prelude.so) for SMS delivery.
// Create an API key on Prelude and add it to your Fluo dashboard.

Fluo.instance.signInWithGoogle(
  context: context,
  onBeforeSessionCreation: () => showLoadingDialog(),
  onUserReady: () => hideLoadingAndContinue(),
);

// For Google sign-in, configure your Google OAuth credentials in the Fluo dashboard.

Fluo.instance.signInWithApple(
  context: context,
  onBeforeSessionCreation: () => showLoadingDialog(),
  onUserReady: () => hideLoadingAndContinue(),
);

// For Apple sign-in, configure your Apple Developer credentials in the Fluo dashboard.
```

### macOS setup

Add this key to both `macos/Runner/DebugProfile.entitlements` and `macos/Runner/Release.entitlements`:

```xml
<dict>
	<key>com.apple.security.network.client</key>
	<true/>
</dict>
```

### Useful methods

```dart
// Check if user is ready (valid session + complete user attributes)
if (Fluo.instance.isUserReady()) { /* ... */ }

// Check if a session exists
if (Fluo.instance.hasSession()) { /* ... */ }

// Get a fresh access token (auto-refreshes if expired)
final accessToken = await Fluo.instance.getAccessToken();

// Sign out
await Fluo.instance.clearSession();

// User data
Fluo.instance.session!.user.id;        // "jzi8w7bdou4m0kq"
Fluo.instance.session!.user.email;     // "peter.parker@marvel.com"
Fluo.instance.session!.user.firstName; // "Peter"
Fluo.instance.session!.user.lastName;  // "Parker"
```

### Integrating with Firebase

Select 'Firebase' for your backend. Fluo forwards user info to Firebase Authentication and creates a `users` table in Firestore.

```dart
if (Fluo.isInitialized) {
  final fluoSession = Fluo.instance.session;
  if (fluoSession != null) {
    final firebaseToken = fluoSession.firebaseToken!;
    await FirebaseAuth.instance.signInWithCustomToken(firebaseToken);
  }
}
```

### Integrating with Supabase

Select 'Supabase' for your backend. Fluo forwards user info to Supabase Authentication and a `users` table.

```dart
if (Fluo.isInitialized) {
  final fluoSession = Fluo.instance.session;
  if (fluoSession != null) {
    final supabaseSession = fluoSession.supabaseSession!;
    await Supabase.instance.client.auth.recoverSession(supabaseSession);
  }
}
```

### Integrating with any backend

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
