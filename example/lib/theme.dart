import 'package:fluo/theme.dart';
import 'package:flutter/material.dart';

class ExampleAppTheme {
  static ThemeData defaultTheme(BuildContext context) {
    final fluoTheme = FluoTheme.defaultTheme(
      context,
      FluoTheme.lightColorScheme,
    );
    final fluoExtended = fluoTheme.copyWith(
      filledButtonTheme: FilledButtonThemeData(
        style: TextButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          minimumSize: const Size.fromHeight(54),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      textTheme: fluoTheme.textTheme.copyWith(
        bodyMedium: fluoTheme.textTheme.bodyMedium?.copyWith(
          fontSize: 13,
        ),
        titleMedium: fluoTheme.textTheme.titleMedium?.copyWith(
          fontSize: 16,
        ),
        titleLarge: fluoTheme.textTheme.titleLarge?.copyWith(
          fontSize: 18,
        ),
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
      inputDecorationTheme: fluoTheme.inputDecorationTheme.copyWith(
        hintStyle: fluoTheme.inputDecorationTheme.hintStyle!.copyWith(
          fontSize: 16,
        ),
      ),
    );
    return fluoExtended;
  }
}
