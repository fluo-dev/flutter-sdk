import 'dart:async';

import 'package:country_flags/country_flags.dart';
import 'package:fluo/l10n/fluo_localizations.dart';
import 'package:fluo/l10n/localized.dart';
import 'package:fluo/theme.dart';
import 'package:fluo/widgets/clear_suffix_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart' as libphone;
import 'package:provider/provider.dart';

class CountryItem extends StatelessWidget {
  const CountryItem({
    super.key,
    required this.country,
    required this.onTap,
  });

  final libphone.CountryWithPhoneCode country;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.read<FluoTheme>();
    final name = Localized.countryName(context, country.countryCode);
    return InkWell(
      onTap: onTap,
      highlightColor: theme.countryItemHighlightColor,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      child: Padding(
        padding: theme.countryItemPadding,
        child: Row(
          children: [
            CountryFlag.fromCountryCode(
              country.countryCode,
              height: 18.0,
              width: 24.0,
              shape: const RoundedRectangle(3.0),
            ),
            const SizedBox(width: 20.0),
            Expanded(
              child: Text(
                name ?? country.countryCode,
                style: theme.countryTextStyle,
              ),
            ),
            Text(
              '+${country.phoneCode}',
              style: theme.countryTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}

class CountriesList extends StatefulWidget {
  const CountriesList({
    super.key,
    required this.countries,
    required this.onCountrySelected,
  });

  final List<libphone.CountryWithPhoneCode> countries;
  final void Function(libphone.CountryWithPhoneCode) onCountrySelected;

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  final _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<libphone.CountryWithPhoneCode>? _filteredCountries;

  @override
  void initState() {
    super.initState();
    _filteredCountries = widget.countries;

    Timer(const Duration(milliseconds: 600), () {
      if (mounted) {
        _focusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.read<FluoTheme>();
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            left: theme.screenPadding.left,
            right: theme.screenPadding.right,
            bottom: 30.0,
          ),
          child: TextField(
            controller: _searchController,
            focusNode: _focusNode,
            style: theme.inputTextStyle,
            textAlignVertical: theme.inputTextAlignVertical,
            decoration: theme.inputDecoration.copyWith(
              hintText: FluoLocalizations.of(context)!.searchCountry,
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Icon(
                  Icons.search,
                  size: 22.0,
                ),
              ),
              suffixIcon: ClearSuffixButton(controller: _searchController),
            ),
            onChanged: _filterCountries,
            autocorrect: false,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            autofillHints: const [
              AutofillHints.countryName,
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredCountries!.length,
            itemBuilder: (BuildContext context, int index) {
              final country = _filteredCountries![index];
              return CountryItem(
                country: country,
                onTap: () {
                  widget.onCountrySelected(country);
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _filterCountries(String query) {
    if (query.isEmpty) {
      setState(() => _filteredCountries = widget.countries);
      return;
    }

    final lowercaseQuery = query.toLowerCase();
    final filteredCountries = widget.countries.where((country) {
      final name = Localized.countryName(context, country.countryCode) ?? '';
      return name.toLowerCase().contains(lowercaseQuery) ||
          country.phoneCode.toLowerCase().contains(lowercaseQuery);
    }).toList();

    setState(() => _filteredCountries = filteredCountries);
  }
}
