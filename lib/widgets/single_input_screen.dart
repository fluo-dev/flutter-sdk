import 'package:flutter/material.dart';

import 'next_button.dart';
import 'round_button.dart';

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
  final Function()? onBackButtonPressed;
  final Function()? onNextButtonPressed;
  final bool nextButtonEnabled;
  final Widget? helperWidget;
  final String? errorText;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RoundButton(onPressed: onBackButtonPressed),
              const SizedBox(height: 30.0),
              Text(
                inputTitle,
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 20.0),
              inputWidget,
              const SizedBox(height: 10.0),
              if (errorText != null || helperWidget != null) ...{
                const SizedBox(height: 10.0),
                if (errorText != null)
                  Text(
                    errorText!,
                    style: theme.textTheme.bodyMedium!
                        .apply(color: theme.colorScheme.error),
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
