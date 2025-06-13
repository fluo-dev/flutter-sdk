import 'package:country_flags/country_flags.dart';
import 'package:device_region/device_region.dart';
import 'package:fluo/managers/country_manager.dart';
import 'package:fluo/theme.dart';
import 'package:fluo/widgets/clear_suffix_button.dart';
import 'package:fluo/widgets/countries_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MobileInput extends StatefulWidget {
  const MobileInput({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onComplete,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String? mobileE164, String? mobileIso2) onComplete;

  @override
  State<MobileInput> createState() => _MobileInputState();
}

class _MobileInputState extends State<MobileInput> {
  late List<Country> _allSortedCountries;
  Country? _selectedCountry;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onMobileChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _allSortedCountries = CountryManager.getSortedCountries(context);
      _initDefaultCountry();
      _initialized = true;
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onMobileChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.read<FluoTheme>();

    double flagPaddingLeft = 15.0;
    final padding = theme.inputDecoration.contentPadding;
    if (padding is EdgeInsets) {
      flagPaddingLeft = padding.left;
    } else if (padding is EdgeInsetsDirectional) {
      flagPaddingLeft = padding.start;
    }

    return TextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      style: theme.inputTextStyle,
      textAlignVertical: theme.inputTextAlignVertical,
      decoration: theme.inputDecoration.copyWith(
        hintText: _selectedCountry?.exampleNumberMobileNational,
        prefixIcon: GestureDetector(
          onTap: () => _showCountrySelector(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: flagPaddingLeft,
                  right: 3.0,
                ),
                child: _getCountryFlag(),
              ),
              Icon(
                Icons.arrow_drop_down,
                color: theme.primaryColor,
              ),
            ],
          ),
        ),
        suffixIcon: ClearSuffixButton(controller: widget.controller),
      ),
      inputFormatters: [
        if (_selectedCountry != null)
          CountryManager.getMobileNationalFormatter(_selectedCountry!)
      ],
      autocorrect: false,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.phone,
      autofillHints: const [
        AutofillHints.telephoneNumber,
      ],
    );
  }

  Future<void> _initDefaultCountry() async {
    final deviceCountryCode = await _getDeviceCountryCode();
    setState(() {
      _selectedCountry = CountryManager.getCountry(deviceCountryCode);
    });
  }

  static Future<String> _getDeviceCountryCode() async {
    if (!kIsWeb) {
      final countryCode = await DeviceRegion.getSIMCountryCode();
      if (countryCode != null) {
        return countryCode;
      }
    }
    final locale = WidgetsBinding.instance.platformDispatcher.locale;
    return locale.countryCode ?? locale.languageCode;
  }

  Widget _getCountryFlag() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: Container(
        width: 24.0,
        height: 18.0,
        decoration: BoxDecoration(
          color: Colors.brown.shade100,
          borderRadius: BorderRadius.circular(3),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 1.0,
              offset: Offset(0.0, 1.0),
            ),
          ],
        ),
        child: _selectedCountry == null
            ? const SizedBox.shrink()
            : CountryFlag.fromCountryCode(
                _selectedCountry!.countryCode,
                shape: const RoundedRectangle(3.0),
                key: ValueKey(_selectedCountry!.countryCode),
              ),
      ),
    );
  }

  void _onMobileChanged() async {
    String? mobileE164;
    String? mobileIso2;

    final selectedCountry = _selectedCountry;
    if (selectedCountry != null) {
      mobileIso2 = selectedCountry.countryCode;

      final result = await CountryManager.formatPhoneNumber(
        widget.controller.text,
        selectedCountry,
      );

      if (result != null) {
        mobileE164 = result.e164;
      }
    }

    widget.onComplete(mobileE164, mobileIso2);
  }

  void _showCountrySelector() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      showDragHandle: true,
      context: context,
      builder: (BuildContext context) {
        return CountriesList(
          countries: _allSortedCountries,
          onCountrySelected: (country) {
            setState(() {
              _selectedCountry = country;
            });
          },
        );
      },
    );
  }
}
