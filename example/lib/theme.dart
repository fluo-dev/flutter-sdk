import 'package:fluo/theme.dart';
import 'package:flutter/material.dart';

class ExampleAppTheme {
  static ThemeData defaultTheme(BuildContext context) {
    final colorScheme = ColorScheme.light(
      surface: const Color.fromARGB(255, 252, 255, 161),
      onSurface: Colors.black,
      surfaceContainer: Colors.white24,
      primary: Colors.black,
      onPrimary: Colors.white,
      secondary: Colors.black45,
      error: Colors.red.shade400,
    );

    final fluoTheme = FluoTheme.defaultTheme(context, colorScheme);
    final copy = fluoTheme.copyWith(
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
    return copy;
  }
}
