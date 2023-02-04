import 'package:flutter/material.dart';

class TextComponent extends StatefulWidget {
  String text;
  String style;
  String align;
  Color color;
  FontWeight weigth;
  double size;
  
  TextComponent({
    super.key,
    required this.text,
    this.style = 'primary',
    this.align = 'left',
    this.color = Colors.black,
    this.weigth = FontWeight.w400,
    this.size = 16.0,
  });

  @override
  State<TextComponent> createState() => _TextComponentState();
}

class _TextComponentState extends State<TextComponent> {
  late final Map<String, TextStyle> textStyles = {
    'title': TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.w700,
      color: widget.color,
    ),
    'subtitle': TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
      color: widget.color,
    ),
    'primary': TextStyle(
      fontSize: widget.size,
      fontWeight: widget.weigth,
      color: widget.color,
    ),
    'caption': TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w700,
      color: widget.color,
    ),
    // textos do cartão
    'cardTitle': const TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    'cardVenc': const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    'cardNumVenc': const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    'cardFinal': const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    'cardNumFinal': const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
  };

  Map<String, TextAlign> textAligns = {
    'left': TextAlign.left,
    'right': TextAlign.right,
    'center': TextAlign.center,
  };

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      textAlign: textAligns[widget.align],
      style: textStyles[widget.style],
    );
  }
}