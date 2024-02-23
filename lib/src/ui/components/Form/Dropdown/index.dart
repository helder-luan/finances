import 'package:finances/src/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

class FormDropdownComponent extends StatefulWidget {
  final String label;
  final List<Map<dynamic, String>> items;
  final dynamic startValue;
  final Function(dynamic)? onChanged;

  const FormDropdownComponent({
    super.key,
    required this.label,
    required this.items,
    required this.startValue,
    required this.onChanged,
  });

  @override
  State<FormDropdownComponent> createState() => _FormDropdownComponentState();
}

class _FormDropdownComponentState extends State<FormDropdownComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: widget.label,
          border: const GradientOutlineInputBorder(
            gradient: AppColors.gradient,
            width: 2.0,
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
        ),
        items: widget.items.map((item) => DropdownMenuItem(
          value: item['value'],
          child: Text(item['label'].toString()),
        )).toList(),
        value: widget.startValue,
        onChanged: widget.onChanged,
        validator: (value) {
          if (value == null) {
            return 'Por favor, selecione um(a) $widget.label';
          }
          return null;
        },
      )
    );
  }
}