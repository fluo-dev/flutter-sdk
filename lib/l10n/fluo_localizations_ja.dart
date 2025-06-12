// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'fluo_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class FluoLocalizationsJa extends FluoLocalizations {
  FluoLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get acceptTerms =>
      '続行することで、<terms>利用規約</terms>と<privacy>プライバシーポリシー</privacy>に同意したことになります。';

  @override
  String get enterCode => '認証コードを入力してください';

  @override
  String enterEmailCodeHelper(String email) {
    return '認証コードが<email>$email</email>に送信されました。メールが届かない場合は、迷惑メールフォルダをご確認ください。';
  }

  @override
  String get enterEmail => 'メールアドレスを入力してください';

  @override
  String get enterEmailPlaceholder => 'example@domain.com';

  @override
  String get enterFirstName => '名を入力してください';

  @override
  String get enterFirstNamePlaceholder => '名';

  @override
  String get enterLastName => '姓を入力してください';

  @override
  String get enterLastNamePlaceholder => '姓';

  @override
  String get errorUnknown => 'リクエストの処理中にエラーが発生しました。';

  @override
  String get errorCodeExpired => '認証コードの有効期限が切れました。';

  @override
  String get errorCodeInvalid => '認証コードが無効です。';

  @override
  String get errorInternal => 'サーバー内部エラーが発生しました。';

  @override
  String get errorNotFound => 'リソースが見つかりませんでした。';

  @override
  String get errorParameterInvalid => '送信された値が無効です。';

  @override
  String get errorParameterMissing => 'リクエストに必要なパラメータが不足しています。';

  @override
  String get errorSessionRevoked => 'セッションが無効になりました。';

  @override
  String get errorUnauthorized => '権限がありません。';

  @override
  String get next => '次へ';

  @override
  String get continueWithEmail => 'メールで続ける';

  @override
  String get termsAndConditions => '利用規約';

  @override
  String get privacyPolicy => 'プライバシーポリシー';

  @override
  String get continueWithGoogle => 'Googleで続ける';

  @override
  String get continueWithApple => 'Appleで続ける';

  @override
  String get continueWithMobile => '携帯電話で続ける';

  @override
  String get enterMobile => '携帯電話番号を入力してください';

  @override
  String get searchCountry => '国を検索';

  @override
  String enterMessageCodeHelper(String mobile) {
    return '認証コードが<mobile>$mobile</mobile>に送信されました。2分以内にコードが届かない場合は、もう一度お試しください。';
  }

  @override
  String get enterEmailHelper => 'メールアドレスの確認のため、認証コードが送信されます。';

  @override
  String get enterMobileHelper => '携帯電話番号の確認のため、認証コードが送信されます。';
}
