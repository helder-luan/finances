import 'package:flutter/material.dart';

class FormCheckboxComponent extends StatefulWidget {
  final String label;
  final bool checkVariable;
  final Function(bool?)? onChanged;

  const FormCheckboxComponent({
    super.key,
    required this.label,
    required this.checkVariable,
    this.onChanged,
  });

  @override
  State<FormCheckboxComponent> createState() => _FormCheckboxComponentState();
}

class _FormCheckboxComponentState extends State<FormCheckboxComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            height: 24,
            width: 24,
            margin: const EdgeInsets.only(right: 8.0),
            decoration: BoxDecoration(
              color: widget.checkVariable ? Theme.of(context).inputDecorationTheme.fillColor : Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            ),
            child: Transform.scale(
              scale: 1.5,
              child: Checkbox(
                value: widget.checkVariable,
                fillColor: WidgetStateProperty.all(Colors.transparent),
                checkColor: Colors.white,
                side: const BorderSide(
                  color: Colors.black,
                  width: 2.0,
                ),
                onChanged: widget.onChanged,
              ),
            ),
          ),
          Text(widget.label),
        ],
      ),
    );
  }
}