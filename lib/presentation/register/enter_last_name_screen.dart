import 'package:fluo/api/api_client.dart';
import 'package:fluo/api/models/api_error.dart';
import 'package:fluo/fluo_theme.dart';
import 'package:fluo/l10n/fluo_localizations.dart';
import 'package:fluo/l10n/localized.dart';
import 'package:fluo/managers/session_manager.dart';
import 'package:fluo/widgets/clear_suffix_button.dart';
import 'package:fluo/widgets/single_input_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnterLastNameScreen extends StatefulWidget {
  const EnterLastNameScreen({
    super.key,
    required this.onBackButtonPressed,
    required this.onLastNameSubmitted,
  });

  final VoidCallback? onBackButtonPressed;
  final VoidCallback onLastNameSubmitted;

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

    final session = context.read<SessionManager>().session;
    if (session != null) {
      final lastName = session.user.lastName;
      if (lastName != null) {
        _lastNameController.text = lastName;
      }
    }

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
    final fluoTheme = context.read<FluoTheme>();
    return SingleInputScreen(
      inputTitle: FluoLocalizations.of(context)!.enterLastName,
      inputWidget: Theme(
        data: Theme.of(context).copyWith(
          inputDecorationTheme: fluoTheme.inputDecorationTheme,
        ),
        child: TextField(
          controller: _lastNameController,
          style: fluoTheme.inputTextStyle,
          textAlignVertical: fluoTheme.inputTextAlignVertical,
          decoration: InputDecoration(
            hintText: FluoLocalizations.of(context)!.enterLastNamePlaceholder,
            suffixIcon: ClearSuffixButton(controller: _lastNameController),
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
      final apiClient = context.read<ApiClient>();
      final sessionManager = context.read<SessionManager>();
      final session = await sessionManager.getSession(apiClient: apiClient);
      final lastName = _lastNameController.text;
      await apiClient.updateUser(
        accessToken: session!.accessToken,
        lastName: lastName,
      );
      await sessionManager.setSession(session.copyWith(
        user: session.user.copyWith(
          lastName: lastName,
        ),
      ));
      widget.onLastNameSubmitted();
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
