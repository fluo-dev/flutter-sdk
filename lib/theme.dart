import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class FluoTheme {
  factory FluoTheme() {
    if (kIsWeb) {
      return FluoTheme.web(
        primaryColor: Colors.black,
        inversePrimaryColor: Colors.white,
      );
    }
    return FluoTheme.native(
      primaryColor: Colors.black,
      inversePrimaryColor: Colors.white,
    );
  }

  factory FluoTheme.native({
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
    InputDecoration? inputDecoration,
    TextStyle? inputTextStyle,
    TextStyle? inputErrorStyle,
    TextAlignVertical? inputTextAlignVertical,
    ButtonStyle? nextButtonStyle,
    Size? nextButtonProgressIndicatorSize,
    Color? nextButtonProgressIndicatorColor,
    double? nextButtonProgressIndicatorStrokeWidth,
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

    connectButtonStyle ??= TextButton.styleFrom(
      splashFactory: NoSplash.splashFactory,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      minimumSize: const Size.fromHeight(54),
      enabledMouseCursor: SystemMouseCursors.click,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          width: 1.5,
        ),
      ),
    );

    connectButtonStyleGoogle ??= connectButtonStyle;

    connectButtonStyleApple ??= connectButtonStyle;

    connectButtonTextStyle ??= TextStyle(
      fontSize: 18,
      color: primaryColor,
      fontWeight: FontWeight.w700,
    );

    connectButtonTextStyleGoogle ??= connectButtonTextStyle;

    connectButtonTextStyleApple ??= connectButtonTextStyle;

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

    legalTextStyle ??= TextStyle(
      fontSize: 14,
      color: primaryColor.withAlpha((255 * 0.6).toInt()),
    );

    legalTextPadding ??= const EdgeInsets.only(
      top: 30.0,
      right: 50.0,
      left: 50.0,
    );

    modalTitleTextStyle ??= TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w600,
      color: primaryColor,
    );

    titleStyle ??= TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: primaryColor,
    );

    inputDecoration ??= InputDecoration(
      fillColor: inversePrimaryColor.withAlpha(255 ~/ 2),
      filled: true,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 15.0,
      ),
      hintStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: primaryColor.withAlpha(255 ~/ 3), // THEME
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      suffixIconConstraints: const BoxConstraints(
        maxHeight: 32,
        maxWidth: 32 + 10 + 15,
      ),
    );

    inputTextStyle ??= const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
    );

    inputErrorStyle ??= TextStyle(
      fontSize: 15,
      color: Colors.red.shade500,
    );

    inputTextAlignVertical ??= TextAlignVertical.center;

    nextButtonStyle ??= TextButton.styleFrom(
      splashFactory: NoSplash.splashFactory,
      minimumSize: const Size.fromHeight(54),
      enabledMouseCursor: SystemMouseCursors.click,
      textStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );

    nextButtonProgressIndicatorSize ??= const Size(16.0, 16.0);

    nextButtonProgressIndicatorColor ??= inversePrimaryColor;

    nextButtonProgressIndicatorStrokeWidth ??= 2.0;

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
      inputDecoration,
      inputTextStyle,
      inputErrorStyle,
      inputTextAlignVertical,
      nextButtonStyle,
      nextButtonProgressIndicatorSize,
      nextButtonProgressIndicatorColor,
      nextButtonProgressIndicatorStrokeWidth,
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
    InputDecoration? inputDecoration,
    TextStyle? inputTextStyle,
    TextStyle? inputErrorStyle,
    TextAlignVertical? inputTextAlignVertical,
    ButtonStyle? nextButtonStyle,
    Size? nextButtonProgressIndicatorSize,
    Color? nextButtonProgressIndicatorColor,
    double? nextButtonProgressIndicatorStrokeWidth,
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
      color: Colors.grey.shade900,
      fontWeight: FontWeight.w500,
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
    );

    titleStyle ??= TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: primaryColor,
    );

    inputDecoration ??= InputDecoration(
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
      inputDecoration,
      inputTextStyle,
      inputErrorStyle,
      inputTextAlignVertical,
      nextButtonStyle,
      nextButtonProgressIndicatorSize,
      nextButtonProgressIndicatorColor,
      nextButtonProgressIndicatorStrokeWidth,
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
    this.inputDecoration,
    this.inputTextStyle,
    this.inputErrorStyle,
    this.inputTextAlignVertical,
    this.nextButtonStyle,
    this.nextButtonProgressIndicatorSize,
    this.nextButtonProgressIndicatorColor,
    this.nextButtonProgressIndicatorStrokeWidth,
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

  final InputDecoration inputDecoration;
  final TextStyle inputTextStyle;
  final TextStyle inputErrorStyle;
  final TextAlignVertical inputTextAlignVertical;

  final ButtonStyle nextButtonStyle;
  final Size nextButtonProgressIndicatorSize;
  final Color nextButtonProgressIndicatorColor;
  final double nextButtonProgressIndicatorStrokeWidth;

  final PinTheme? codeInputThemeDefault;
  final PinTheme? codeInputThemeFocused;
  final PinTheme? codeInputThemeSubmitted;
  final PinTheme? codeInputThemeFollowing;
  final PinTheme? codeInputThemeDisabled;
  final PinTheme? codeInputThemeError;
}
