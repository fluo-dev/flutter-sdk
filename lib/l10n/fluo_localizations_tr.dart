// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'fluo_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class FluoLocalizationsTr extends FluoLocalizations {
  FluoLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get acceptTerms =>
      'Devam ederek <terms>kullanım koşullarımızı</terms> ve <privacy>gizlilik politikamızı</privacy> kabul etmiş olursunuz.';

  @override
  String get enterCode => 'Doğrulama kodunu girin';

  @override
  String enterEmailCodeHelper(String email) {
    return 'Kod <email>$email</email> adresine gönderildi. E-posta almadıysanız, spam klasörünüzü kontrol edin.';
  }

  @override
  String get enterEmail => 'E-posta adresinizi girin';

  @override
  String get enterEmailPlaceholder => 'example@domain.com';

  @override
  String get enterFirstName => 'Adınızı girin';

  @override
  String get enterFirstNamePlaceholder => 'Ad';

  @override
  String get enterLastName => 'Soyadınızı girin';

  @override
  String get enterLastNamePlaceholder => 'Soyad';

  @override
  String get errorUnknown => 'İsteğiniz işlenirken bir hata oluştu.';

  @override
  String get errorCodeExpired => 'Kodun süresi doldu.';

  @override
  String get errorCodeInvalid => 'Kod geçersiz.';

  @override
  String get errorInternal => 'Sunucu iç hatası oluştu.';

  @override
  String get errorNotFound => 'Kaynak bulunamadı.';

  @override
  String get errorParameterInvalid => 'Gönderilen değer geçersiz.';

  @override
  String get errorParameterMissing => 'İstek parametreleri eksik.';

  @override
  String get errorSessionRevoked => 'Oturumunuz sonlandırıldı.';

  @override
  String get errorUnauthorized => 'Gerekli izinlere sahip değilsiniz.';

  @override
  String get next => 'İleri';

  @override
  String get continueWithEmail => 'E-posta ile devam et';

  @override
  String get termsAndConditions => 'Kullanım koşulları';

  @override
  String get privacyPolicy => 'Gizlilik politikası';

  @override
  String get continueWithGoogle => 'Google ile devam et';

  @override
  String get continueWithApple => 'Apple ile devam et';

  @override
  String get continueWithMobile => 'Mobil ile devam et';

  @override
  String get enterMobile => 'Cep telefonu numaranızı girin';

  @override
  String get searchCountry => 'Ülke ara';

  @override
  String enterMessageCodeHelper(String mobile) {
    return 'Kod <mobile>$mobile</mobile> numarasına gönderildi. 2 dakika içinde kodu almadıysanız, tekrar deneyin.';
  }

  @override
  String get enterEmailHelper =>
      'E-posta adresinizi doğrulamak için bir doğrulama kodu gönderilecek.';

  @override
  String get enterMobileHelper =>
      'Cep telefonu numaranızı doğrulamak için bir doğrulama kodu gönderilecek.';
}
