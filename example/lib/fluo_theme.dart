import 'package:fluo/fluo_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

FluoTheme fluoThemeBasic() {
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

FluoTheme fluoThemeColorful() {
  if (kIsWeb) {
    return FluoTheme.web(
      primaryColor: Colors.orange,
      inversePrimaryColor: Colors.blue.shade100,
    );
  }
  return FluoTheme.native(
    primaryColor: Colors.orange,
    inversePrimaryColor: Colors.blue.shade100,
  );
}
