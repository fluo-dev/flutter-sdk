import 'package:diacritic/diacritic.dart';
import 'package:fluo/l10n/localized.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart' as libphone;

typedef Country = libphone.CountryWithPhoneCode;
typedef PhoneNumberFormatter = libphone.LibPhonenumberTextFormatter;
typedef FormatPhoneResult = libphone.FormatPhoneResult;

class CountryManager {
  CountryManager._(this.countriesMap);

  final Map<String, Country> countriesMap;

  static CountryManager? _instance;

  static void init() async {
    if (_instance != null) {
      return;
    }

    await libphone.init();

    final countriesMap = await libphone.getAllSupportedRegions();
    countriesMap.remove('001'); // remove the weird "world" region
    _instance = CountryManager._(countriesMap);
  }

  static List<Country> getSortedCountries(BuildContext context) {
    return _instance!.countriesMap.values.toList()
      ..sort((a, b) {
        final countryA = getLocalizedName(context, a) ?? '';
        final countryB = getLocalizedName(context, b) ?? '';
        return removeDiacritics(countryA).compareTo(removeDiacritics(countryB));
      });
  }

  static Country? getCountry(String countryCode) {
    return _instance!.countriesMap[countryCode];
  }

  static String? getLocalizedName(BuildContext context, Country country) {
    return Localized.countryName(context, country.countryCode);
  }

  static PhoneNumberFormatter getMobileNationalFormatter(Country country) {
    return PhoneNumberFormatter(
      country: country,
      phoneNumberType: libphone.PhoneNumberType.mobile,
      phoneNumberFormat: libphone.PhoneNumberFormat.national,
    );
  }

  static Future<FormatPhoneResult?> formatPhoneNumber(
      String phoneNumber, Country country) {
    return libphone.getFormattedParseResult(phoneNumber, country);
  }
}
