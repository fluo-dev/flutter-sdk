// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'fluo_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class FluoLocalizationsRu extends FluoLocalizations {
  FluoLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get acceptTerms =>
      'Продолжая, вы принимаете наши <terms>условия использования</terms> и <privacy>политику конфиденциальности</privacy>.';

  @override
  String get enterCode => 'Введите код подтверждения';

  @override
  String enterEmailCodeHelper(String email) {
    return 'Код был отправлен на <email>$email</email>. Если вы не получили письмо, проверьте папку со спамом.';
  }

  @override
  String get enterEmail => 'Введите ваш адрес электронной почты';

  @override
  String get enterEmailPlaceholder => 'example@domain.com';

  @override
  String get enterFirstName => 'Введите ваше имя';

  @override
  String get enterFirstNamePlaceholder => 'Имя';

  @override
  String get enterLastName => 'Введите вашу фамилию';

  @override
  String get enterLastNamePlaceholder => 'Фамилия';

  @override
  String get errorUnknown => 'Произошла ошибка при обработке вашего запроса.';

  @override
  String get errorCodeExpired => 'Срок действия кода истек.';

  @override
  String get errorCodeInvalid => 'Код недействителен.';

  @override
  String get errorInternal => 'Произошла внутренняя ошибка сервера.';

  @override
  String get errorNotFound => 'Ресурс не найден.';

  @override
  String get errorParameterInvalid => 'Отправленное значение недействительно.';

  @override
  String get errorParameterMissing => 'В запросе отсутствуют параметры.';

  @override
  String get errorSessionRevoked => 'Ваша сессия была отозвана.';

  @override
  String get errorUnauthorized => 'У вас нет необходимых прав доступа.';

  @override
  String get next => 'Далее';

  @override
  String get continueWithEmail => 'Продолжить с email';

  @override
  String get termsAndConditions => 'Условия использования';

  @override
  String get privacyPolicy => 'Политика конфиденциальности';

  @override
  String get continueWithGoogle => 'Продолжить с Google';

  @override
  String get continueWithApple => 'Продолжить с Apple';

  @override
  String get continueWithMobile => 'Продолжить с телефоном';

  @override
  String get enterMobile => 'Введите ваш номер телефона';

  @override
  String get searchCountry => 'Поиск страны';

  @override
  String enterMessageCodeHelper(String mobile) {
    return 'Код был отправлен на <mobile>$mobile</mobile>. Если вы не получили код в течение 2 минут, попробуйте снова.';
  }

  @override
  String get enterEmailHelper =>
      'Будет отправлен код подтверждения для проверки вашего адреса электронной почты. Пожалуйста, проверьте входящие сообщения.';

  @override
  String get enterMobileHelper =>
      'Будет отправлен код подтверждения для проверки вашего номера телефона. Убедитесь, что у вас есть доступ к сообщениям.';

  @override
  String get continueAction => 'Продолжить';
}
