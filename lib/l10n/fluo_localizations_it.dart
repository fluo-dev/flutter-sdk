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
  String enterCodeHelper(String email) {
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
}
