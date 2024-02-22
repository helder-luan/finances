import 'package:finances/src/controllers/gasto_controller.dart';
import 'package:finances/src/core/app_colors.dart';
import 'package:finances/src/ui/components/BottomMenu/index.dart';
import 'package:finances/src/ui/components/Button/index.dart';
import 'package:finances/src/ui/components/Form/Checkbox/index.dart';
import 'package:finances/src/ui/components/Form/Dropdown/index.dart';
import 'package:finances/src/ui/components/Form/Input/index.dart';
import 'package:finances/src/ui/components/TextComponent/index.dart';
import 'package:finances/src/ui/screens/Gasto/index.dart';
import 'package:flutter/material.dart';
import 'package:mask/mask/mask.dart';
import 'package:motion_toast/motion_toast.dart';

class SaidaScreen extends StatefulWidget {
  const SaidaScreen({super.key});

  @override
  State<SaidaScreen> createState() => _SaidaScreenState();
}

class _SaidaScreenState extends State<SaidaScreen> {
  final GastoController _gastoController = GastoController();

  @override
  void initState() {
    super.initState();
    _gastoController.parcelado.text = 'N';
    _gastoController.gastoMensal.text = 'N';
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        builder: (context, snapshot) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: AppColors.gradient,
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 32.0),
                      padding: const EdgeInsets.all(16.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 24.0),
                            child: TextComponent(
                              text: 'Saída',
                              color: AppColors.danger,
                              style: 'title',
                            ),
                          ),
                          Form(
                            child: Column(
                              children: [
                                FormInputComponent(
                                  label: 'Descrição',
                                  controller: _gastoController.descricao,
                                ),
                                FormInputComponent(
                                  label: 'Detalhes',
                                  controller: _gastoController.detalhes,
                                ),
                                FormInputComponent(
                                  label: 'Valor',
                                  keyboardType: TextInputType.number,
                                  formatters: [Mask.money()],
                                  controller: _gastoController.valor,
                                ),
                                FormCheckboxComponent(
                                  label: 'Cobrança recorrente',
                                  checkVariable: _gastoController.gastoMensal.text == 'true' ? true : false,
                                  onChanged: (value) {
                                    setState(() {
                                      _gastoController.gastoMensal.text = value.toString() == 'true' ? 'S' : 'N';
                                    });
                                  },
                                ),
                                FormCheckboxComponent(
                                  label: 'Parcelado',
                                  checkVariable: _gastoController.parcelado.text == 'S' ? true : false,
                                  onChanged: (value) {
                                    setState(() {
                                      _gastoController.parcelado.text = value.toString() == 'true' ? 'S' : 'N';
                                    });
                                  },
                                ),
                                Visibility(
                                  visible: _gastoController.parcelado.text == 'true',
                                  child: Column(
                                    children: [
                                      FormInputComponent(
                                        label: 'Quantidade de Parcelas',
                                        keyboardType: TextInputType.number,
                                        controller: _gastoController.totalParcelas,
                                      ),
                                      FormInputComponent(
                                        label: 'Parcela Atual',
                                        keyboardType: TextInputType.number,
                                        controller: _gastoController.parcelaAtual,
                                      ),
                                    ]
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 16.0),
                                  width: MediaQuery.of(context).size.width-32,
                                  child: ButtonComponent(
                                    onPressed: () {
                                      _gastoController.handleSubmit(
                                        onSuccess: () {
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => const GastoScreen(),
                                            ),
                                            (route) => false
                                          );

                                          MotionToast.success(description: const Text('Gasto adicionado com sucesso!')).show(context);

                                          return null;
                                        },
                                        onFailure: (onFailure) {
                                          MotionToast
                                            .error(
                                              title: const Text("Atenção"),
                                              description: Text(onFailure)
                                            )
                                            .show(context);
                                          return null;
                                        }
                                      );
                                    },
                                    style: 'danger',
                                    child: TextComponent(
                                      text: 'Adicionar',
                                      weight: FontWeight.bold
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    )
                  ],
                )
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const BottomMenu(),
    );
  }
}