import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'fluo_localizations_ar.dart';
import 'fluo_localizations_de.dart';
import 'fluo_localizations_en.dart';
import 'fluo_localizations_es.dart';
import 'fluo_localizations_fa.dart';
import 'fluo_localizations_fr.dart';
import 'fluo_localizations_hi.dart';
import 'fluo_localizations_it.dart';
import 'fluo_localizations_ja.dart';
import 'fluo_localizations_ko.dart';
import 'fluo_localizations_nl.dart';
import 'fluo_localizations_pl.dart';
import 'fluo_localizations_pt.dart';
import 'fluo_localizations_ru.dart';
import 'fluo_localizations_sv.dart';
import 'fluo_localizations_tr.dart';
import 'fluo_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of FluoLocalizations
/// returned by `FluoLocalizations.of(context)`.
///
/// Applications need to include `FluoLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/fluo_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: FluoLocalizations.localizationsDelegates,
///   supportedLocales: FluoLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the FluoLocalizations.supportedLocales
/// property.
abstract class FluoLocalizations {
  FluoLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static FluoLocalizations? of(BuildContext context) {
    return Localizations.of<FluoLocalizations>(context, FluoLocalizations);
  }

  static const LocalizationsDelegate<FluoLocalizations> delegate =
      _FluoLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fa'),
    Locale('fr'),
    Locale('hi'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('nl'),
    Locale('pl'),
    Locale('pt'),
    Locale('pt', 'BR'),
    Locale('ru'),
    Locale('sv'),
    Locale('tr'),
    Locale('zh')
  ];

  /// No description provided for @acceptTerms.
  ///
  /// In en, this message translates to:
  /// **'By continuing, you accept our <terms>terms & conditions</terms> and our <privacy>privacy policy</privacy>.'**
  String get acceptTerms;

  /// No description provided for @enterCode.
  ///
  /// In en, this message translates to:
  /// **'Enter the verification code'**
  String get enterCode;

  /// No description provided for @enterEmailCodeHelper.
  ///
  /// In en, this message translates to:
  /// **'The code was sent to <email>{email}</email>. If you did not receive an email, you may check your spam folder.'**
  String enterEmailCodeHelper(String email);

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your e-mail address'**
  String get enterEmail;

  /// No description provided for @enterEmailPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'example@domain.com'**
  String get enterEmailPlaceholder;

  /// No description provided for @enterFirstName.
  ///
  /// In en, this message translates to:
  /// **'Enter your first name'**
  String get enterFirstName;

  /// No description provided for @enterFirstNamePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get enterFirstNamePlaceholder;

  /// No description provided for @enterLastName.
  ///
  /// In en, this message translates to:
  /// **'Enter your last name'**
  String get enterLastName;

  /// No description provided for @enterLastNamePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get enterLastNamePlaceholder;

  /// No description provided for @errorUnknown.
  ///
  /// In en, this message translates to:
  /// **'There was an error processing your request.'**
  String get errorUnknown;

  /// No description provided for @errorCodeExpired.
  ///
  /// In en, this message translates to:
  /// **'The code has expired.'**
  String get errorCodeExpired;

  /// No description provided for @errorCodeInvalid.
  ///
  /// In en, this message translates to:
  /// **'The code is not valid.'**
  String get errorCodeInvalid;

  /// No description provided for @errorInternal.
  ///
  /// In en, this message translates to:
  /// **'There was an internal server error.'**
  String get errorInternal;

  /// No description provided for @errorNotFound.
  ///
  /// In en, this message translates to:
  /// **'The resource could not be found.'**
  String get errorNotFound;

  /// No description provided for @errorParameterInvalid.
  ///
  /// In en, this message translates to:
  /// **'The value sent is not valid.'**
  String get errorParameterInvalid;

  /// No description provided for @errorParameterMissing.
  ///
  /// In en, this message translates to:
  /// **'The request is missing parameters.'**
  String get errorParameterMissing;

  /// No description provided for @errorSessionRevoked.
  ///
  /// In en, this message translates to:
  /// **'Your session was revoked.'**
  String get errorSessionRevoked;

  /// No description provided for @errorUnauthorized.
  ///
  /// In en, this message translates to:
  /// **'You do not have the right permissions.'**
  String get errorUnauthorized;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @continueWithEmail.
  ///
  /// In en, this message translates to:
  /// **'Continue with email'**
  String get continueWithEmail;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms and conditions'**
  String get termsAndConditions;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get privacyPolicy;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @continueWithApple.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get continueWithApple;

  /// No description provided for @continueWithMobile.
  ///
  /// In en, this message translates to:
  /// **'Continue with mobile'**
  String get continueWithMobile;

  /// No description provided for @enterMobile.
  ///
  /// In en, this message translates to:
  /// **'Enter your mobile number'**
  String get enterMobile;

  /// No description provided for @searchCountry.
  ///
  /// In en, this message translates to:
  /// **'Search country'**
  String get searchCountry;

  /// No description provided for @enterMessageCodeHelper.
  ///
  /// In en, this message translates to:
  /// **'The code was sent to <mobile>{mobile}</mobile>. If you did not receive the code within 2 minutes, try again.'**
  String enterMessageCodeHelper(String mobile);

  /// No description provided for @enterEmailHelper.
  ///
  /// In en, this message translates to:
  /// **'A verification code will be sent to verify your email address. Make sure to check your inbox.'**
  String get enterEmailHelper;

  /// No description provided for @enterMobileHelper.
  ///
  /// In en, this message translates to:
  /// **'A verification code will be sent to verify your mobile number. Make sure to have access to messages.'**
  String get enterMobileHelper;

  /// No description provided for @continueAction.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueAction;
}

class _FluoLocalizationsDelegate
    extends LocalizationsDelegate<FluoLocalizations> {
  const _FluoLocalizationsDelegate();

  @override
  Future<FluoLocalizations> load(Locale locale) {
    return SynchronousFuture<FluoLocalizations>(
        lookupFluoLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'ar',
        'de',
        'en',
        'es',
        'fa',
        'fr',
        'hi',
        'it',
        'ja',
        'ko',
        'nl',
        'pl',
        'pt',
        'ru',
        'sv',
        'tr',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_FluoLocalizationsDelegate old) => false;
}

FluoLocalizations lookupFluoLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'BR':
            return FluoLocalizationsPtBr();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return FluoLocalizationsAr();
    case 'de':
      return FluoLocalizationsDe();
    case 'en':
      return FluoLocalizationsEn();
    case 'es':
      return FluoLocalizationsEs();
    case 'fa':
      return FluoLocalizationsFa();
    case 'fr':
      return FluoLocalizationsFr();
    case 'hi':
      return FluoLocalizationsHi();
    case 'it':
      return FluoLocalizationsIt();
    case 'ja':
      return FluoLocalizationsJa();
    case 'ko':
      return FluoLocalizationsKo();
    case 'nl':
      return FluoLocalizationsNl();
    case 'pl':
      return FluoLocalizationsPl();
    case 'pt':
      return FluoLocalizationsPt();
    case 'ru':
      return FluoLocalizationsRu();
    case 'sv':
      return FluoLocalizationsSv();
    case 'tr':
      return FluoLocalizationsTr();
    case 'zh':
      return FluoLocalizationsZh();
  }

  throw FlutterError(
      'FluoLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
