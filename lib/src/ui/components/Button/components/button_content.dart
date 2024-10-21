import 'package:flutter/material.dart';

class ButtonContent extends StatefulWidget {
  final Widget child;
  final Widget? prefix;
  final Widget? suffix;

  const ButtonContent({
    super.key,
    required this.child,
    this.prefix,
    this.suffix,
  });

  @override
  State<ButtonContent> createState() => _ButtonContentState();
}

class _ButtonContentState extends State<ButtonContent> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.prefix != null) widget.prefix!,
        widget.child,
        if (widget.suffix != null) widget.suffix!,
      ],
    );
  }
}