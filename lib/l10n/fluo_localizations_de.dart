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
  String enterEmailCodeHelper(String email) {
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

  @override
  String get continueWithGoogle => 'Mit Google fortfahren';

  @override
  String get continueWithApple => 'Mit Apple fortfahren';

  @override
  String get continueWithMobile => 'Mit Handy fortfahren';

  @override
  String get enterMobile => 'Geben Sie Ihre Handynummer ein';

  @override
  String get searchCountry => 'Land suchen';

  @override
  String enterMessageCodeHelper(String mobile) {
    return 'Der Code wurde an <mobile>$mobile</mobile> gesendet. Wenn Sie den Code innerhalb von 2 Minuten nicht erhalten haben, versuchen Sie es erneut.';
  }

  @override
  String get enterEmailHelper =>
      'Ein Bestätigungscode wird gesendet, um Ihre E-Mail-Adresse zu verifizieren. Bitte überprüfen Sie Ihren Posteingang.';

  @override
  String get enterMobileHelper =>
      'Ein Bestätigungscode wird gesendet, um Ihre Mobilfunknummer zu verifizieren. Bitte stellen Sie sicher, dass Sie Zugriff auf Ihre Nachrichten haben.';
}
