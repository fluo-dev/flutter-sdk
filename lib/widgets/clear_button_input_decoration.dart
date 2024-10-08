import 'package:flutter/material.dart';

class ClearButtonInputDecoration extends InputDecoration {
  ClearButtonInputDecoration({
    required String hintText,
    required TextEditingController controller,
  }) : super(
          hintText: hintText,
          suffixIconConstraints: const BoxConstraints(maxHeight: 32, maxWidth: 32 + 10 + 15),
          suffixIcon: _ClearButton(controller: controller),
          isDense: true,
        );
}

class _ClearButton extends StatefulWidget {
  const _ClearButton({
    required this.controller,
  });

  final TextEditingController controller;

  @override
  State<_ClearButton> createState() => _ClearButtonState();
}

class _ClearButtonState extends State<_ClearButton> {
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
    final isDark = theme.brightness == Brightness.dark;
    final surfaceColor = theme.colorScheme.surface;

    return GestureDetector(
      onTap: widget.controller.clear,
      child: Container(
        margin: const EdgeInsets.only(left: 10.0, right: 15.0),
        decoration: BoxDecoration(
          color: isDark ? Colors.white24 : Colors.black.withAlpha(50),
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.all(2.0),
        child: Icon(
          Icons.close_rounded,
          color: surfaceColor,
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
