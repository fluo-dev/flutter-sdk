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
      return Container(width: 0.0);
    }

    final theme = Theme.of(context);
    final fluoTheme = context.read<FluoTheme>();
    final isDark = theme.brightness == Brightness.dark;
    final surfaceColor = theme.colorScheme.surface;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.controller.clear,
        child: Container(
          margin: const EdgeInsets.only(left: 10.0),
          decoration: BoxDecoration(
            color: isDark ? Colors.white24 : Colors.black.withAlpha(50),
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.all(2.0),
          child: Icon(
            Icons.close_rounded,
            color: surfaceColor,
            size: fluoTheme.inputTextStyle.fontSize,
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
