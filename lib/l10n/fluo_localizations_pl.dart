// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'fluo_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class FluoLocalizationsPl extends FluoLocalizations {
  FluoLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get acceptTerms =>
      'Kontynuując, akceptujesz nasze <terms>warunki użytkowania</terms> i <privacy>politykę prywatności</privacy>.';

  @override
  String get enterCode => 'Wprowadź kod weryfikacyjny';

  @override
  String enterEmailCodeHelper(String email) {
    return 'Kod został wysłany na adres <email>$email</email>. Jeśli nie otrzymałeś e-maila, sprawdź folder ze spamem.';
  }

  @override
  String get enterEmail => 'Wprowadź swój adres e-mail';

  @override
  String get enterEmailPlaceholder => 'example@domain.com';

  @override
  String get enterFirstName => 'Wprowadź swoje imię';

  @override
  String get enterFirstNamePlaceholder => 'Imię';

  @override
  String get enterLastName => 'Wprowadź swoje nazwisko';

  @override
  String get enterLastNamePlaceholder => 'Nazwisko';

  @override
  String get errorUnknown =>
      'Wystąpił błąd podczas przetwarzania Twojego żądania.';

  @override
  String get errorCodeExpired => 'Kod wygasł.';

  @override
  String get errorCodeInvalid => 'Kod jest nieprawidłowy.';

  @override
  String get errorInternal => 'Wystąpił wewnętrzny błąd serwera.';

  @override
  String get errorNotFound => 'Nie znaleziono zasobu.';

  @override
  String get errorParameterInvalid => 'Wysłana wartość jest nieprawidłowa.';

  @override
  String get errorParameterMissing =>
      'Żądanie nie zawiera wymaganych parametrów.';

  @override
  String get errorSessionRevoked => 'Twoja sesja została unieważniona.';

  @override
  String get errorUnauthorized => 'Nie masz odpowiednich uprawnień.';

  @override
  String get next => 'Dalej';

  @override
  String get continueWithEmail => 'Kontynuuj z e-mailem';

  @override
  String get termsAndConditions => 'Warunki użytkowania';

  @override
  String get privacyPolicy => 'Polityka prywatności';

  @override
  String get continueWithGoogle => 'Kontynuuj z Google';

  @override
  String get continueWithApple => 'Kontynuuj z Apple';

  @override
  String get continueWithMobile => 'Kontynuuj z telefonem';

  @override
  String get enterMobile => 'Wprowadź swój numer telefonu';

  @override
  String get searchCountry => 'Szukaj kraju';

  @override
  String enterMessageCodeHelper(String mobile) {
    return 'Kod został wysłany na numer <mobile>$mobile</mobile>. Jeśli nie otrzymasz kodu w ciągu 2 minut, spróbuj ponownie.';
  }

  @override
  String get enterEmailHelper =>
      'Zostanie wysłany kod weryfikacyjny w celu potwierdzenia Twojego adresu e-mail. Sprawdź swoją skrzynkę odbiorczą.';

  @override
  String get enterMobileHelper =>
      'Zostanie wysłany kod weryfikacyjny w celu potwierdzenia Twojego numeru telefonu. Upewnij się, że masz dostęp do wiadomości.';
}
