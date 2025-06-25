import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class FluoTheme {
  factory FluoTheme.native({
    ThemeData? appTheme,
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
    ButtonStyle? nextButtonStyle,
    Size? nextButtonProgressIndicatorSize,
    Color? nextButtonProgressIndicatorColor,
    double? nextButtonProgressIndicatorStrokeWidth,
    EdgeInsets? countryItemPadding,
    Color? countryItemHighlightColor,
    TextStyle? countryTextStyle,
    PinTheme? codeInputThemeDefault,
    PinTheme? codeInputThemeFocused,
    PinTheme? codeInputThemeSubmitted,
    PinTheme? codeInputThemeFollowing,
    PinTheme? codeInputThemeDisabled,
    PinTheme? codeInputThemeError,
  }) {
    primaryColor ??= appTheme?.colorScheme.primary ?? Colors.black;

    inversePrimaryColor ??=
        appTheme?.colorScheme.inversePrimary ?? Colors.white;

    accentColor ??= appTheme?.colorScheme.primary ?? Colors.black;

    screenPadding ??= const EdgeInsets.all(20.0);

    connectButtonStyle ??= appTheme?.filledButtonTheme.style ??
        ButtonStyle(
          splashFactory: NoSplash.splashFactory,
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            return states.contains(WidgetState.pressed)
                ? Colors.grey.shade300
                : Colors.grey.shade200;
          }),
          foregroundColor: WidgetStateProperty.all(Colors.black),
          minimumSize: WidgetStateProperty.all(const Size.fromHeight(54)),
          mouseCursor: WidgetStateProperty.all(SystemMouseCursors.click),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide.none,
          )),
        );

    connectButtonStyleGoogle ??= connectButtonStyle;

    connectButtonStyleApple ??= connectButtonStyle.copyWith(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        return states.contains(WidgetState.pressed)
            ? Colors.black87
            : Colors.black;
      }),
    );

    connectButtonTextStyle ??= appTheme?.textTheme.titleMedium ??
        TextStyle(
          fontSize: 17,
          color: primaryColor,
          fontWeight: FontWeight.w600,
        );

    connectButtonTextStyleGoogle ??= connectButtonTextStyle;

    connectButtonTextStyleApple ??= connectButtonTextStyle.copyWith(
      color: Colors.white,
    );

    connectButtonIconSize ??= 20.0;

    connectButtonIconEmail ??= Icon(
      Icons.mail_outline_rounded,
      color: connectButtonTextStyle.color,
      size: connectButtonIconSize,
    );

    connectButtonIconMobile ??= Icon(
      Icons.phone_iphone_outlined,
      color: connectButtonTextStyle.color,
      size: connectButtonIconSize,
    );

    connectButtonIconGoogle ??= Image.asset(
      'packages/fluo/assets/images/google.png',
      width: connectButtonIconSize,
    );

    connectButtonIconApple ??= Image.asset(
      'packages/fluo/assets/images/apple.png',
      color: connectButtonTextStyleApple.color,
      width: connectButtonIconSize,
    );

    legalTextStyle ??= appTheme?.textTheme.bodySmall ??
        TextStyle(
          fontSize: 14,
          color: primaryColor.withAlpha(
            (255 * 0.6).toInt(),
          ),
        );

    legalTextPadding ??= const EdgeInsets.symmetric(
      vertical: 30.0,
      horizontal: 50.0,
    );

    modalTitleTextStyle ??= appTheme?.textTheme.titleMedium ??
        TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: primaryColor,
        );

    titleStyle ??= appTheme?.textTheme.headlineSmall ??
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

    inputDecorationTheme ??= appTheme?.inputDecorationTheme.copyWith(
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
        ) ??
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

    inputErrorStyle ??= appTheme?.inputDecorationTheme.errorStyle ??
        TextStyle(
          fontSize: 15,
          color: Colors.red.shade500,
        );

    inputTextAlignVertical ??= TextAlignVertical.center;

    nextButtonStyle ??= appTheme?.filledButtonTheme.style ??
        TextButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          minimumSize: const Size.fromHeight(54),
          enabledMouseCursor: SystemMouseCursors.click,
          textStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        );

    nextButtonProgressIndicatorSize ??= const Size(16.0, 16.0);

    nextButtonProgressIndicatorColor ??= inversePrimaryColor;

    nextButtonProgressIndicatorStrokeWidth ??= 2.0;

    countryItemPadding ??= const EdgeInsets.symmetric(
      horizontal: 20.0,
      vertical: 15.0,
    );

    countryItemHighlightColor ??= primaryColor.withAlpha(255 ~/ 16);

    countryTextStyle ??= const TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w600,
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

    return FluoTheme._(
      primaryColor,
      inversePrimaryColor,
      accentColor,
      screenPadding,
      connectButtonStyle,
      connectButtonStyleGoogle,
      connectButtonStyleApple,
      connectButtonTextStyle,
      connectButtonTextStyleGoogle,
      connectButtonTextStyleApple,
      connectButtonIconSize,
      connectButtonIconEmail,
      connectButtonIconMobile,
      connectButtonIconGoogle,
      connectButtonIconApple,
      legalTextStyle,
      legalTextPadding,
      modalTitleTextStyle,
      titleStyle,
      inputDecorationTheme,
      inputTextStyle,
      inputErrorStyle,
      inputTextAlignVertical,
      nextButtonStyle,
      nextButtonProgressIndicatorSize,
      nextButtonProgressIndicatorColor,
      nextButtonProgressIndicatorStrokeWidth,
      countryItemPadding,
      countryItemHighlightColor,
      countryTextStyle,
      codeInputThemeDefault,
      codeInputThemeFocused,
      codeInputThemeSubmitted,
      codeInputThemeFollowing,
      codeInputThemeDisabled,
      codeInputThemeError,
    );
  }

  factory FluoTheme.web({
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
    ButtonStyle? nextButtonStyle,
    Size? nextButtonProgressIndicatorSize,
    Color? nextButtonProgressIndicatorColor,
    double? nextButtonProgressIndicatorStrokeWidth,
    EdgeInsets? countryItemPadding,
    Color? countryItemHighlightColor,
    TextStyle? countryTextStyle,
    PinTheme? codeInputThemeDefault,
    PinTheme? codeInputThemeFocused,
    PinTheme? codeInputThemeSubmitted,
    PinTheme? codeInputThemeFollowing,
    PinTheme? codeInputThemeDisabled,
    PinTheme? codeInputThemeError,
  }) {
    primaryColor ??= Colors.black;

    inversePrimaryColor ??= Colors.white;

    accentColor ??= Colors.black;

    screenPadding ??= const EdgeInsets.all(20.0);

    connectButtonStyle ??= ButtonStyle(
      splashFactory: NoSplash.splashFactory,
      backgroundColor: WidgetStateProperty.all(Colors.white),
      foregroundColor: WidgetStateProperty.all(Colors.black),
      fixedSize: WidgetStateProperty.all(const Size(360, 40)),
      mouseCursor: WidgetStateProperty.all(SystemMouseCursors.click),
      elevation: WidgetStateProperty.all(0),
      overlayColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.hovered)) {
            return Colors.grey.shade50;
          }
          return null;
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

    connectButtonStyleGoogle ??= connectButtonStyle;

    connectButtonStyleApple ??= connectButtonStyle;

    connectButtonTextStyle ??= TextStyle(
      fontSize: 14,
      color: Colors.grey.shade800,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.0,
    );

    connectButtonTextStyleGoogle ??= connectButtonTextStyle;

    connectButtonTextStyleApple ??= connectButtonTextStyle;

    connectButtonIconSize ??= 18.0;

    connectButtonIconEmail ??= Icon(
      Icons.mail_outline_rounded,
      color: connectButtonTextStyle.color,
      size: connectButtonIconSize,
    );

    connectButtonIconMobile ??= Icon(
      Icons.phone_android_rounded,
      color: connectButtonTextStyle.color,
      size: connectButtonIconSize,
    );

    connectButtonIconGoogle ??= Image.asset(
      'packages/fluo/assets/images/google.png',
      width: connectButtonIconSize,
    );

    connectButtonIconApple ??= Image.asset(
      'packages/fluo/assets/images/apple.png',
      color: connectButtonTextStyleApple.color,
      width: connectButtonIconSize,
    );

    legalTextStyle ??= TextStyle(
      fontSize: 13,
      color: primaryColor.withAlpha((255 * 0.6).toInt()),
    );

    legalTextPadding ??= const EdgeInsets.only(
      top: 30.0,
      right: 30.0,
      left: 30.0,
    );

    modalTitleTextStyle ??= TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: primaryColor,
      letterSpacing: 0.5,
    );

    titleStyle ??= TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: primaryColor,
      letterSpacing: 0.5,
    );

    inputDecorationTheme ??= InputDecorationTheme(
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

    inputTextStyle ??= const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
    );

    inputErrorStyle ??= TextStyle(
      fontSize: 13,
      color: Colors.red.shade500,
    );

    inputTextAlignVertical ??= TextAlignVertical.center;

    nextButtonStyle ??= ButtonStyle(
      splashFactory: NoSplash.splashFactory,
      backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.disabled)) {
          return accentColor!.withAlpha(255 ~/ 8);
        }
        return accentColor!;
      }),
      minimumSize: WidgetStateProperty.all(const Size.fromHeight(54)),
      mouseCursor: WidgetStateProperty.all(SystemMouseCursors.click),
      textStyle: WidgetStateProperty.all(const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
      )),
      shape: WidgetStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      )),
    );

    nextButtonProgressIndicatorSize ??= const Size(13.0, 13.0);

    nextButtonProgressIndicatorColor ??= inversePrimaryColor;

    nextButtonProgressIndicatorStrokeWidth ??= 1.5;

    countryItemPadding ??= const EdgeInsets.symmetric(
      horizontal: 12.0,
      vertical: 8.0,
    );

    countryItemHighlightColor ??= primaryColor.withAlpha(255 ~/ 16);

    countryTextStyle ??= const TextStyle(
      fontSize: 17.0,
      fontWeight: FontWeight.w600,
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

    return FluoTheme._(
      primaryColor,
      inversePrimaryColor,
      accentColor,
      screenPadding,
      connectButtonStyle,
      connectButtonStyleGoogle,
      connectButtonStyleApple,
      connectButtonTextStyle,
      connectButtonTextStyleGoogle,
      connectButtonTextStyleApple,
      connectButtonIconSize,
      connectButtonIconEmail,
      connectButtonIconMobile,
      connectButtonIconGoogle,
      connectButtonIconApple,
      legalTextStyle,
      legalTextPadding,
      modalTitleTextStyle,
      titleStyle,
      inputDecorationTheme,
      inputTextStyle,
      inputErrorStyle,
      inputTextAlignVertical,
      nextButtonStyle,
      nextButtonProgressIndicatorSize,
      nextButtonProgressIndicatorColor,
      nextButtonProgressIndicatorStrokeWidth,
      countryItemPadding,
      countryItemHighlightColor,
      countryTextStyle,
      codeInputThemeDefault,
      codeInputThemeFocused,
      codeInputThemeSubmitted,
      codeInputThemeFollowing,
      codeInputThemeDisabled,
      codeInputThemeError,
    );
  }

  const FluoTheme._(
    this.primaryColor,
    this.inversePrimaryColor,
    this.accentColor,
    this.screenPadding,
    this.connectButtonStyle,
    this.connectButtonStyleGoogle,
    this.connectButtonStyleApple,
    this.connectButtonTextStyle,
    this.connectButtonTextStyleGoogle,
    this.connectButtonTextStyleApple,
    this.connectButtonIconSize,
    this.connectButtonIconEmail,
    this.connectButtonIconMobile,
    this.connectButtonIconGoogle,
    this.connectButtonIconApple,
    this.legalTextStyle,
    this.legalTextPadding,
    this.modalTitleTextStyle,
    this.titleStyle,
    this.inputDecorationTheme,
    this.inputTextStyle,
    this.inputErrorStyle,
    this.inputTextAlignVertical,
    this.nextButtonStyle,
    this.nextButtonProgressIndicatorSize,
    this.nextButtonProgressIndicatorColor,
    this.nextButtonProgressIndicatorStrokeWidth,
    this.countryItemPadding,
    this.countryItemHighlightColor,
    this.countryTextStyle,
    this.codeInputThemeDefault,
    this.codeInputThemeFocused,
    this.codeInputThemeSubmitted,
    this.codeInputThemeFollowing,
    this.codeInputThemeDisabled,
    this.codeInputThemeError,
  );

  final Color primaryColor;
  final Color inversePrimaryColor;
  final Color accentColor;
  final EdgeInsets screenPadding;

  final ButtonStyle connectButtonStyle;
  final ButtonStyle connectButtonStyleGoogle;
  final ButtonStyle connectButtonStyleApple;

  final TextStyle connectButtonTextStyle;
  final TextStyle connectButtonTextStyleGoogle;
  final TextStyle connectButtonTextStyleApple;

  final double connectButtonIconSize;
  final Widget connectButtonIconEmail;
  final Widget connectButtonIconMobile;
  final Widget connectButtonIconGoogle;
  final Widget connectButtonIconApple;

  final TextStyle legalTextStyle;
  final EdgeInsets legalTextPadding;
  final TextStyle modalTitleTextStyle;

  final TextStyle titleStyle;

  final InputDecorationTheme inputDecorationTheme;
  final TextStyle inputTextStyle;
  final TextStyle inputErrorStyle;
  final TextAlignVertical inputTextAlignVertical;

  final ButtonStyle nextButtonStyle;
  final Size nextButtonProgressIndicatorSize;
  final Color nextButtonProgressIndicatorColor;
  final double nextButtonProgressIndicatorStrokeWidth;

  final EdgeInsets countryItemPadding;
  final Color countryItemHighlightColor;
  final TextStyle countryTextStyle;

  final PinTheme? codeInputThemeDefault;
  final PinTheme? codeInputThemeFocused;
  final PinTheme? codeInputThemeSubmitted;
  final PinTheme? codeInputThemeFollowing;
  final PinTheme? codeInputThemeDisabled;
  final PinTheme? codeInputThemeError;
}
