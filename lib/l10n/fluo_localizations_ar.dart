// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'fluo_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class FluoLocalizationsAr extends FluoLocalizations {
  FluoLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get acceptTerms =>
      'بالمتابعة، فإنك توافق على <terms>الشروط والأحكام</terms> و<privacy>سياسة الخصوصية</privacy> الخاصة بنا.';

  @override
  String get enterCode => 'أدخل رمز التحقق';

  @override
  String enterEmailCodeHelper(String email) {
    return 'تم إرسال الرمز إلى <email>$email</email>. إذا لم تستلم البريد الإلكتروني، يرجى التحقق من مجلد البريد العشوائي.';
  }

  @override
  String get enterEmail => 'أدخل عنوان بريدك الإلكتروني';

  @override
  String get enterEmailPlaceholder => 'example@domain.com';

  @override
  String get enterFirstName => 'أدخل اسمك الأول';

  @override
  String get enterFirstNamePlaceholder => 'الاسم الأول';

  @override
  String get enterLastName => 'أدخل اسم العائلة';

  @override
  String get enterLastNamePlaceholder => 'اسم العائلة';

  @override
  String get errorUnknown => 'حدث خطأ أثناء معالجة طلبك.';

  @override
  String get errorCodeExpired => 'انتهت صلاحية الرمز.';

  @override
  String get errorCodeInvalid => 'الرمز غير صالح.';

  @override
  String get errorInternal => 'حدث خطأ داخلي في الخادم.';

  @override
  String get errorNotFound => 'لم يتم العثور على المورد.';

  @override
  String get errorParameterInvalid => 'القيمة المرسلة غير صالحة.';

  @override
  String get errorParameterMissing => 'الطلب يفتقد إلى المعلمات.';

  @override
  String get errorSessionRevoked => 'تم إلغاء جلستك.';

  @override
  String get errorUnauthorized => 'ليس لديك الصلاحيات المناسبة.';

  @override
  String get next => 'التالي';

  @override
  String get continueWithEmail => 'المتابعة باستخدام البريد الإلكتروني';

  @override
  String get termsAndConditions => 'الشروط والأحكام';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get continueWithGoogle => 'المتابعة باستخدام Google';

  @override
  String get continueWithApple => 'المتابعة باستخدام Apple';

  @override
  String get continueWithMobile => 'المتابعة باستخدام الهاتف المحمول';

  @override
  String get enterMobile => 'أدخل رقم هاتفك المحمول';

  @override
  String get searchCountry => 'البحث عن الدولة';

  @override
  String enterMessageCodeHelper(String mobile) {
    return 'تم إرسال الرمز إلى <mobile>$mobile</mobile>. إذا لم تستلم الرمز خلال دقيقتين، حاول مرة أخرى.';
  }

  @override
  String get enterEmailHelper =>
      'سيتم إرسال رمز تحقق للتحقق من عنوان بريدك الإلكتروني. يرجى التأكد من فحص صندوق الوارد الخاص بك.';

  @override
  String get enterMobileHelper =>
      'سيتم إرسال رمز تحقق للتحقق من رقم هاتفك المحمول. يرجى التأكد من إمكانية الوصول إلى الرسائل.';

  @override
  String get continueAction => 'متابعة';
}
