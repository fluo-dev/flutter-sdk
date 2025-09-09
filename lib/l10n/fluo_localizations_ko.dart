// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'fluo_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class FluoLocalizationsKo extends FluoLocalizations {
  FluoLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get acceptTerms =>
      '계속하시면 <terms>이용약관</terms>과 <privacy>개인정보 처리방침</privacy>에 동의하게 됩니다.';

  @override
  String get enterCode => '인증 코드를 입력하세요';

  @override
  String enterEmailCodeHelper(String email) {
    return '인증 코드가 <email>$email</email>로 전송되었습니다. 이메일을 받지 못한 경우 스팸 폴더를 확인해 주세요.';
  }

  @override
  String get enterEmail => '이메일 주소를 입력하세요';

  @override
  String get enterEmailPlaceholder => 'example@domain.com';

  @override
  String get enterFirstName => '이름을 입력하세요';

  @override
  String get enterFirstNamePlaceholder => '이름';

  @override
  String get enterLastName => '성을 입력하세요';

  @override
  String get enterLastNamePlaceholder => '성';

  @override
  String get errorUnknown => '요청을 처리하는 중 오류가 발생했습니다.';

  @override
  String get errorCodeExpired => '인증 코드가 만료되었습니다.';

  @override
  String get errorCodeInvalid => '인증 코드가 유효하지 않습니다.';

  @override
  String get errorInternal => '서버 내부 오류가 발생했습니다.';

  @override
  String get errorNotFound => '요청한 리소스를 찾을 수 없습니다.';

  @override
  String get errorParameterInvalid => '전송된 값이 유효하지 않습니다.';

  @override
  String get errorParameterMissing => '요청에 필요한 매개변수가 누락되었습니다.';

  @override
  String get errorSessionRevoked => '세션이 취소되었습니다.';

  @override
  String get errorUnauthorized => '권한이 없습니다.';

  @override
  String get next => '다음';

  @override
  String get continueWithEmail => '이메일로 계속하기';

  @override
  String get termsAndConditions => '이용약관';

  @override
  String get privacyPolicy => '개인정보 처리방침';

  @override
  String get continueWithGoogle => 'Google로 계속하기';

  @override
  String get continueWithApple => 'Apple로 계속하기';

  @override
  String get continueWithMobile => '휴대폰으로 계속하기';

  @override
  String get enterMobile => '휴대폰 번호를 입력하세요';

  @override
  String get searchCountry => '국가 검색';

  @override
  String enterMessageCodeHelper(String mobile) {
    return '인증 코드가 <mobile>$mobile</mobile>로 전송되었습니다. 2분 이내에 코드를 받지 못한 경우 다시 시도해 주세요.';
  }

  @override
  String get enterEmailHelper => '이메일 주소 확인을 위해 인증 코드가 전송됩니다. 받은 편지함을 확인해 주세요.';

  @override
  String get enterMobileHelper =>
      '휴대폰 번호 확인을 위해 인증 코드가 전송됩니다. 메시지에 접근할 수 있는지 확인해 주세요.';

  @override
  String get continueAction => '계속';
}
