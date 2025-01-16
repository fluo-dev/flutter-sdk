import 'package:fluo/l10n/fluo_localizations.dart';
import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
    required this.onPressed,
    this.leftWidget,
    this.rightWidget,
    this.loading = false,
    this.enabled = true,
  });

  final Function() onPressed;
  final Widget? leftWidget;
  final Widget? rightWidget;
  final bool loading;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget? loadingIndicator;
    if (loading) {
      loadingIndicator = SizedBox(
        width: 16.0,
        height: 16.0,
        child: CircularProgressIndicator(
          color: theme.colorScheme.inversePrimary,
          strokeWidth: 2.0,
        ),
      );
    }

    return FilledButton(
      onPressed: enabled ? _onPressedIfNotLoading : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leftWidget != null) leftWidget!,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(FluoLocalizations.of(context)!.next),
          ),
          if (loadingIndicator != null) ...{
            loadingIndicator
          } else if (rightWidget != null) ...{
            rightWidget!
          },
        ],
      ),
    );
  }

  _onPressedIfNotLoading() {
    if (!loading) {
      onPressed();
    }
  }
}
