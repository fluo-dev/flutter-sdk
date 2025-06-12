// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'fluo_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class FluoLocalizationsZh extends FluoLocalizations {
  FluoLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get acceptTerms =>
      '继续即表示您接受我们的<terms>条款和条件</terms>以及<privacy>隐私政策</privacy>。';

  @override
  String get enterCode => '输入验证码';

  @override
  String enterEmailCodeHelper(String email) {
    return '验证码已发送至<email>$email</email>。如果您没有收到邮件，请检查垃圾邮件文件夹。';
  }

  @override
  String get enterEmail => '输入您的电子邮箱地址';

  @override
  String get enterEmailPlaceholder => 'example@domain.com';

  @override
  String get enterFirstName => '输入您的名字';

  @override
  String get enterFirstNamePlaceholder => '名字';

  @override
  String get enterLastName => '输入您的姓氏';

  @override
  String get enterLastNamePlaceholder => '姓氏';

  @override
  String get errorUnknown => '处理您的请求时出现错误。';

  @override
  String get errorCodeExpired => '验证码已过期。';

  @override
  String get errorCodeInvalid => '验证码无效。';

  @override
  String get errorInternal => '服务器内部错误。';

  @override
  String get errorNotFound => '找不到请求的资源。';

  @override
  String get errorParameterInvalid => '发送的值无效。';

  @override
  String get errorParameterMissing => '请求缺少参数。';

  @override
  String get errorSessionRevoked => '您的会话已被撤销。';

  @override
  String get errorUnauthorized => '您没有相应的权限。';

  @override
  String get next => '下一步';

  @override
  String get continueWithEmail => '使用邮箱继续';

  @override
  String get termsAndConditions => '条款和条件';

  @override
  String get privacyPolicy => '隐私政策';

  @override
  String get continueWithGoogle => '使用谷歌继续';

  @override
  String get continueWithApple => '使用苹果继续';

  @override
  String get continueWithMobile => '使用手机继续';

  @override
  String get enterMobile => '输入您的手机号码';

  @override
  String get searchCountry => '搜索国家';

  @override
  String enterMessageCodeHelper(String mobile) {
    return '验证码已发送至<mobile>$mobile</mobile>。如果您在2分钟内没有收到验证码，请重试。';
  }

  @override
  String get enterEmailHelper => '将发送验证码以验证您的电子邮箱地址。请确保查看您的收件箱。';

  @override
  String get enterMobileHelper => '将发送验证码以验证您的手机号码。请确保您能收到短信。';
}
