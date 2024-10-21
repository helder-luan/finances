import 'package:flutter/material.dart';

class IconButtonCustom extends StatefulWidget {
  final IconData iconData;
  final Color? iconColor;

  const IconButtonCustom({
    super.key,
    required this.iconData,
    this.iconColor
  });

  @override
  State<IconButtonCustom> createState() => _IconButtonCustomState();
}

class _IconButtonCustomState extends State<IconButtonCustom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: Icon(
        widget.iconData,
        color: widget.iconColor ?? Theme.of(context).iconTheme.color,
      ),
    );
  }
}