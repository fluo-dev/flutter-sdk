import 'package:flutter/material.dart';

class RoundButton extends StatefulWidget {
  const RoundButton({
    super.key,
    required this.onPressed,
    required this.color,
    this.iconData = Icons.arrow_back_rounded,
  });

  final Function()? onPressed;
  final Color color;
  final IconData iconData;

  @override
  State<RoundButton> createState() => _RoundButtonState();
}

class _RoundButtonState extends State<RoundButton> {
  Color? _backgroundColor;

  @override
  Widget build(BuildContext context) {
    final bgColorNormal = widget.color.withAlpha(20);
    final bgColorPressed = widget.color.withAlpha(40);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: (details) {
          setState(() {
            _backgroundColor = bgColorPressed;
          });
        },
        onTapUp: (details) {
          setState(() {
            _backgroundColor = bgColorNormal;
          });
          if (widget.onPressed != null) {
            widget.onPressed!();
          }
        },
        onTapCancel: () {
          setState(() {
            _backgroundColor = bgColorNormal;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: widget.onPressed != null
                ? _backgroundColor ?? bgColorNormal
                : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            widget.iconData,
            color: widget.onPressed != null ? widget.color : Colors.transparent,
            size: 20.0,
          ),
        ),
      ),
    );
  }
}
