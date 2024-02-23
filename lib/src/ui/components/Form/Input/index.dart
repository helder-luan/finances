import 'package:finances/src/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:validatorless/validatorless.dart';

class FormInputComponent extends StatefulWidget {
  final TextEditingController? controller;
  final String label;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? formatters;
  final bool isRequired;
  final Validatorless? validator;
  final Function()? action;

  const FormInputComponent({
    super.key,
    this.controller,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.formatters,
    this.isRequired = true,
    this.validator,
    this.action,
  });

  @override
  State<FormInputComponent> createState() => _FormInputComponentState();
}

class _FormInputComponentState extends State<FormInputComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: widget.controller,
        decoration:  InputDecoration(
          labelText: widget.label,
          border: const GradientOutlineInputBorder(
            gradient: AppColors.gradient,
            width: 2.0,
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
        ),
        keyboardType: widget.keyboardType,
        inputFormatters: widget.formatters,
        validator: (description) {
          if (widget.isRequired && description!.isEmpty) {
            return 'Por favor, insira um(a) ${widget.label.toLowerCase()}';
          }
          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onTap: widget.action
      ),
    );
  }
}