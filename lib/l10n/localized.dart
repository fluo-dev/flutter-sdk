import 'package:fluo/l10n/localized_countries_ar.dart';
import 'package:fluo/l10n/localized_countries_de.dart';
import 'package:fluo/l10n/localized_countries_en.dart';
import 'package:fluo/l10n/localized_countries_es.dart';
import 'package:fluo/l10n/localized_countries_fa.dart';
import 'package:fluo/l10n/localized_countries_fr.dart';
import 'package:fluo/l10n/localized_countries_hi.dart';
import 'package:fluo/l10n/localized_countries_it.dart';
import 'package:fluo/l10n/localized_countries_ja.dart';
import 'package:fluo/l10n/localized_countries_ko.dart';
import 'package:fluo/l10n/localized_countries_nl.dart';
import 'package:fluo/l10n/localized_countries_pl.dart';
import 'package:fluo/l10n/localized_countries_pt.dart';
import 'package:fluo/l10n/localized_countries_pt_br.dart';
import 'package:fluo/l10n/localized_countries_ru.dart';
import 'package:fluo/l10n/localized_countries_sv.dart';
import 'package:fluo/l10n/localized_countries_tr.dart';
import 'package:fluo/l10n/localized_countries_zh.dart';
import 'package:flutter/material.dart';

import 'fluo_localizations.dart';

class Localized {
  static String error(BuildContext context, String messageId) {
    final fluoLocalizations = FluoLocalizations.of(context)!;
    switch (messageId) {
      case 'unauthorized':
        return fluoLocalizations.errorUnauthorized;
      case 'parameter_missing':
        return fluoLocalizations.errorParameterMissing;
      case 'parameter_invalid':
        return fluoLocalizations.errorParameterInvalid;
      case 'not_found':
        return fluoLocalizations.errorNotFound;
      case 'internal':
        return fluoLocalizations.errorInternal;
      case 'session_revoked':
        return fluoLocalizations.errorSessionRevoked;
      case 'code_expired':
        return fluoLocalizations.errorCodeExpired;
      case 'code_invalid':
        return fluoLocalizations.errorCodeInvalid;
    }
    return fluoLocalizations.errorUnknown;
  }

  static String? countryName(BuildContext context, String countryCode) {
    final locale = Localizations.localeOf(context);
    switch (locale.languageCode) {
      case 'ar':
        return localizedCountriesAr[countryCode];
      case 'de':
        return localizedCountriesDe[countryCode];
      case 'en':
        return localizedCountriesEn[countryCode];
      case 'es':
        return localizedCountriesEs[countryCode];
      case 'fa':
        return localizedCountriesFa[countryCode];
      case 'fr':
        return localizedCountriesFr[countryCode];
      case 'hi':
        return localizedCountriesHi[countryCode];
      case 'it':
        return localizedCountriesIt[countryCode];
      case 'ja':
        return localizedCountriesJa[countryCode];
      case 'ko':
        return localizedCountriesKo[countryCode];
      case 'nl':
        return localizedCountriesNl[countryCode];
      case 'pl':
        return localizedCountriesPl[countryCode];
      case 'pt':
        if (locale.countryCode == 'BR') {
          return localizedCountriesPtBR[countryCode];
        }
        return localizedCountriesPt[countryCode];
      case 'ru':
        return localizedCountriesRu[countryCode];
      case 'sv':
        return localizedCountriesSv[countryCode];
      case 'tr':
        return localizedCountriesTr[countryCode];
      case 'zh':
        return localizedCountriesZh[countryCode];
    }
    return null;
  }
}
