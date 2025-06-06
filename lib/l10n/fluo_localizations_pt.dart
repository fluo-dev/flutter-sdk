// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'fluo_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class FluoLocalizationsPt extends FluoLocalizations {
  FluoLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get acceptTerms =>
      'Ao continuar, aceita os nossos <terms>termos e condições</terms> e a nossa <privacy>política de privacidade</privacy>.';

  @override
  String get enterCode => 'Introduza o código de verificação';

  @override
  String enterCodeHelper(String email) {
    return 'O código foi enviado para <email>$email</email>. Se não recebeu um email, pode verificar a sua pasta de spam.';
  }

  @override
  String get enterEmail => 'Introduza o seu endereço de email';

  @override
  String get enterEmailPlaceholder => 'exemplo@dominio.com';

  @override
  String get enterFirstName => 'Introduza o seu primeiro nome';

  @override
  String get enterFirstNamePlaceholder => 'Primeiro Nome';

  @override
  String get enterLastName => 'Introduza o seu apelido';

  @override
  String get enterLastNamePlaceholder => 'Apelido';

  @override
  String get errorUnknown => 'Ocorreu um erro ao processar o seu pedido.';

  @override
  String get errorCodeExpired => 'O código expirou.';

  @override
  String get errorCodeInvalid => 'O código não é válido.';

  @override
  String get errorInternal => 'Ocorreu um erro interno do servidor.';

  @override
  String get errorNotFound => 'Não foi possível encontrar o recurso.';

  @override
  String get errorParameterInvalid => 'O valor enviado não é válido.';

  @override
  String get errorParameterMissing =>
      'O pedido não tem os parâmetros necessários.';

  @override
  String get errorSessionRevoked => 'A sua sessão foi revogada.';

  @override
  String get errorUnauthorized => 'Não tem as permissões necessárias.';

  @override
  String get next => 'Seguinte';

  @override
  String get continueWithEmail => 'Continuar com o e-mail';

  @override
  String get termsAndConditions => 'Termos e condições';

  @override
  String get privacyPolicy => 'Política de privacidade';

  @override
  String get continueWithGoogle => 'Continuar com Google';

  @override
  String get continueWithApple => 'Continuar com Apple';

  @override
  String get continueWithMobile => 'Continuar com celular';

  @override
  String get enterMobile => 'Digite seu número de celular';
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class FluoLocalizationsPtBr extends FluoLocalizationsPt {
  FluoLocalizationsPtBr() : super('pt_BR');

  @override
  String get acceptTerms =>
      'Ao continuar, você aceita nossos <terms>termos e condições</terms> e nossa <privacy>política de privacidade</privacy>.';

  @override
  String get enterCode => 'Digite o código de verificação';

  @override
  String enterCodeHelper(String email) {
    return 'O código foi enviado para <email>$email</email>. Se você não recebeu um e-mail, pode verificar sua pasta de spam.';
  }

  @override
  String get enterEmail => 'Digite seu endereço de e-mail';

  @override
  String get enterEmailPlaceholder => 'exemplo@dominio.com';

  @override
  String get enterFirstName => 'Digite seu primeiro nome';

  @override
  String get enterFirstNamePlaceholder => 'Nome';

  @override
  String get enterLastName => 'Digite seu sobrenome';

  @override
  String get enterLastNamePlaceholder => 'Sobrenome';

  @override
  String get errorUnknown => 'Ocorreu um erro ao processar sua solicitação.';

  @override
  String get errorCodeExpired => 'O código expirou.';

  @override
  String get errorCodeInvalid => 'O código não é válido.';

  @override
  String get errorInternal => 'Ocorreu um erro interno do servidor.';

  @override
  String get errorNotFound => 'O recurso não pôde ser encontrado.';

  @override
  String get errorParameterInvalid => 'O valor enviado não é válido.';

  @override
  String get errorParameterMissing => 'A solicitação está faltando parâmetros.';

  @override
  String get errorSessionRevoked => 'Sua sessão foi revogada.';

  @override
  String get errorUnauthorized => 'Você não tem as permissões corretas.';

  @override
  String get next => 'Próximo';

  @override
  String get continueWithEmail => 'Continuar com o e-mail';

  @override
  String get termsAndConditions => 'Termos e condições';

  @override
  String get privacyPolicy => 'Política de privacidade';

  @override
  String get continueWithGoogle => 'Continuar com Google';

  @override
  String get continueWithApple => 'Continuar com Apple';

  @override
  String get continueWithMobile => 'Continuar com o celular';
}
