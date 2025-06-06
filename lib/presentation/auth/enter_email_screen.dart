import 'dart:async';

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
  final FocusNode _focusNode = FocusNode();
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

    Timer(const Duration(milliseconds: 600), () {
      if (mounted) {
        _focusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.read<FluoTheme>();
    return SingleInputScreen(
      inputTitle: FluoLocalizations.of(context)!.enterEmail,
      inputWidget: TextField(
        controller: _emailController,
        focusNode: _focusNode,
        style: theme.inputTextStyle,
        textAlignVertical: theme.inputTextAlignVertical,
        decoration: theme.inputDecoration.copyWith(
          hintText: FluoLocalizations.of(context)!.enterEmailPlaceholder,
          suffixIcon: ClearSuffixButton(controller: _emailController),
        ),
        onSubmitted: (_) => _onNext(),
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
      errorText: _errorText,
      loading: _loading,
    );
  }

  void _onNext() async {
    try {
      setState(() => _loading = true);
      final apiClient = context.read<ApiClient>();
      final partialSession = await apiClient.createPartialSession(
        email: _emailController.text,
      );
      widget.onEmailSubmitted(partialSession);
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
