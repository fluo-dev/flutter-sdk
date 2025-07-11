// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'fluo_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class FluoLocalizationsIt extends FluoLocalizations {
  FluoLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get acceptTerms =>
      'Continuando, accetti i nostri <terms>termini e condizioni</terms> e la nostra <privacy>informativa sulla privacy</privacy>.';

  @override
  String get enterCode => 'Inserisci il codice di verifica';

  @override
  String enterEmailCodeHelper(String email) {
    return 'Il codice è stato inviato a <email>$email</email>. Se non hai ricevuto l\'e-mail, controlla la cartella spam.';
  }

  @override
  String get enterEmail => 'Inserisci il tuo indirizzo e-mail';

  @override
  String get enterEmailPlaceholder => 'esempio@dominio.it';

  @override
  String get enterFirstName => 'Inserisci il tuo nome';

  @override
  String get enterFirstNamePlaceholder => 'Nome';

  @override
  String get enterLastName => 'Inserisci il tuo cognome';

  @override
  String get enterLastNamePlaceholder => 'Cognome';

  @override
  String get errorUnknown =>
      'Si è verificato un errore durante l\'elaborazione della tua richiesta.';

  @override
  String get errorCodeExpired => 'Il codice è scaduto.';

  @override
  String get errorCodeInvalid => 'Il codice non è valido.';

  @override
  String get errorInternal => 'Si è verificato un errore interno del server.';

  @override
  String get errorNotFound => 'La risorsa non è stata trovata.';

  @override
  String get errorParameterInvalid => 'Il valore inviato non è valido.';

  @override
  String get errorParameterMissing => 'Mancano dei parametri nella richiesta.';

  @override
  String get errorSessionRevoked => 'La tua sessione è stata revocata.';

  @override
  String get errorUnauthorized => 'Non hai i permessi necessari.';

  @override
  String get next => 'Avanti';

  @override
  String get continueWithEmail => 'Continua con l\'email';

  @override
  String get termsAndConditions => 'Termini e condizioni';

  @override
  String get privacyPolicy => 'Informativa sulla privacy';

  @override
  String get continueWithGoogle => 'Continua con Google';

  @override
  String get continueWithApple => 'Continua con Apple';

  @override
  String get continueWithMobile => 'Continua con cellulare';

  @override
  String get enterMobile => 'Inserisci il tuo numero di cellulare';

  @override
  String get searchCountry => 'Cerca paese';

  @override
  String enterMessageCodeHelper(String mobile) {
    return 'Il codice è stato inviato a <mobile>$mobile</mobile>. Se non hai ricevuto il codice entro 2 minuti, riprova.';
  }

  @override
  String get enterEmailHelper =>
      'Un codice di verifica verrà inviato per verificare il tuo indirizzo email. Assicurati di controllare la tua casella di posta in arrivo.';

  @override
  String get enterMobileHelper =>
      'Un codice di verifica verrà inviato per verificare il tuo numero di cellulare. Assicurati di avere accesso ai messaggi.';
}
