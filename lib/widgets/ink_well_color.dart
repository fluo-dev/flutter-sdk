import 'package:flutter/material.dart';

class InkWellColor extends StatefulWidget {
  const InkWellColor({
    super.key,
    required this.onTap,
    required this.child,
    this.color = Colors.transparent,
    this.highlightColor,
    this.padding = EdgeInsets.zero,
    this.border,
    this.highlightBorder,
    this.shrinkOnPressed = true,
    this.borderRadius = BorderRadiusGeometry.zero,
  });

  final VoidCallback onTap;
  final Widget child;
  final Color color;
  final Color? highlightColor;
  final EdgeInsets padding;
  final BoxBorder? border;
  final BoxBorder? highlightBorder;
  final bool shrinkOnPressed;
  final BorderRadiusGeometry borderRadius;

  @override
  State<InkWellColor> createState() => _InkWellColorState();
}

class _InkWellColorState extends State<InkWellColor> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHighlightChanged: (value) {
        setState(() => _isPressed = value);
      },
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _isPressed ? 0.98 : 1.0,
        duration: Duration(milliseconds: 100),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: _isPressed && widget.highlightColor != null
                ? widget.highlightColor
                : widget.color,
            border: _isPressed && widget.highlightBorder != null
                ? widget.highlightBorder
                : widget.border,
            borderRadius: widget.borderRadius,
          ),
          padding: widget.padding,
          child: widget.child,
        ),
      ),
    );
  }
}
