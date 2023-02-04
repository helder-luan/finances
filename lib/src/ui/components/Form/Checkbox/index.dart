import 'package:finances/src/core/app_colors.dart';
import 'package:flutter/material.dart';

class FormCheckboxComponent extends StatefulWidget {
  String label;
  bool? checkVariable;
  Function(bool?)? onChanged;

  FormCheckboxComponent({
    super.key,
    required this.label,
    this.checkVariable,
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
              gradient: widget.checkVariable! ? AppColors.gradient : const LinearGradient(
                colors: [ 
                  Colors.transparent,
                  Colors.transparent,
                ],
              ),
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            ),
            child: Transform.scale(
              scale: 1.5,
              child: Checkbox(
                value: widget.checkVariable,
                fillColor: MaterialStateProperty.all(Colors.transparent),
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