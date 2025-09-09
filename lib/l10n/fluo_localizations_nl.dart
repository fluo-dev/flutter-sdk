// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'fluo_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class FluoLocalizationsNl extends FluoLocalizations {
  FluoLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get acceptTerms =>
      'Door verder te gaan, accepteert u onze <terms>algemene voorwaarden</terms> en ons <privacy>privacybeleid</privacy>.';

  @override
  String get enterCode => 'Voer de verificatiecode in';

  @override
  String enterEmailCodeHelper(String email) {
    return 'De code is verzonden naar <email>$email</email>. Als u geen e-mail heeft ontvangen, controleer dan uw spammap.';
  }

  @override
  String get enterEmail => 'Voer uw e-mailadres in';

  @override
  String get enterEmailPlaceholder => 'example@domain.com';

  @override
  String get enterFirstName => 'Voer uw voornaam in';

  @override
  String get enterFirstNamePlaceholder => 'Voornaam';

  @override
  String get enterLastName => 'Voer uw achternaam in';

  @override
  String get enterLastNamePlaceholder => 'Achternaam';

  @override
  String get errorUnknown =>
      'Er is een fout opgetreden bij het verwerken van uw verzoek.';

  @override
  String get errorCodeExpired => 'De code is verlopen.';

  @override
  String get errorCodeInvalid => 'De code is ongeldig.';

  @override
  String get errorInternal => 'Er is een interne serverfout opgetreden.';

  @override
  String get errorNotFound => 'De bron kon niet worden gevonden.';

  @override
  String get errorParameterInvalid => 'De verzonden waarde is ongeldig.';

  @override
  String get errorParameterMissing => 'Het verzoek mist parameters.';

  @override
  String get errorSessionRevoked => 'Uw sessie is ingetrokken.';

  @override
  String get errorUnauthorized => 'U heeft niet de juiste rechten.';

  @override
  String get next => 'Volgende';

  @override
  String get continueWithEmail => 'Doorgaan met e-mail';

  @override
  String get termsAndConditions => 'Algemene voorwaarden';

  @override
  String get privacyPolicy => 'Privacybeleid';

  @override
  String get continueWithGoogle => 'Doorgaan met Google';

  @override
  String get continueWithApple => 'Doorgaan met Apple';

  @override
  String get continueWithMobile => 'Doorgaan met mobiel';

  @override
  String get enterMobile => 'Voer uw mobiele nummer in';

  @override
  String get searchCountry => 'Zoek land';

  @override
  String enterMessageCodeHelper(String mobile) {
    return 'De code is verzonden naar <mobile>$mobile</mobile>. Als u de code binnen 2 minuten niet heeft ontvangen, probeer het opnieuw.';
  }

  @override
  String get enterEmailHelper =>
      'Er wordt een verificatiecode verzonden om uw e-mailadres te verifiëren. Controleer uw postvak in.';

  @override
  String get enterMobileHelper =>
      'Er wordt een verificatiecode verzonden om uw mobiele nummer te verifiëren. Zorg ervoor dat u toegang heeft tot berichten.';

  @override
  String get continueAction => 'Doorgaan';
}
