import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:styled_text/styled_text.dart';

import '../api/api_client.dart';
import '../api/models/api_error.dart';
import '../api/models/partial_session.dart';
import '../api/models/session.dart';
import '../l10n/fluo_localizations.dart';
import '../l10n/fluo_localized_models.dart';
import '../theme.dart';
import '../widgets/single_input_screen.dart';

class EnterCodeScreen extends StatefulWidget {
  const EnterCodeScreen({
    super.key,
    required this.partialSession,
    required this.onBackButtonPressed,
    required this.onCodeVerified,
  });

  final PartialSession partialSession;
  final Function() onBackButtonPressed;
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
      setState(() {
        _errorText = null;
        _isCodeComplete = _codeController.text.length == 6;
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
    return SingleInputScreen(
      inputTitle: FluoLocalizations.of(context)!.enterCode,
      inputWidget: Pinput(
        length: 6,
        controller: _codeController,
        showCursor: false,
        autofocus: true,
        enabled: !_loading,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        defaultPinTheme: FluoTheme.defaultPinTheme(context),
        focusedPinTheme: FluoTheme.focusedPinTheme(context),
        followingPinTheme: FluoTheme.followingPinTheme(context),
        // onTap: _clearIfHasError,
        onCompleted: (_) => _onNext(),
      ),
      onBackButtonPressed: widget.onBackButtonPressed,
      onNextButtonPressed: _onNext,
      nextButtonEnabled: _isCodeComplete,
      helperWidget: StyledText(
        text: FluoLocalizations.of(context)!
            .enterCodeHelper(widget.partialSession.email!),
        style: Theme.of(context).textTheme.bodyMedium,
        tags: {
          'email': StyledTextTag(
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        },
      ),
      errorText: _errorText,
      loading: _loading,
    );
  }

  void _onNext() async {
    try {
      setState(() => _loading = true);
      final apiClient = Provider.of<ApiClient>(
        context,
        listen: false,
      );
      final session = await apiClient.verifySession(
        partialSessionId: widget.partialSession.id,
        code: _codeController.text,
      );
      widget.onCodeVerified(session);
    } on ApiError catch (apiError) {
      setState(() => _errorText =
          FluoLocalizedModels.localizedError(context, apiError.message));
    } catch (error) {
      setState(() => _errorText = FluoLocalizations.of(context)!.errorUnknown);
    } finally {
      setState(() => _loading = false);
    }
  }
}
