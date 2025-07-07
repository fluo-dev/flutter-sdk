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

class EnterFirstNameScreen extends StatefulWidget {
  const EnterFirstNameScreen({
    super.key,
    required this.onBackButtonPressed,
    required this.onFirstNameSubmitted,
  });

  final VoidCallback? onBackButtonPressed;
  final VoidCallback onFirstNameSubmitted;

  @override
  State<EnterFirstNameScreen> createState() => _EnterFirstNameScreenState();
}

class _EnterFirstNameScreenState extends State<EnterFirstNameScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  String? _errorText;
  bool _loading = false;
  bool _isFirstNameValid = false;

  @override
  void initState() {
    super.initState();

    final session = context.read<SessionManager>().session;
    if (session != null) {
      final firstName = session.user.firstName;
      if (firstName != null) {
        _firstNameController.text = firstName;
      }
    }

    _firstNameController.addListener(() {
      setState(() {
        _errorText = null;
        _isFirstNameValid = _firstNameController.text.length >= 2;
      });
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fluoTheme = context.read<FluoTheme>();
    return SingleInputScreen(
      inputTitle: FluoLocalizations.of(context)!.enterFirstName,
      inputWidget: Theme(
        data: Theme.of(context).copyWith(
          inputDecorationTheme: fluoTheme.inputDecorationTheme,
        ),
        child: TextField(
          controller: _firstNameController,
          style: fluoTheme.inputTextStyle,
          textAlignVertical: fluoTheme.inputTextAlignVertical,
          decoration: InputDecoration(
            hintText: FluoLocalizations.of(context)!.enterFirstNamePlaceholder,
            suffixIcon: ClearSuffixButton(controller: _firstNameController),
          ),
          onSubmitted: (_) => _onNext(),
          autofocus: true,
          autocorrect: false,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          autofillHints: const [
            AutofillHints.givenName,
          ],
        ),
      ),
      onBackButtonPressed: widget.onBackButtonPressed,
      onNextButtonPressed: _onNext,
      nextButtonEnabled: _isFirstNameValid,
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
      final firstName = _firstNameController.text;
      await apiClient.updateUser(
        accessToken: session!.accessToken,
        firstName: firstName,
      );
      await sessionManager.setSession(session.copyWith(
        user: session.user.copyWith(
          firstName: firstName,
        ),
      ));
      widget.onFirstNameSubmitted();
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
