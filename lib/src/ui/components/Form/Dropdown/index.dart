import 'package:flutter/material.dart';

class FormDropdownComponent extends StatefulWidget {
  final String label;
  final List<Map<dynamic, dynamic>> items;
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
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: const TextStyle(
              fontSize: 16 ,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: DropdownButtonFormField(
              items: widget.items.map((item) => DropdownMenuItem(
                value: item['value'],
                child: Row(
                  children: [
                    item['icon'] != null
                    ? Container(
                      margin: const EdgeInsets.only(right: 16.0),
                      child: Icon(item['icon'])
                    )
                    : const SizedBox(),
                    Text(item['label'].toString())
                  ],
                ),
              )).toList(),
              value: widget.startValue,
              onChanged: widget.onChanged,
              validator: (value) {
                if (value == null) {
                  return 'Por favor, selecione um(a) $widget.label';
                }
                return null;
              },
            ),
          )
        ],
      ),
    );
  }
}