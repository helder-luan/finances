import 'package:fingen/src/theme/color_scheme.dart';
import 'package:fingen/src/ui/components/Button/index.dart';
import 'package:fingen/src/ui/components/Form/DatePicker/index.dart';
import 'package:fingen/src/ui/components/Form/Dropdown/index.dart';
import 'package:fingen/src/ui/components/Form/Input/index.dart';
import 'package:fingen/src/ui/components/Form/Switch/index.dart';
import 'package:flutter/material.dart';
import 'package:mask/mask/mask.dart';

class CadastroDespesa extends StatefulWidget {
  const CadastroDespesa({super.key});

  @override
  State<CadastroDespesa> createState() => _CadastroDespesaState();
}

class _CadastroDespesaState extends State<CadastroDespesa> {
  bool parcelado = false;
  bool recorrente = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova despesa'),
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
                margin: const EdgeInsets.only(top: 8, bottom: 8),
                child: FormDropdownComponent(
                  startValue: '1',
                  label: 'Forma de pagamento',
                  items: const [
                    {
                      'label': 'Cartão de crédito',
                      'value': '1',
                    },
                    {
                      'label': 'Dinheiro',
                      'value': '2',
                    },
                    {
                      'label': 'Pix',
                      'value': '3',
                    },
                  ],
                  onChanged: (value) {
                    // Implementar ação de mudança de categoria
                  },
                )
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FormSwitchComponent(
                      label: 'Parcelado',
                      value: parcelado,
                      activeColor: ColorSchemeCustom.danger,
                      onChanged: (value) {
                        setState(() {
                          parcelado = value;
                          recorrente = !value;
                        });
                      },
                    ),
                    FormSwitchComponent(
                      label: 'Recorrente',
                      value: recorrente,
                      activeColor: ColorSchemeCustom.danger,
                      onChanged: (value) {
                        setState(() {
                          recorrente = value;
                          parcelado = !value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              AnimatedOpacity(
                opacity: parcelado ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Visibility(
                  visible: parcelado,
                  child: const FormInputComponent(
                    label: 'Número de parcelas',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8, bottom: 8),
                child: FormDropdownComponent(
                  startValue: '1',
                  label: 'Cartão',
                  items: const [
                    {
                      'label': 'Mastercard',
                      'value': '1',
                    },
                    {
                      'label': 'Visa',
                      'value': '2',
                    },
                    {
                      'label': 'Elo',
                      'value': '3',
                    },
                  ],
                  onChanged: (value) {
                    // Implementar ação de mudança de categoria
                  },
                )
              ),
              Container(
                margin: const EdgeInsets.only(top: 8, bottom: 8),
                child: FormDropdownComponent(
                  startValue: '1',
                  label: 'Associar lançamento',
                  items: const [
                    {
                      'label': 'João',
                      'value': '1',
                    },
                    {
                      'label': 'Maria',
                      'value': '2',
                    },
                    {
                      'label': 'Pedro',
                      'value': '3',
                    }
                  ],
                  onChanged: (value) {
                    // Implementar ação de mudança de categoria
                  },
                )
              ),
              Container(
                height: 50,
                margin: const EdgeInsets.only(top: 32),
                child: ButtonComponent(
                  label: 'Salvar'
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}