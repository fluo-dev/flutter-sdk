import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class FluoTheme {
  static ColorScheme lightColorScheme = ColorScheme.light(
    surface: Colors.grey.shade100,
    primary: Colors.black,
    onPrimary: Colors.white,
    secondary: Colors.grey.shade500,
    error: Colors.red.shade500,
  );

  static ColorScheme darkColorScheme = ColorScheme.dark(
    surface: Colors.grey.shade900,
    primary: Colors.white,
    onPrimary: Colors.black,
    secondary: Colors.white54,
    error: Colors.red.shade500,
  );

  static ThemeData defaultTheme(BuildContext context, ColorScheme colorScheme) {
    return ThemeData(
      splashColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      colorScheme: colorScheme,
      textTheme: TextTheme(
        bodyMedium: TextStyle(
          letterSpacing: -0.41,
          color: colorScheme.secondary,
        ),
        titleMedium: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.41,
        ),
        titleLarge: const TextStyle(
          fontWeight: FontWeight.w600,
          letterSpacing: -0.41,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: TextButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          minimumSize: const Size.fromHeight(54),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: colorScheme.surfaceContainer,
        filled: true,
        hintStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: colorScheme.secondary.withAlpha(255 ~/ 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 15.0,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }

  static PinTheme defaultPinTheme(BuildContext context) {
    final theme = Theme.of(context);
    return PinTheme(
      width: 54.0,
      height: 64.0,
      textStyle: theme.textTheme.headlineMedium,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainer,
        border: Border.all(
          color: theme.colorScheme.onSurface,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }

  static PinTheme focusedPinTheme(BuildContext context) {
    return FluoTheme.defaultPinTheme(context).copyDecorationWith(
      border: Border.all(
        color: Theme.of(context).colorScheme.primary,
        width: 2,
      ),
    );
  }

  static PinTheme followingPinTheme(BuildContext context) {
    return FluoTheme.defaultPinTheme(context).copyDecorationWith(
      border: Border.all(
        color: Theme.of(context).colorScheme.secondary,
        width: 1.5,
      ),
    );
  }
}
