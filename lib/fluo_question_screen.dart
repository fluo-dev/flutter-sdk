import 'package:fluo/l10n/fluo_localizations.dart';
import 'package:fluo/widgets/ink_well_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FluoAnswerStyle {
  const FluoAnswerStyle({
    this.padding = const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 15,
    ),
    this.backgroundColor = const Color(0x09000000),
    this.backgroundHighlightColor = const Color(0x12000000),
    this.backgroundSelectedColor = const Color(0xFFFFFF8D),
    this.borderColor = Colors.transparent,
    this.borderHighlightColor = Colors.transparent,
    this.borderSelectedColor = Colors.black,
    this.iconContainerPadding = const EdgeInsets.all(6),
    this.iconContainerColor = Colors.white,
    this.titleTextStyle,
  });

  final EdgeInsets padding;
  final Color backgroundColor;
  final Color? backgroundHighlightColor;
  final Color backgroundSelectedColor;
  final Color borderColor;
  final Color? borderHighlightColor;
  final Color borderSelectedColor;
  final EdgeInsets iconContainerPadding;
  final Color iconContainerColor;
  final TextStyle? titleTextStyle;
}

class FluoAnswer {
  const FluoAnswer({
    required this.id,
    required this.title,
    required this.icon,
    this.style = const FluoAnswerStyle(),
  });

  final String id;
  final String title;
  final Widget icon;
  final FluoAnswerStyle style;
}

class FluoQuestionScreenStyle {
  const FluoQuestionScreenStyle({
    this.backgroundColor = Colors.white,
    this.padding = const EdgeInsets.only(
      left: 20,
      right: 20,
      bottom: 40,
    ),
    this.titleTextStyle,
    this.answersAxisAlignment = MainAxisAlignment.end,
    this.continueButtonStyle,
  });

  final Color backgroundColor;
  final EdgeInsets padding;
  final TextStyle? titleTextStyle;
  final MainAxisAlignment answersAxisAlignment;
  final ButtonStyle? continueButtonStyle;
}

class FluoQuestionScreen extends StatefulWidget {
  const FluoQuestionScreen({
    super.key,
    required this.title,
    required this.answers,
    required this.onContinue,
    this.style = const FluoQuestionScreenStyle(),
    this.singleChoice = true,
  });

  final String title;
  final List<FluoAnswer> answers;
  final Function(List<String> answerIds) onContinue;
  final FluoQuestionScreenStyle style;
  final bool singleChoice;

  @override
  State<FluoQuestionScreen> createState() => _FluoQuestionScreenState();
}

class _FluoQuestionScreenState extends State<FluoQuestionScreen> {
  final List<String> _selectedAnswerIds = [];

  @override
  Widget build(BuildContext context) {
    final style = widget.style;
    return Container(
      color: style.backgroundColor,
      padding: style.padding.copyWith(bottom: 0),
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: style.titleTextStyle,
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: widget.singleChoice ? 50 : 0,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: style.answersAxisAlignment,
                        spacing: 10,
                        children: [
                          for (var answer in widget.answers)
                            _buildAnswer(answer)
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (!widget.singleChoice)
            Padding(
              padding: EdgeInsets.only(bottom: style.padding.bottom),
              child: FilledButton(
                style: style.continueButtonStyle,
                onPressed: _selectedAnswerIds.isEmpty
                    ? null
                    : () {
                        HapticFeedback.selectionClick();
                        _onContinue();
                      },
                child: Text(FluoLocalizations.of(context)!.continueAction),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAnswer(FluoAnswer answer) {
    final style = answer.style;
    return InkWellColor(
      padding: style.padding,
      color: _isSelected(answer.id)
          ? style.backgroundSelectedColor
          : style.backgroundColor,
      highlightColor: style.backgroundHighlightColor,
      border: Border.all(
          width: 1.5,
          color: _isSelected(answer.id)
              ? style.borderSelectedColor
              : style.borderColor),
      highlightBorder: style.borderHighlightColor != null
          ? Border.all(
              width: 1.5,
              color: style.borderHighlightColor!,
            )
          : null,
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        HapticFeedback.selectionClick();
        _toggleAnswer(answer.id);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 15,
        children: [
          Container(
            width: 30,
            height: 30,
            padding: style.iconContainerPadding,
            decoration: BoxDecoration(
              color: style.iconContainerColor,
              shape: BoxShape.circle,
            ),
            child: answer.icon,
          ),
          Expanded(
            child: Text(
              answer.title,
              style: style.titleTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  bool _isSelected(String answerId) {
    return _selectedAnswerIds.contains(answerId);
  }

  void _toggleAnswer(String answerId) {
    if (widget.singleChoice) {
      _selectedAnswerIds.clear();
    }

    if (_isSelected(answerId)) {
      _selectedAnswerIds.remove(answerId);
    } else {
      _selectedAnswerIds.add(answerId);
    }

    setState(() {});

    if (widget.singleChoice) {
      Future.delayed(const Duration(milliseconds: 200), () {
        _onContinue();
      });
    }
  }

  void _onContinue() {
    widget.onContinue(_selectedAnswerIds);
  }
}
