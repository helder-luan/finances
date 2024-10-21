import 'package:fingen/src/ui/components/Button/index.dart';
import 'package:fingen/src/ui/components/Form/DatePicker/index.dart';
import 'package:fingen/src/ui/components/Form/Dropdown/index.dart';
import 'package:fingen/src/ui/components/Form/Input/index.dart';
import 'package:flutter/material.dart';
import 'package:mask/mask/mask.dart';

class CadastroReceita extends StatefulWidget {
  const CadastroReceita({super.key});

  @override
  State<CadastroReceita> createState() => _CadastroReceitaState();
}

class _CadastroReceitaState extends State<CadastroReceita> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova receita'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            children: [
              FormInputComponent(
                label: 'Valor',
                formatters: [ Mask.money() ],
                isRequired: true,
                controller: TextEditingController(text: 'R\$ 0,00'),
              ),
              FormDatePickerComponent(
                label: 'Data da ocorrência',
                controller: TextEditingController(),
              ),
              const FormInputComponent(
                label: 'Descrição',
                isRequired: true,
              ),
              Container(
                margin: const EdgeInsets.only(top: 8, bottom: 8),
                child: FormDropdownComponent(
                  startValue: '1',
                  label: 'Categoria',
                  items: const [
                    {
                      'label': 'Alimentação',
                      'value': '1',
                      'icon': Icons.restaurant,
                    },
                    {
                      'label': 'Educação',
                      'value': '2',
                      'icon': Icons.school,
                    },
                    {
                      'label': 'Saúde',
                      'value': '3',
                      'icon': Icons.medical_services,
                    }
                  ],
                  onChanged: (value) {
                    // Implementar ação de mudança de categoria
                  },
                )
              ),
              const FormInputComponent(
                label: 'Observações',
                isRequired: true,
              ),
              Container(
                height: 50,
                margin: const EdgeInsets.only(top: 32),
                child: ButtonComponent(
                  label: 'Salvar',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}