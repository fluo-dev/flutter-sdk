import 'package:fluo/fluo_theme.dart';
import 'package:fluo/widgets/continue_button.dart';
import 'package:fluo/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleInputScreen extends StatelessWidget {
  const SingleInputScreen({
    super.key,
    required this.inputTitle,
    required this.inputWidget,
    this.onBack,
    this.onContinue,
    this.continueButtonEnabled = true,
    this.helperWidget,
    this.errorText,
    this.loading = false,
  });

  final String inputTitle;
  final Widget inputWidget;
  final VoidCallback? onBack;
  final VoidCallback? onContinue;
  final bool continueButtonEnabled;
  final Widget? helperWidget;
  final String? errorText;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final fluoTheme = context.read<FluoTheme>();
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          onBack?.call();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: fluoTheme.screenPadding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RoundButton(
                  onPressed: onBack,
                  color: fluoTheme.primaryColor,
                ),
                const SizedBox(height: 30.0),
                Text(
                  inputTitle,
                  style: fluoTheme.titleStyle,
                ),
                const SizedBox(height: 20.0),
                inputWidget,
                const SizedBox(height: 10.0),
                if (errorText != null || helperWidget != null) ...{
                  const SizedBox(height: 10.0),
                  if (errorText != null)
                    Text(
                      errorText!,
                      style: fluoTheme.inputErrorStyle,
                    ),
                  if (errorText == null && helperWidget != null) ...{
                    helperWidget!
                  },
                },
                if (errorText != null || helperWidget != null) ...{
                  const SizedBox(height: 20.0),
                },
                const Spacer(),
                if (onContinue != null) ...{
                  ContinueButton(
                    onPressed: onContinue!,
                    loading: loading,
                    enabled: continueButtonEnabled,
                  ),
                },
              ],
            ),
          ),
        ),
      ),
    );
  }
}
