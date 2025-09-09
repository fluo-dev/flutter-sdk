// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'fluo_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class FluoLocalizationsSv extends FluoLocalizations {
  FluoLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get acceptTerms =>
      'Genom att fortsätta accepterar du våra <terms>användarvillkor</terms> och vår <privacy>integritetspolicy</privacy>.';

  @override
  String get enterCode => 'Ange verifieringskoden';

  @override
  String enterEmailCodeHelper(String email) {
    return 'Koden har skickats till <email>$email</email>. Om du inte har fått något e-postmeddelande, kontrollera din skräppost.';
  }

  @override
  String get enterEmail => 'Ange din e-postadress';

  @override
  String get enterEmailPlaceholder => 'example@domain.com';

  @override
  String get enterFirstName => 'Ange ditt förnamn';

  @override
  String get enterFirstNamePlaceholder => 'Förnamn';

  @override
  String get enterLastName => 'Ange ditt efternamn';

  @override
  String get enterLastNamePlaceholder => 'Efternamn';

  @override
  String get errorUnknown => 'Ett fel uppstod när din förfrågan behandlades.';

  @override
  String get errorCodeExpired => 'Koden har gått ut.';

  @override
  String get errorCodeInvalid => 'Koden är ogiltig.';

  @override
  String get errorInternal => 'Ett internt serverfel uppstod.';

  @override
  String get errorNotFound => 'Resursen kunde inte hittas.';

  @override
  String get errorParameterInvalid => 'Det skickade värdet är ogiltigt.';

  @override
  String get errorParameterMissing => 'Förfrågan saknar parametrar.';

  @override
  String get errorSessionRevoked => 'Din session har återkallats.';

  @override
  String get errorUnauthorized => 'Du har inte rätt behörighet.';

  @override
  String get next => 'Nästa';

  @override
  String get continueWithEmail => 'Fortsätt med e-post';

  @override
  String get termsAndConditions => 'Användarvillkor';

  @override
  String get privacyPolicy => 'Integritetspolicy';

  @override
  String get continueWithGoogle => 'Fortsätt med Google';

  @override
  String get continueWithApple => 'Fortsätt med Apple';

  @override
  String get continueWithMobile => 'Fortsätt med mobil';

  @override
  String get enterMobile => 'Ange ditt mobilnummer';

  @override
  String get searchCountry => 'Sök land';

  @override
  String enterMessageCodeHelper(String mobile) {
    return 'Koden har skickats till <mobile>$mobile</mobile>. Om du inte har fått koden inom 2 minuter, försök igen.';
  }

  @override
  String get enterEmailHelper =>
      'En verifieringskod kommer att skickas för att verifiera din e-postadress. Kontrollera din inkorg.';

  @override
  String get enterMobileHelper =>
      'En verifieringskod kommer att skickas för att verifiera ditt mobilnummer. Se till att du har tillgång till meddelanden.';

  @override
  String get continueAction => 'Fortsätt';
}
