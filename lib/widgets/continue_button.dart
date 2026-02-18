import 'package:fluo/fluo_sign_in_style.dart';
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
    final style = context.read<FluoSignInStyle>();
    return FilledButton(
      style: style.continueButtonStyle,
      onPressed: enabled ? _onPressedIfNotLoading : null,
      child: loading
          ? SizedBox(
              width: style.continueButtonProgressIndicatorSize?.width ?? 17,
              height: style.continueButtonProgressIndicatorSize?.height ?? 17,
              child: CircularProgressIndicator(
                color: style.continueButtonProgressIndicatorColor ?? Colors.black,
                strokeWidth: style.continueButtonProgressIndicatorStrokeWidth,
              ),
            )
          : Text(FluoLocalizations.of(context)!.continueAction),
    );
  }

  void _onPressedIfNotLoading() {
    if (!loading) {
      onPressed();
    }
  }
}
