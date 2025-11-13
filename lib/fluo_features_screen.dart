import 'package:fluo/l10n/fluo_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FluoFeaturesScreenStyle {
  const FluoFeaturesScreenStyle({
    this.contentWidth = 320,
    this.backgroundColor = Colors.white,
    this.padding = const EdgeInsets.only(
      left: 20,
      right: 20,
    ),
    this.titleTextStyle,
    this.featureTextStyle,
    this.checkmarkSize = 30,
    this.checkmarkColor = Colors.black,
    this.checkmarkBackgroundColor = const Color(0xfff0f0f0),
    this.continueButtonStyle,
  });

  final double contentWidth;
  final Color backgroundColor;
  final EdgeInsets padding;
  final TextStyle? titleTextStyle;
  final TextStyle? featureTextStyle;
  final double checkmarkSize;
  final Color checkmarkColor;
  final Color checkmarkBackgroundColor;
  final ButtonStyle? continueButtonStyle;
}

class FluoFeaturesScreen extends StatelessWidget {
  const FluoFeaturesScreen({
    super.key,
    required this.title,
    required this.features,
    required this.onContinue,
    this.style = const FluoFeaturesScreenStyle(),
  });

  final String title;
  final List<String> features;
  final VoidCallback onContinue;
  final FluoFeaturesScreenStyle style;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: style.backgroundColor,
      padding: style.padding,
      child: Center(
        child: SizedBox(
          width: style.contentWidth,
          child: Column(
            spacing: 15,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Text(
                title,
                style: style.titleTextStyle,
              ),
              const SizedBox(height: 10),
              for (var feature in features)
                Row(
                  spacing: 15,
                  children: [
                    Container(
                      width: style.checkmarkSize,
                      height: style.checkmarkSize,
                      padding: EdgeInsets.all(style.checkmarkSize * 0.1),
                      decoration: BoxDecoration(
                        color: style.checkmarkBackgroundColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check_rounded,
                        color: style.checkmarkColor,
                        size: style.checkmarkSize * 0.8,
                      ),
                    ),
                    Text(
                      feature,
                      style: style.featureTextStyle,
                    ),
                  ],
                ),
              const Spacer(),
              SafeArea(
                top: false,
                left: false,
                right: false,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: FilledButton(
                    style: style.continueButtonStyle,
                    onPressed: () {
                      HapticFeedback.selectionClick();
                      onContinue();
                    },
                    child: Text(FluoLocalizations.of(context)!.continueAction),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
