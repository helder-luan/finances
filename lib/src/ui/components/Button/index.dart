import 'package:fingen/src/theme/color_scheme.dart';
import 'package:fingen/src/ui/components/Button/components/button_content.dart';
import 'package:flutter/material.dart';

class ButtonComponent extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final ButtonType type;
  final double height;
  final double width;
  final Widget? prefix;
  final Widget? suffix;
  final ButtonContent child;

  ButtonComponent({
    super.key,
    required this.label,
    this.onPressed,
    this.type = ButtonType.primary,
    this.height = 40.0,
    this.width = 100.0,
    this.prefix,
    this.suffix,
  }) : child = ButtonContent(prefix: prefix, suffix: suffix, child: Text(label));

  @override
  State<ButtonComponent> createState() => _ButtonComponentState();
}

class _ButtonComponentState extends State<ButtonComponent> {

  @override
  Widget build(BuildContext context) {
    final Size buttonSize = Size(widget.width, widget.height);

    final ButtonStyle buttonStyle = switch (widget.type) {
      ButtonType.primary => ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(ColorSchemeCustom.textHighlight),
        foregroundColor: const WidgetStatePropertyAll(ColorSchemeCustom.primary),
        minimumSize: WidgetStatePropertyAll(buttonSize)
      ),
      ButtonType.secondary => ButtonStyle(
        foregroundColor: const WidgetStatePropertyAll(ColorSchemeCustom.textHighlight),
        backgroundColor: const WidgetStatePropertyAll(ColorSchemeCustom.primary),
        minimumSize: WidgetStatePropertyAll(buttonSize)
      ),
    };

    return ElevatedButton(
      onPressed: widget.onPressed,
      style: buttonStyle, 
      child: widget.child
    );
  }
}

enum ButtonType { primary, secondary }
