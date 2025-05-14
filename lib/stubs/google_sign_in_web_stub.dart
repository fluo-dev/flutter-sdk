class GoogleSignInPlugin {
  Future<void> init({
    required String clientId,
    required List<String> scopes,
  }) async {}
  Stream<dynamic>? get userDataEvents => null;
  dynamic renderButton({dynamic configuration}) => null;
}

// Stub classes for button configuration (if you use them)
class GSIButtonConfiguration {
  const GSIButtonConfiguration({
    this.theme,
    this.type,
    this.shape,
    this.text,
    this.size,
    this.locale,
    this.logoAlignment,
    this.minimumWidth,
  });

  final dynamic theme;
  final dynamic type;
  final dynamic shape;
  final dynamic text;
  final dynamic size;
  final dynamic locale;
  final dynamic logoAlignment;
  final dynamic minimumWidth;
}

class GSIButtonTheme {
  static const outline = null;
}

class GSIButtonType {
  static const standard = null;
}

class GSIButtonShape {
  static const rectangular = null;
}

class GSIButtonText {
  static const continueWith = null;
}

class GSIButtonSize {
  static const large = null;
}

class GSIButtonLogoAlignment {
  static const center = null;
}
