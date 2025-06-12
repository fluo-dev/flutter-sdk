// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'fluo_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class FluoLocalizationsEs extends FluoLocalizations {
  FluoLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get acceptTerms =>
      'Al continuar, aceptas nuestros <terms>términos y condiciones</terms> y nuestra <privacy>política de privacidad</privacy>.';

  @override
  String get enterCode => 'Introduce el código de verificación';

  @override
  String enterEmailCodeHelper(String email) {
    return 'El código se envió a <email>$email</email>. Si no recibiste el correo electrónico, revisa tu carpeta de spam.';
  }

  @override
  String get enterEmail => 'Introduce tu dirección de correo electrónico';

  @override
  String get enterEmailPlaceholder => 'ejemplo@dominio.es';

  @override
  String get enterFirstName => 'Introduce tu nombre';

  @override
  String get enterFirstNamePlaceholder => 'Nombre';

  @override
  String get enterLastName => 'Introduce tu apellido';

  @override
  String get enterLastNamePlaceholder => 'Apellido';

  @override
  String get errorUnknown => 'Hubo un error al procesar tu solicitud.';

  @override
  String get errorCodeExpired => 'El código ha expirado.';

  @override
  String get errorCodeInvalid => 'El código no es válido.';

  @override
  String get errorInternal => 'Hubo un error interno del servidor.';

  @override
  String get errorNotFound => 'El recurso no se encontró.';

  @override
  String get errorParameterInvalid => 'El valor enviado no es válido.';

  @override
  String get errorParameterMissing => 'Faltan parámetros en la solicitud.';

  @override
  String get errorSessionRevoked => 'Tu sesión ha sido revocada.';

  @override
  String get errorUnauthorized => 'No tienes los permisos necesarios.';

  @override
  String get next => 'Siguiente';

  @override
  String get continueWithEmail => 'Continuar con el correo';

  @override
  String get termsAndConditions => 'Términos y condiciones';

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String get continueWithGoogle => 'Continuar con Google';

  @override
  String get continueWithApple => 'Continuar con Apple';

  @override
  String get continueWithMobile => 'Continuar con móvil';

  @override
  String get enterMobile => 'Introduce tu número de móvil';

  @override
  String get searchCountry => 'Buscar país';

  @override
  String enterMessageCodeHelper(String mobile) {
    return 'El código fue enviado a <mobile>$mobile</mobile>. Si no recibiste el código en 2 minutos, inténtalo de nuevo.';
  }

  @override
  String get enterEmailHelper =>
      'Se enviará un código de verificación para verificar tu dirección de correo electrónico. Asegúrate de revisar tu bandeja de entrada.';

  @override
  String get enterMobileHelper =>
      'Se enviará un código de verificación para verificar tu número de móvil. Asegúrate de tener acceso a los mensajes.';
}
