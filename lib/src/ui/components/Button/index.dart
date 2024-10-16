import 'package:fingen/src/core/app_colors.dart';
import 'package:flutter/material.dart';

class ButtonComponent extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final String style;
  final double height;
  final double width;

  const ButtonComponent({
    super.key,
    required this.onPressed,
    required this.child,
    this.style = 'primary',
    this.height = 35.0,
    this.width = 100.0,
  });

  @override
  State<ButtonComponent> createState() => _ButtonComponentState();
}

class _ButtonComponentState extends State<ButtonComponent> {
  Map<String, ButtonStyle> buttonStyles = {
    'primary': ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(AppColors.blue),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      textStyle: WidgetStateProperty.all<TextStyle>(
        const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: Colors.white
        ),
      ),
    ),
    'success': ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(AppColors.success),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      textStyle: WidgetStateProperty.all<TextStyle>(
        const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: Colors.black
        ),
      ),
    ),
    'danger': ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(AppColors.danger),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      textStyle: WidgetStateProperty.all<TextStyle>(
        const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: Colors.black
        ),
      ),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: buttonStyles[widget.style],
      child: widget.child,
    );
  }
}