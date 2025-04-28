// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'fluo_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class FluoLocalizationsDe extends FluoLocalizations {
  FluoLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get acceptTerms =>
      'Mit dem Fortfahren akzeptieren Sie unsere <terms>Geschäftsbedingungen</terms> und unsere <privacy>Datenschutzrichtlinie</privacy>.';

  @override
  String get enterCode => 'Bestätigungscode eingeben';

  @override
  String enterCodeHelper(String email) {
    return 'Der Code wurde an <email>$email</email> gesendet. Falls Sie keine E-Mail erhalten haben, überprüfen Sie bitte Ihren Spam-Ordner.';
  }

  @override
  String get enterEmail => 'Geben Sie Ihre E-Mail-Adresse ein';

  @override
  String get enterEmailPlaceholder => 'beispiel@domain.de';

  @override
  String get enterFirstName => 'Geben Sie Ihren Vornamen ein';

  @override
  String get enterFirstNamePlaceholder => 'Vorname';

  @override
  String get enterLastName => 'Geben Sie Ihren Nachnamen ein';

  @override
  String get enterLastNamePlaceholder => 'Nachname';

  @override
  String get errorUnknown =>
      'Bei der Verarbeitung Ihrer Anfrage ist ein Fehler aufgetreten.';

  @override
  String get errorCodeExpired => 'Der Code ist abgelaufen.';

  @override
  String get errorCodeInvalid => 'Der Code ist ungültig.';

  @override
  String get errorInternal => 'Ein interner Serverfehler ist aufgetreten.';

  @override
  String get errorNotFound => 'Die Ressource konnte nicht gefunden werden.';

  @override
  String get errorParameterInvalid => 'Der gesendete Wert ist ungültig.';

  @override
  String get errorParameterMissing => 'Der Anfrage fehlen Parameter.';

  @override
  String get errorSessionRevoked => 'Ihre Sitzung wurde widerrufen.';

  @override
  String get errorUnauthorized =>
      'Sie haben nicht die richtigen Berechtigungen.';

  @override
  String get next => 'Weiter';

  @override
  String get continueWithEmail => 'Mit E-Mail fortfahren';

  @override
  String get termsAndConditions => 'Geschäftsbedingungen';

  @override
  String get privacyPolicy => 'Datenschutzrichtlinie';
}
