import 'package:fluo/fluo_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClearSuffixButton extends StatefulWidget {
  const ClearSuffixButton({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  State<ClearSuffixButton> createState() => _ClearSuffixButtonState();
}

class _ClearSuffixButtonState extends State<ClearSuffixButton> {
  bool _isEmpty = true;

  @override
  void initState() {
    super.initState();

    setState(() {
      _isEmpty = widget.controller.text.isEmpty;
    });

    widget.controller.addListener(_onTextFieldChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextFieldChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isEmpty) {
      return const SizedBox.shrink();
    }

    final fluoTheme = context.read<FluoTheme>();
    final inputDecorationTheme = fluoTheme.inputDecorationTheme;
    final inputTextStyle = fluoTheme.inputTextStyle;

    double? rightPadding;
    final contentPadding = inputDecorationTheme.contentPadding;
    if (contentPadding != null) {
      if (contentPadding is EdgeInsetsDirectional) {
        rightPadding = contentPadding.end;
      } else if (contentPadding is EdgeInsets) {
        rightPadding = contentPadding.right;
      }
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.controller.clear,
        child: Container(
          margin: EdgeInsets.only(
            left: 10.0,
            right: rightPadding ?? 0.0,
          ),
          decoration: BoxDecoration(
            color: inputDecorationTheme.hintStyle?.color?.withAlpha(40),
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.all(2.0),
          child: Icon(
            Icons.close_rounded,
            color: fluoTheme.inversePrimaryColor,
            size: inputTextStyle.fontSize,
          ),
        ),
      ),
    );
  }

  void _onTextFieldChanged() {
    setState(() {
      _isEmpty = widget.controller.text.isEmpty;
    });
  }
}
