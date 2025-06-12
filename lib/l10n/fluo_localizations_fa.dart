// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'fluo_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class FluoLocalizationsFa extends FluoLocalizations {
  FluoLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get acceptTerms =>
      'با ادامه، شما <terms>شرایط و ضوابط</terms> و <privacy>سیاست حریم خصوصی</privacy> ما را می‌پذیرید.';

  @override
  String get enterCode => 'کد تأیید را وارد کنید';

  @override
  String enterEmailCodeHelper(String email) {
    return 'کد به <email>$email</email> ارسال شد. اگر ایمیلی دریافت نکردید، پوشه اسپم خود را بررسی کنید.';
  }

  @override
  String get enterEmail => 'آدرس ایمیل خود را وارد کنید';

  @override
  String get enterEmailPlaceholder => 'example@domain.com';

  @override
  String get enterFirstName => 'نام خود را وارد کنید';

  @override
  String get enterFirstNamePlaceholder => 'نام';

  @override
  String get enterLastName => 'نام خانوادگی خود را وارد کنید';

  @override
  String get enterLastNamePlaceholder => 'نام خانوادگی';

  @override
  String get errorUnknown => 'خطایی در پردازش درخواست شما رخ داد.';

  @override
  String get errorCodeExpired => 'کد منقضی شده است.';

  @override
  String get errorCodeInvalid => 'کد معتبر نیست.';

  @override
  String get errorInternal => 'خطای داخلی سرور رخ داده است.';

  @override
  String get errorNotFound => 'منبع مورد نظر یافت نشد.';

  @override
  String get errorParameterInvalid => 'مقدار ارسال‌ شده معتبر نیست.';

  @override
  String get errorParameterMissing => 'درخواست شامل پارامترهای ناقص است.';

  @override
  String get errorSessionRevoked => 'نشست شما لغو شده است.';

  @override
  String get errorUnauthorized => 'شما مجوز لازم را ندارید.';

  @override
  String get next => 'بعدی';

  @override
  String get continueWithEmail => 'ادامه با ایمیل';

  @override
  String get termsAndConditions => 'شرایط و ضوابط';

  @override
  String get privacyPolicy => 'سیاست حریم خصوصی';

  @override
  String get continueWithGoogle => 'ادامه با گوگل';

  @override
  String get continueWithApple => 'ادامه با اپل';

  @override
  String get continueWithMobile => 'ادامه با موبایل';

  @override
  String get enterMobile => 'شماره موبایل خود را وارد کنید';

  @override
  String get searchCountry => 'جستجوی کشور';

  @override
  String enterMessageCodeHelper(String mobile) {
    return 'کد به <mobile>$mobile</mobile> ارسال شد. اگر کد را در عرض ۲ دقیقه دریافت نکردید، دوباره تلاش کنید.';
  }

  @override
  String get enterEmailHelper =>
      'یک کد تأیید برای تأیید آدرس ایمیل شما ارسال خواهد شد. لطفاً صندوق ورودی خود را بررسی کنید.';

  @override
  String get enterMobileHelper =>
      'یک کد تأیید برای تأیید شماره موبایل شما ارسال خواهد شد. لطفاً مطمئن شوید که به پیام‌ها دسترسی دارید.';
}
