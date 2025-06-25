import 'package:fluo/theme.dart';
import 'package:fluo/widgets/next_button.dart';
import 'package:fluo/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleInputScreen extends StatelessWidget {
  const SingleInputScreen({
    super.key,
    required this.inputTitle,
    required this.inputWidget,
    this.onBackButtonPressed,
    this.onNextButtonPressed,
    this.nextButtonEnabled = true,
    this.helperWidget,
    this.errorText,
    this.loading = false,
  });

  final String inputTitle;
  final Widget inputWidget;
  final VoidCallback? onBackButtonPressed;
  final VoidCallback? onNextButtonPressed;
  final bool nextButtonEnabled;
  final Widget? helperWidget;
  final String? errorText;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final theme = context.read<FluoTheme>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: theme.screenPadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RoundButton(
                onPressed: onBackButtonPressed,
                color: theme.primaryColor,
              ),
              const SizedBox(height: 30.0),
              Text(
                inputTitle,
                style: theme.titleStyle,
              ),
              const SizedBox(height: 20.0),
              inputWidget,
              const SizedBox(height: 10.0),
              if (errorText != null || helperWidget != null) ...{
                const SizedBox(height: 10.0),
                if (errorText != null)
                  Text(
                    errorText!,
                    style: theme.inputErrorStyle,
                  ),
                if (errorText == null && helperWidget != null) ...{
                  helperWidget!
                },
              },
              if (errorText != null || helperWidget != null) ...{
                const SizedBox(height: 20.0),
              },
              const Spacer(),
              if (onNextButtonPressed != null) ...{
                NextButton(
                  onPressed: onNextButtonPressed!,
                  loading: loading,
                  enabled: nextButtonEnabled,
                ),
              },
            ],
          ),
        ),
      ),
    );
  }
}
