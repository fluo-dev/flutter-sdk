import 'package:fluo/l10n/fluo_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FluoInfoScreenStyle {
  const FluoInfoScreenStyle({
    this.contentWidth = 320,
    this.backgroundColor = Colors.white,
    this.padding = const EdgeInsets.only(
      left: 20,
      right: 20,
      bottom: 40,
    ),
    this.verticalSpacing = 20,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.continueButtonStyle,
  });

  final double contentWidth;
  final Color backgroundColor;
  final EdgeInsets padding;
  final double verticalSpacing;
  final TextStyle? titleTextStyle;
  final TextStyle? subtitleTextStyle;
  final ButtonStyle? continueButtonStyle;
}

class FluoInfoScreen extends StatelessWidget {
  const FluoInfoScreen({
    super.key,
    required this.title,
    required this.onContinue,
    this.style = const FluoInfoScreenStyle(),
    this.icon,
    this.subtitle,
    this.continueButtonTitle,
  });

  final String title;
  final VoidCallback onContinue;
  final FluoInfoScreenStyle style;
  final Widget? icon;
  final String? subtitle;
  final String? continueButtonTitle;

  @override
  Widget build(BuildContext context) {
    final l10n = FluoLocalizations.of(context)!;
    return Container(
      color: style.backgroundColor,
      padding: style.padding,
      child: Center(
        child: SizedBox(
          width: style.contentWidth,
          child: Column(
            spacing: style.verticalSpacing,
            children: [
              const Spacer(),
              if (icon != null) icon!,
              Text(
                title,
                textAlign: TextAlign.center,
                style: style.titleTextStyle,
              ),
              if (subtitle != null)
                Text(
                  subtitle!,
                  textAlign: TextAlign.center,
                  style: style.subtitleTextStyle,
                ),
              const Spacer(),
              FilledButton(
                style: style.continueButtonStyle,
                onPressed: () {
                  HapticFeedback.selectionClick();
                  onContinue();
                },
                child: Text(continueButtonTitle ?? l10n.continueAction),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
