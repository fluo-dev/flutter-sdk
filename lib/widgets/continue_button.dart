import 'package:fluo/fluo_theme.dart';
import 'package:fluo/l10n/fluo_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({
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
      style: fluoTheme.continueButtonStyle,
      onPressed: enabled ? _onPressedIfNotLoading : null,
      child: loading
          ? SizedBox(
              width: fluoTheme.continueButtonProgressIndicatorSize.width,
              height: fluoTheme.continueButtonProgressIndicatorSize.height,
              child: CircularProgressIndicator(
                color: fluoTheme.continueButtonProgressIndicatorColor,
                strokeWidth:
                    fluoTheme.continueButtonProgressIndicatorStrokeWidth,
              ),
            )
          : Text(FluoLocalizations.of(context)!.continueAction),
    );
  }

  _onPressedIfNotLoading() {
    if (!loading) {
      onPressed();
    }
  }
}
