import 'package:flutter/material.dart';

class FormSwitchComponent extends StatefulWidget {
  final String label;
  final bool value;
  final void Function(bool value) onChanged;
  final Color? activeColor;

  const FormSwitchComponent({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.activeColor,
  });

  @override
  State<FormSwitchComponent> createState() => _FormSwitchComponentState();
}

class _FormSwitchComponentState extends State<FormSwitchComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label),
        Switch(
          value: widget.value,
          onChanged: widget.onChanged,
          activeColor: widget.activeColor ?? Colors.black,
          inactiveThumbColor: Colors.black,
          inactiveTrackColor: Colors.grey,
        ),
      ],
    );
  }
}