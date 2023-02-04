import 'package:finances/src/core/app_colors.dart';
import 'package:flutter/material.dart';

class ButtonComponent extends StatefulWidget {
  final VoidCallback onPressed;
  Widget children;
  String style;
  double height;
  double width;
  ButtonComponent({
    super.key,
    required this.onPressed,
    required this.children,
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
      // para definir altura e largura do botao, envolver o botao em um container e definir a altura e largura do container

      // para adicionar linear gradient, envolver o botao em um container e colocar o linear gradient no container
      backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      shadowColor: MaterialStateProperty.all<Color>(Colors.black12),
    ),
    'success': ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(AppColors.success),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      textStyle: MaterialStateProperty.all<TextStyle>(
        const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: Colors.black
        ),
      ),
    ),
    'danger': ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(AppColors.danger),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      textStyle: MaterialStateProperty.all<TextStyle>(
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
      child: widget.children,
    );
  }
}
