import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:styled_text/styled_text.dart';

import '../api/api_client.dart';
import '../api/models/api_error.dart';
import '../api/models/app_config.dart';
import '../api/models/partial_session.dart';
import '../l10n/fluo_localizations.dart';
import '../l10n/fluo_localized_models.dart';
import '../widgets/clear_button_input_decoration.dart';
import '../widgets/single_input_screen.dart';
import '../widgets/webview.dart';

final RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

class EnterEmailScreen extends StatefulWidget {
  const EnterEmailScreen({
    super.key,
    required this.onBackButtonPressed,
    required this.onEmailSubmitted,
  });

  final Function() onBackButtonPressed;
  final Function(PartialSession partialSession) onEmailSubmitted;

  @override
  State<EnterEmailScreen> createState() => _EnterEmailScreenState();
}

class _EnterEmailScreenState extends State<EnterEmailScreen> {
  final TextEditingController _emailController = TextEditingController();
  String? _errorText;
  bool _loading = false;
  bool _isEmailValid = false;

  @override
  void initState() {
    super.initState();

    _emailController.addListener(() {
      setState(() {
        _errorText = null;
        _isEmailValid = emailRegex.hasMatch(_emailController.text);
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appConfig = Provider.of<AppConfig>(context, listen: false);
    return SingleInputScreen(
      inputTitle: FluoLocalizations.of(context)!.enterEmail,
      inputWidget: TextField(
        controller: _emailController,
        style: theme.textTheme.titleMedium,
        textAlignVertical: TextAlignVertical.center,
        decoration: ClearButtonInputDecoration(
          hintText: FluoLocalizations.of(context)!.enterEmailPlaceholder,
          controller: _emailController,
        ),
        onSubmitted: (_) => _onNext(),
        autofocus: true,
        autocorrect: false,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        autofillHints: const [
          AutofillHints.email,
        ],
      ),
      onBackButtonPressed: widget.onBackButtonPressed,
      onNextButtonPressed: _onNext,
      nextButtonEnabled: _isEmailValid,
      helperWidget: StyledText(
        text: FluoLocalizations.of(context)!.acceptTerms,
        style: Theme.of(context).textTheme.bodyMedium,
        tags: {
          'terms': StyledTextActionTag(
            (text, attrs) => showWebviewDialog(context, appConfig.termsUrl),
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
            ),
          ),
          'privacy': StyledTextActionTag(
            (text, attrs) => showWebviewDialog(context, appConfig.privacyUrl),
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
            ),
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
      final partialSession = await apiClient.createSession(
        email: _emailController.text,
      );
      widget.onEmailSubmitted(partialSession);
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
