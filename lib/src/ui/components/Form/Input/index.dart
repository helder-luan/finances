import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:validatorless/validatorless.dart';

class FormInputComponent extends StatefulWidget {
  final TextEditingController? controller;
  final String label;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? formatters;
  final bool isRequired;
  final Validatorless? validator;
  final Function()? action;
  final bool isPassword;

  const FormInputComponent({
    super.key,
    this.controller,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.formatters,
    this.isRequired = true,
    this.validator,
    this.action,
    this.isPassword = false,
  });

  @override
  State<FormInputComponent> createState() => _FormInputComponentState();
}

class _FormInputComponentState extends State<FormInputComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      height: 40,
      child: TextFormField(
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        inputFormatters: widget.formatters,
        validator: (description) {
          if (widget.isRequired && description!.isEmpty) {
            return 'Por favor, insira um(a) ${widget.label.toLowerCase()}';
          }
          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onTap: widget.action,
        obscureText: widget.isPassword,
        decoration: InputDecoration(
          labelText: widget.label,
        ),
      ),
    );
  }
}