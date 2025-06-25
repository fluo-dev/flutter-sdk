import 'package:fluo/fluo_theme.dart';
import 'package:fluo/l10n/fluo_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
    required this.onPressed,
    this.loading = false,
    this.enabled = true,
  });

  final VoidCallback onPressed;
  final bool loading;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final fluoTheme = context.read<FluoTheme>();
    return FilledButton(
      style: fluoTheme.nextButtonStyle,
      onPressed: enabled ? _onPressedIfNotLoading : null,
      child: loading
          ? SizedBox(
              width: fluoTheme.nextButtonProgressIndicatorSize.width,
              height: fluoTheme.nextButtonProgressIndicatorSize.height,
              child: CircularProgressIndicator(
                color: fluoTheme.nextButtonProgressIndicatorColor,
                strokeWidth: fluoTheme.nextButtonProgressIndicatorStrokeWidth,
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
