// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'fluo_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class FluoLocalizationsHi extends FluoLocalizations {
  FluoLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get acceptTerms =>
      'जारी रखकर, आप हमारी <terms>नियम और शर्तों</terms> और <privacy>गोपनीयता नीति</privacy> को स्वीकार करते हैं।';

  @override
  String get enterCode => 'सत्यापन कोड दर्ज करें';

  @override
  String enterEmailCodeHelper(String email) {
    return 'कोड <email>$email</email> पर भेजा गया है। यदि आपको ईमेल नहीं मिला है, तो कृपया अपने स्पैम फोल्डर की जांच करें।';
  }

  @override
  String get enterEmail => 'अपना ईमेल पता दर्ज करें';

  @override
  String get enterEmailPlaceholder => 'example@domain.com';

  @override
  String get enterFirstName => 'अपना पहला नाम दर्ज करें';

  @override
  String get enterFirstNamePlaceholder => 'पहला नाम';

  @override
  String get enterLastName => 'अपना अंतिम नाम दर्ज करें';

  @override
  String get enterLastNamePlaceholder => 'अंतिम नाम';

  @override
  String get errorUnknown => 'आपके अनुरोध को संसाधित करने में एक त्रुटि हुई।';

  @override
  String get errorCodeExpired => 'कोड की समय सीमा समाप्त हो गई है।';

  @override
  String get errorCodeInvalid => 'कोड मान्य नहीं है।';

  @override
  String get errorInternal => 'एक आंतरिक सर्वर त्रुटि हुई।';

  @override
  String get errorNotFound => 'संसाधन नहीं मिला।';

  @override
  String get errorParameterInvalid => 'भेजा गया मान मान्य नहीं है।';

  @override
  String get errorParameterMissing => 'अनुरोध में पैरामीटर गायब हैं।';

  @override
  String get errorSessionRevoked => 'आपका सत्र रद्द कर दिया गया है।';

  @override
  String get errorUnauthorized => 'आपके पास उचित अनुमतियां नहीं हैं।';

  @override
  String get next => 'अगला';

  @override
  String get continueWithEmail => 'ईमेल से जारी रखें';

  @override
  String get termsAndConditions => 'नियम और शर्तें';

  @override
  String get privacyPolicy => 'गोपनीयता नीति';

  @override
  String get continueWithGoogle => 'Google से जारी रखें';

  @override
  String get continueWithApple => 'Apple से जारी रखें';

  @override
  String get continueWithMobile => 'मोबाइल से जारी रखें';

  @override
  String get enterMobile => 'अपना मोबाइल नंबर दर्ज करें';

  @override
  String get searchCountry => 'देश खोजें';

  @override
  String enterMessageCodeHelper(String mobile) {
    return 'कोड <mobile>$mobile</mobile> पर भेजा गया है। यदि आपको 2 मिनट के भीतर कोड नहीं मिलता है, तो पुनः प्रयास करें।';
  }

  @override
  String get enterEmailHelper =>
      'आपके ईमेल पते को सत्यापित करने के लिए एक सत्यापन कोड भेजा जाएगा। कृपया अपना इनबॉक्स जांचें।';

  @override
  String get enterMobileHelper =>
      'आपके मोबाइल नंबर को सत्यापित करने के लिए एक सत्यापन कोड भेजा जाएगा। कृपया सुनिश्चित करें कि आपके पास संदेशों तक पहुंच है।';
}
