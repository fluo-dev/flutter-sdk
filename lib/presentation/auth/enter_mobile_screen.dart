import 'package:fluo/api/api_client.dart';
import 'package:fluo/api/models/api_error.dart';
import 'package:fluo/api/models/partial_session.dart';
import 'package:fluo/l10n/fluo_localizations.dart';
import 'package:fluo/l10n/fluo_localized_models.dart';
import 'package:fluo/theme.dart';
import 'package:fluo/widgets/clear_suffix_button.dart';
import 'package:fluo/widgets/single_input_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnterMobileScreen extends StatefulWidget {
  const EnterMobileScreen({
    super.key,
    required this.onBackButtonPressed,
    required this.onMobileSubmitted,
  });

  final Function() onBackButtonPressed;
  final Function(PartialSession partialSession) onMobileSubmitted;

  @override
  State<EnterMobileScreen> createState() => _EnterMobileScreenState();
}

class _EnterMobileScreenState extends State<EnterMobileScreen> {
  final TextEditingController _mobileController = TextEditingController();
  String? _errorText;
  bool _loading = false;
  final bool _isMobileValid = false;

  @override
  void initState() {
    super.initState();

    _mobileController.addListener(() {
      setState(() {
        _errorText = null;
        // _isMobileValid = do it
      });
    });
  }

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.read<FluoTheme>();
    return SingleInputScreen(
      inputTitle: FluoLocalizations.of(context)!.enterMobile,
      inputWidget: TextField(
        controller: _mobileController,
        style: theme.inputTextStyle,
        textAlignVertical: theme.inputTextAlignVertical,
        decoration: theme.inputDecoration.copyWith(
          // hintText: do it
          suffixIcon: ClearSuffixButton(controller: _mobileController),
        ),
        onSubmitted: (_) => _onNext(),
        autofocus: true,
        autocorrect: false,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.phone,
        autofillHints: const [
          AutofillHints.telephoneNumber,
        ],
      ),
      onBackButtonPressed: widget.onBackButtonPressed,
      onNextButtonPressed: _onNext,
      nextButtonEnabled: _isMobileValid,
      errorText: _errorText,
      loading: _loading,
    );
  }

  void _onNext() async {
    try {
      setState(() => _loading = true);
      final apiClient = context.read<ApiClient>();
      final partialSession = await apiClient.createPartialSession(
        mobileNumberE164: '',
        mobileNumberIso2: '',
      );
      widget.onMobileSubmitted(partialSession);
    } on ApiError catch (apiError) {
      setState(() {
        _errorText = FluoLocalizedModels.error(context, apiError.message);
      });
    } catch (error) {
      setState(() {
        _errorText = FluoLocalizations.of(context)!.errorUnknown;
      });
    } finally {
      setState(() => _loading = false);
    }
  }
}
