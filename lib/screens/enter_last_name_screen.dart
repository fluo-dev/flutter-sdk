import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/api_client.dart';
import '../api/models/api_error.dart';
import '../l10n/fluo_localizations.dart';
import '../l10n/fluo_localized_models.dart';
import '../managers/session_manager.dart';
import '../widgets/clear_button_input_decoration.dart';
import '../widgets/single_input_screen.dart';

class EnterLastNameScreen extends StatefulWidget {
  const EnterLastNameScreen({
    super.key,
    required this.onBackButtonPressed,
    required this.onLastNameSubmitted,
  });

  final Function() onBackButtonPressed;
  final Function() onLastNameSubmitted;

  @override
  State<EnterLastNameScreen> createState() => _EnterLastNameScreenState();
}

class _EnterLastNameScreenState extends State<EnterLastNameScreen> {
  final TextEditingController _lastNameController = TextEditingController();
  String? _errorText;
  bool _loading = false;
  bool _isLastNameValid = false;

  @override
  void initState() {
    super.initState();

    _lastNameController.addListener(() {
      setState(() {
        _errorText = null;
        _isLastNameValid = _lastNameController.text.length >= 2;
      });
    });
  }

  @override
  void dispose() {
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleInputScreen(
      inputTitle: FluoLocalizations.of(context)!.enterLastName,
      inputWidget: TextField(
        controller: _lastNameController,
        style: theme.textTheme.titleMedium,
        textAlignVertical: TextAlignVertical.center,
        decoration: ClearButtonInputDecoration(
          hintText: FluoLocalizations.of(context)!.enterLastNamePlaceholder,
          controller: _lastNameController,
        ),
        onSubmitted: (_) => _onNext(),
        autofocus: true,
        autocorrect: false,
        textCapitalization: TextCapitalization.words,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        autofillHints: const [
          AutofillHints.familyName,
        ],
      ),
      onBackButtonPressed: widget.onBackButtonPressed,
      onNextButtonPressed: _onNext,
      nextButtonEnabled: _isLastNameValid,
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
      final sessionManager = Provider.of<SessionManager>(
        context,
        listen: false,
      );
      final session = await sessionManager.getSession(apiClient: apiClient);
      await apiClient.updateUser(
        accessToken: session!.accessToken,
        lastName: _lastNameController.text,
      );
      widget.onLastNameSubmitted();
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
