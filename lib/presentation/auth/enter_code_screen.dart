import 'package:fluo/api/api_client.dart';
import 'package:fluo/api/models/api_error.dart';
import 'package:fluo/api/models/partial_session.dart';
import 'package:fluo/api/models/session.dart';
import 'package:fluo/fluo_theme.dart';
import 'package:fluo/l10n/fluo_localizations.dart';
import 'package:fluo/l10n/localized.dart';
import 'package:fluo/widgets/single_input_screen.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:styled_text/styled_text.dart';

class EnterCodeScreen extends StatefulWidget {
  const EnterCodeScreen({
    super.key,
    required this.partialSession,
    required this.onBackButtonPressed,
    required this.onCodeVerified,
  });

  final PartialSession partialSession;
  final VoidCallback onBackButtonPressed;
  final Function(Session session) onCodeVerified;

  @override
  State<EnterCodeScreen> createState() => _EnterEmailScreenState();
}

class _EnterEmailScreenState extends State<EnterCodeScreen> {
  final TextEditingController _codeController = TextEditingController();
  String? _errorText;
  bool _loading = false;
  bool _isCodeComplete = false;

  @override
  void initState() {
    super.initState();

    _codeController.addListener(() {
      if (_isCodeComplete && _errorText != null) {
        _codeController.setText('');
      }
      setState(() {
        _isCodeComplete = _codeController.text.length == 6;
        _errorText = null;
      });
    });
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fluoTheme = context.read<FluoTheme>();
    return SingleInputScreen(
      inputTitle: FluoLocalizations.of(context)!.enterCode,
      inputWidget: Pinput(
        length: 6,
        controller: _codeController,
        showCursor: true,
        autofocus: true,
        enabled: !_loading,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        defaultPinTheme: fluoTheme.codeInputThemeDefault,
        focusedPinTheme: fluoTheme.codeInputThemeFocused,
        submittedPinTheme: fluoTheme.codeInputThemeSubmitted,
        followingPinTheme: fluoTheme.codeInputThemeFollowing,
        disabledPinTheme: fluoTheme.codeInputThemeDisabled,
        errorPinTheme: fluoTheme.codeInputThemeError,
        onCompleted: (_) => _onNext(),
      ),
      onBackButtonPressed: widget.onBackButtonPressed,
      onNextButtonPressed: _onNext,
      nextButtonEnabled: _isCodeComplete,
      helperWidget: _helperWidget(),
      errorText: _errorText,
      loading: _loading,
    );
  }

  Widget _helperWidget() {
    String text = '';

    final email = widget.partialSession.email;
    if (email != null) {
      text = FluoLocalizations.of(context)!.enterEmailCodeHelper(email);
    }

    final mobileLocal = widget.partialSession.mobileLocal;
    if (mobileLocal != null) {
      text = FluoLocalizations.of(context)!.enterMessageCodeHelper(mobileLocal);
    }

    return StyledText(
      text: text,
      tags: {
        'email': StyledTextTag(
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        'mobile': StyledTextTag(
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      },
    );
  }

  void _onNext() async {
    try {
      setState(() => _loading = true);
      final apiClient = context.read<ApiClient>();
      final session = await apiClient.verifyPartialSession(
        partialSessionId: widget.partialSession.id,
        code: _codeController.text,
      );
      widget.onCodeVerified(session);
    } on ApiError catch (apiError) {
      setState(() {
        _errorText = Localized.error(context, apiError.message);
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
