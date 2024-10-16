import 'package:fingen/src/helpers/functions.dart';
import 'package:fingen/src/ui/components/Form/Input/index.dart';
import 'package:flutter/material.dart';
import 'package:mask/mask/mask.dart';

class FormDatePickerComponent extends StatefulWidget {
  final String label;
  final TextEditingController controller;

  const FormDatePickerComponent({
    super.key,
    required this.label,
    required this.controller,
  });


  @override
  State<FormDatePickerComponent> createState() => _FormDatePickerComponentState();
}

class _FormDatePickerComponentState extends State<FormDatePickerComponent> {
  DateTime dataSelecionada = DateTime.now();

  Future<void> _selecionarData(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dataSelecionada,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != dataSelecionada) {
      setState(() {
        widget.controller.text = Functions.dataPt("${picked.toLocal()}".split(' ')[0]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormInputComponent(
      label: widget.label,
      controller: widget.controller,
      keyboardType: TextInputType.datetime,
      formatters: [Mask.date()],
      action: () => _selecionarData(context),
    );
  }
}