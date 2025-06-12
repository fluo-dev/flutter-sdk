import 'package:fluo/l10n/fluo_localizations.dart';
import 'package:fluo/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
    required this.onPressed,
    this.loading = false,
    this.enabled = true,
  });

  final Function() onPressed;
  final bool loading;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = context.read<FluoTheme>();
    return FilledButton(
      style: theme.nextButtonStyle,
      onPressed: enabled ? _onPressedIfNotLoading : null,
      child: loading
          ? SizedBox(
              width: theme.nextButtonProgressIndicatorSize.width,
              height: theme.nextButtonProgressIndicatorSize.height,
              child: CircularProgressIndicator(
                color: theme.nextButtonProgressIndicatorColor,
                strokeWidth: theme.nextButtonProgressIndicatorStrokeWidth,
              ),
            )
          : Text(FluoLocalizations.of(context)!.next),
    );
  }

  _onPressedIfNotLoading() {
    if (!loading) {
      onPressed();
    }
  }
}
