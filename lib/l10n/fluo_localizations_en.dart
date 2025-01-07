import 'fluo_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class FluoLocalizationsEn extends FluoLocalizations {
  FluoLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get acceptTerms =>
      'By continuing, you accept our <terms>terms & conditions</terms> and our <privacy>privacy policy</privacy>.';

  @override
  String get enterCode => 'Enter the verification code';

  @override
  String enterCodeHelper(String email) {
    return 'The code was sent to <email>$email</email>. If you did not receive an email, you may check your spam folder.';
  }

  @override
  String get enterEmail => 'Enter your e-mail address';

  @override
  String get enterEmailPlaceholder => 'example@domain.com';

  @override
  String get enterFirstName => 'Enter your first name';

  @override
  String get enterFirstNamePlaceholder => 'First Name';

  @override
  String get enterLastName => 'Enter your last name';

  @override
  String get enterLastNamePlaceholder => 'Last Name';

  @override
  String get errorUnknown => 'There was an error processing your request.';

  @override
  String get errorCodeExpired => 'The code has expired.';

  @override
  String get errorCodeInvalid => 'The code is not valid.';

  @override
  String get errorInternal => 'There was an internal server error.';

  @override
  String get errorNotFound => 'The resource could not be found.';

  @override
  String get errorParameterInvalid => 'The value sent is not valid.';

  @override
  String get errorParameterMissing => 'The request is missing parameters.';

  @override
  String get errorSessionRevoked => 'Your session was revoked.';

  @override
  String get errorUnauthorized => 'You do not have the right permissions.';

  @override
  String get next => 'Next';

  @override
  String get continueWithEmail => 'Continue with e-mail';
}
