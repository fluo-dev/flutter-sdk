import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

/// Style configuration for the sign-in flow screens (email input, code verification, registration).
///
/// This style is passed to [Fluo.signInWithEmail] and [Fluo.signInWithMobile] to customize
/// the appearance of the authentication screens.
///
/// Example:
/// ```dart
/// Fluo.instance.signInWithEmail(
///   context: context,
///   style: FluoSignInStyle(
///     backgroundColor: Colors.white,
///     titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
///   ),
///   onUserReady: () => print('User ready!'),
/// );
/// ```
class FluoSignInStyle {
  const FluoSignInStyle({
    this.backgroundColor = Colors.white,
    this.padding = const EdgeInsets.all(20.0),
    this.backButtonColor = Colors.black,
    this.titleTextStyle,
    this.inputTextStyle,
    this.inputDecorationTheme,
    this.inputTextAlignVertical = TextAlignVertical.center,
    this.inputErrorTextStyle,
    this.codeInputThemeDefault,
    this.codeInputThemeFocused,
    this.codeInputThemeSubmitted,
    this.codeInputThemeFollowing,
    this.codeInputThemeDisabled,
    this.codeInputThemeError,
    this.continueButtonStyle,
    this.continueButtonProgressIndicatorSize,
    this.continueButtonProgressIndicatorColor,
    this.continueButtonProgressIndicatorStrokeWidth = 2.0,
    this.countryItemPadding = const EdgeInsets.symmetric(
      horizontal: 20.0,
      vertical: 15.0,
    ),
    this.countryItemHighlightColor,
    this.countryTextStyle,
  });

  /// Creates a FluoSignInStyle with native mobile defaults.
  factory FluoSignInStyle.native({
    ThemeData? appTheme,
    Color? backgroundColor,
    EdgeInsets? padding,
    Color? backButtonColor,
    TextStyle? titleTextStyle,
    TextStyle? inputTextStyle,
    InputDecorationTheme? inputDecorationTheme,
    TextAlignVertical? inputTextAlignVertical,
    TextStyle? inputErrorTextStyle,
    PinTheme? codeInputThemeDefault,
    PinTheme? codeInputThemeFocused,
    PinTheme? codeInputThemeSubmitted,
    PinTheme? codeInputThemeFollowing,
    PinTheme? codeInputThemeDisabled,
    PinTheme? codeInputThemeError,
    ButtonStyle? continueButtonStyle,
    Size? continueButtonProgressIndicatorSize,
    Color? continueButtonProgressIndicatorColor,
    double? continueButtonProgressIndicatorStrokeWidth,
    EdgeInsets? countryItemPadding,
    Color? countryItemHighlightColor,
    TextStyle? countryTextStyle,
  }) {
    final primaryColor = appTheme?.colorScheme.primary ?? Colors.black;
    final inversePrimaryColor =
        appTheme?.colorScheme.inversePrimary ?? Colors.white;

    backgroundColor ??= appTheme?.scaffoldBackgroundColor ?? Colors.white;
    padding ??= const EdgeInsets.all(20.0);
    backButtonColor ??= primaryColor;

    titleTextStyle ??= appTheme?.textTheme.headlineSmall ??
        TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: primaryColor,
        );

    inputTextStyle ??= appTheme?.textTheme.titleLarge ??
        const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        );

    inputDecorationTheme ??= (appTheme?.inputDecorationTheme.copyWith(
          hintStyle: appTheme.inputDecorationTheme.hintStyle ??
              inputTextStyle.copyWith(
                color: primaryColor.withAlpha(255 ~/ 3),
              ),
          suffixIconConstraints:
              appTheme.inputDecorationTheme.suffixIconConstraints ??
                  const BoxConstraints(
                    maxHeight: 32,
                    maxWidth: 32 + 10 + 15,
                  ),
        ) as InputDecorationTheme?) ??
        InputDecorationTheme(
          fillColor: inversePrimaryColor.withAlpha(255 ~/ 2),
          filled: true,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 20.0,
          ),
          hintStyle: inputTextStyle.copyWith(
            color: primaryColor.withAlpha(255 ~/ 3),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          suffixIconConstraints: const BoxConstraints(
            maxHeight: 32,
            maxWidth: 32 + 10 + 15,
          ),
        );

    inputTextAlignVertical ??= TextAlignVertical.center;

    inputErrorTextStyle ??= appTheme?.inputDecorationTheme.errorStyle ??
        TextStyle(
          fontSize: 15,
          color: Colors.red.shade500,
        );

    codeInputThemeDefault ??= PinTheme(
      width: 54.0,
      height: 64.0,
      textStyle: const TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.5,
          color: primaryColor,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );

    codeInputThemeFocused ??= codeInputThemeDefault.copyDecorationWith(
      border: Border.all(
        width: 2,
        color: primaryColor,
      ),
    );

    codeInputThemeFollowing ??= codeInputThemeDefault.copyDecorationWith(
      border: Border.all(
        width: 1.5,
        color: primaryColor,
      ),
    );

    continueButtonStyle ??= appTheme?.filledButtonTheme.style ??
        ButtonStyle(
          splashFactory: NoSplash.splashFactory,
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            return states.contains(WidgetState.pressed)
                ? Colors.grey.shade300
                : Colors.grey.shade200;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            return states.contains(WidgetState.disabled)
                ? primaryColor.withAlpha(255 ~/ 4)
                : primaryColor;
          }),
          textStyle: WidgetStateProperty.all(
            const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          minimumSize: WidgetStateProperty.all(const Size.fromHeight(54)),
          mouseCursor: WidgetStateProperty.all(SystemMouseCursors.click),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide.none,
          )),
        );

    final focusedState = <WidgetState>{WidgetState.focused};
    final textStyle = continueButtonStyle.textStyle?.resolve(focusedState);
    final fontSize = textStyle?.fontSize ?? 17;
    continueButtonProgressIndicatorSize ??= Size(fontSize, fontSize);

    final textColor =
        continueButtonStyle.foregroundColor?.resolve(focusedState);
    continueButtonProgressIndicatorColor ??= textColor ?? Colors.black;

    continueButtonProgressIndicatorStrokeWidth ??= 2.0;

    countryItemPadding ??= const EdgeInsets.symmetric(
      horizontal: 20.0,
      vertical: 15.0,
    );

    countryItemHighlightColor ??= primaryColor.withAlpha(255 ~/ 16);

    countryTextStyle ??= const TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w600,
    );

    return FluoSignInStyle(
      backgroundColor: backgroundColor,
      padding: padding,
      backButtonColor: backButtonColor,
      titleTextStyle: titleTextStyle,
      inputTextStyle: inputTextStyle,
      inputDecorationTheme: inputDecorationTheme,
      inputTextAlignVertical: inputTextAlignVertical,
      inputErrorTextStyle: inputErrorTextStyle,
      codeInputThemeDefault: codeInputThemeDefault,
      codeInputThemeFocused: codeInputThemeFocused,
      codeInputThemeSubmitted: codeInputThemeSubmitted,
      codeInputThemeFollowing: codeInputThemeFollowing,
      codeInputThemeDisabled: codeInputThemeDisabled,
      codeInputThemeError: codeInputThemeError,
      continueButtonStyle: continueButtonStyle,
      continueButtonProgressIndicatorSize: continueButtonProgressIndicatorSize,
      continueButtonProgressIndicatorColor: continueButtonProgressIndicatorColor,
      continueButtonProgressIndicatorStrokeWidth:
          continueButtonProgressIndicatorStrokeWidth,
      countryItemPadding: countryItemPadding,
      countryItemHighlightColor: countryItemHighlightColor,
      countryTextStyle: countryTextStyle,
    );
  }

  /// Creates a FluoSignInStyle with web defaults.
  factory FluoSignInStyle.web({
    ThemeData? appTheme,
    Color? backgroundColor,
    EdgeInsets? padding,
    Color? backButtonColor,
    TextStyle? titleTextStyle,
    TextStyle? inputTextStyle,
    InputDecorationTheme? inputDecorationTheme,
    TextAlignVertical? inputTextAlignVertical,
    TextStyle? inputErrorTextStyle,
    PinTheme? codeInputThemeDefault,
    PinTheme? codeInputThemeFocused,
    PinTheme? codeInputThemeSubmitted,
    PinTheme? codeInputThemeFollowing,
    PinTheme? codeInputThemeDisabled,
    PinTheme? codeInputThemeError,
    ButtonStyle? continueButtonStyle,
    Size? continueButtonProgressIndicatorSize,
    Color? continueButtonProgressIndicatorColor,
    double? continueButtonProgressIndicatorStrokeWidth,
    EdgeInsets? countryItemPadding,
    Color? countryItemHighlightColor,
    TextStyle? countryTextStyle,
  }) {
    final primaryColor = appTheme?.colorScheme.primary ?? Colors.black;
    final accentColor = appTheme?.colorScheme.primary ?? Colors.black;

    backgroundColor ??= appTheme?.scaffoldBackgroundColor ?? Colors.white;
    padding ??= const EdgeInsets.all(20.0);
    backButtonColor ??= primaryColor;

    titleTextStyle ??= appTheme?.textTheme.headlineSmall ??
        TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: primaryColor,
          letterSpacing: 0.5,
        );

    inputTextStyle ??= appTheme?.textTheme.titleLarge ??
        const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        );

    inputDecorationTheme ??= appTheme?.inputDecorationTheme as InputDecorationTheme? ??
        InputDecorationTheme(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 12.0,
          ),
          hintStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: primaryColor.withAlpha(255 ~/ 3),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: accentColor.withAlpha(255 ~/ 8),
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(4),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: accentColor,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(4),
            ),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(4),
            ),
          ),
          suffixIconConstraints: const BoxConstraints(
            maxHeight: 32,
            maxWidth: 32 + 10 + 15,
          ),
        );

    inputTextAlignVertical ??= TextAlignVertical.center;

    inputErrorTextStyle ??= appTheme?.inputDecorationTheme.errorStyle ??
        TextStyle(
          fontSize: 13,
          color: Colors.red.shade500,
        );

    codeInputThemeDefault ??= PinTheme(
      width: 54.0,
      height: 64.0,
      textStyle: const TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.2,
          color: primaryColor,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
    );

    codeInputThemeFocused ??= codeInputThemeDefault.copyDecorationWith(
      border: Border.all(
        width: 1.2,
        color: primaryColor,
      ),
    );

    codeInputThemeFollowing ??= codeInputThemeDefault.copyDecorationWith(
      border: Border.all(
        width: 1.0,
        color: primaryColor.withAlpha(255 ~/ 8),
      ),
    );

    continueButtonStyle ??= appTheme?.filledButtonTheme.style ??
        ButtonStyle(
          splashFactory: NoSplash.splashFactory,
          elevation: WidgetStateProperty.all(0),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            return states.contains(WidgetState.disabled)
                ? Colors.grey.shade100
                : Colors.white;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            return states.contains(WidgetState.disabled)
                ? primaryColor.withAlpha(255 ~/ 4)
                : primaryColor;
          }),
          minimumSize: WidgetStateProperty.all(const Size.fromHeight(50)),
          mouseCursor: WidgetStateProperty.all(SystemMouseCursors.click),
          textStyle: WidgetStateProperty.all(
            const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              return states.contains(WidgetState.hovered)
                  ? Colors.grey.shade50
                  : null;
            },
          ),
          shape: WidgetStateProperty.resolveWith<OutlinedBorder>(
            (Set<WidgetState> states) {
              return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: BorderSide(
                  color: states.contains(WidgetState.hovered)
                      ? Colors.grey.shade600
                      : const Color(0xffdadce0),
                  width: 1.0,
                ),
              );
            },
          ),
        );

    final focusedState = <WidgetState>{WidgetState.focused};
    final textStyle = continueButtonStyle.textStyle?.resolve(focusedState);
    final fontSize = textStyle?.fontSize ?? 17;
    continueButtonProgressIndicatorSize ??= Size(fontSize, fontSize);

    final textColor =
        continueButtonStyle.foregroundColor?.resolve(focusedState);
    continueButtonProgressIndicatorColor ??= textColor ?? Colors.black;

    continueButtonProgressIndicatorStrokeWidth ??= 1.5;

    countryItemPadding ??= const EdgeInsets.symmetric(
      horizontal: 12.0,
      vertical: 8.0,
    );

    countryItemHighlightColor ??= primaryColor.withAlpha(255 ~/ 16);

    countryTextStyle ??= const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );

    return FluoSignInStyle(
      backgroundColor: backgroundColor,
      padding: padding,
      backButtonColor: backButtonColor,
      titleTextStyle: titleTextStyle,
      inputTextStyle: inputTextStyle,
      inputDecorationTheme: inputDecorationTheme,
      inputTextAlignVertical: inputTextAlignVertical,
      inputErrorTextStyle: inputErrorTextStyle,
      codeInputThemeDefault: codeInputThemeDefault,
      codeInputThemeFocused: codeInputThemeFocused,
      codeInputThemeSubmitted: codeInputThemeSubmitted,
      codeInputThemeFollowing: codeInputThemeFollowing,
      codeInputThemeDisabled: codeInputThemeDisabled,
      codeInputThemeError: codeInputThemeError,
      continueButtonStyle: continueButtonStyle,
      continueButtonProgressIndicatorSize: continueButtonProgressIndicatorSize,
      continueButtonProgressIndicatorColor: continueButtonProgressIndicatorColor,
      continueButtonProgressIndicatorStrokeWidth:
          continueButtonProgressIndicatorStrokeWidth,
      countryItemPadding: countryItemPadding,
      countryItemHighlightColor: countryItemHighlightColor,
      countryTextStyle: countryTextStyle,
    );
  }

  /// Background color for the sign-in screens.
  final Color backgroundColor;

  /// Padding around the screen content.
  final EdgeInsets padding;

  /// Color of the back button.
  final Color backButtonColor;

  /// Text style for screen titles (e.g., "Enter your email").
  final TextStyle? titleTextStyle;

  /// Text style for text input fields.
  final TextStyle? inputTextStyle;

  /// Decoration theme for text input fields.
  final InputDecorationTheme? inputDecorationTheme;

  /// Vertical alignment of text in input fields.
  final TextAlignVertical inputTextAlignVertical;

  /// Text style for error messages.
  final TextStyle? inputErrorTextStyle;

  /// Default theme for OTP code input boxes.
  final PinTheme? codeInputThemeDefault;

  /// Theme for focused OTP code input box.
  final PinTheme? codeInputThemeFocused;

  /// Theme for submitted OTP code input boxes.
  final PinTheme? codeInputThemeSubmitted;

  /// Theme for following OTP code input boxes.
  final PinTheme? codeInputThemeFollowing;

  /// Theme for disabled OTP code input boxes.
  final PinTheme? codeInputThemeDisabled;

  /// Theme for OTP code input boxes in error state.
  final PinTheme? codeInputThemeError;

  /// Style for the continue button.
  final ButtonStyle? continueButtonStyle;

  /// Size of the progress indicator shown in the continue button when loading.
  final Size? continueButtonProgressIndicatorSize;

  /// Color of the progress indicator shown in the continue button when loading.
  final Color? continueButtonProgressIndicatorColor;

  /// Stroke width of the progress indicator shown in the continue button when loading.
  final double continueButtonProgressIndicatorStrokeWidth;

  /// Padding for country selector items (used in mobile sign-in flow).
  final EdgeInsets countryItemPadding;

  /// Highlight color for country selector items (used in mobile sign-in flow).
  final Color? countryItemHighlightColor;

  /// Text style for country names in the selector (used in mobile sign-in flow).
  final TextStyle? countryTextStyle;
}
