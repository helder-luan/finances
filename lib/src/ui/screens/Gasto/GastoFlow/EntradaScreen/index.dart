
import 'package:finances/src/controllers/cartao_controller.dart';
import 'package:finances/src/controllers/gasto_controller.dart';
import 'package:finances/src/controllers/tipo_operacao_controller.dart';
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

class EntradaScreen extends StatefulWidget {
  const EntradaScreen({super.key});

  @override
  State<EntradaScreen> createState() => _EntradaScreenState();
}

class _EntradaScreenState extends State<EntradaScreen> {
  final GastoController _gastoController = GastoController();
  final CartaoController _cartaoController = CartaoController();
  final TipoOperacaoController _tipoOperacaoController = TipoOperacaoController();

  bool? ressarcimento = false;

  List<Map<String, String>> myCards = [
    {
      'value': '',
      'label': 'Selecione um cartão',
    }
  ];

  void loadCartoes() async {
    await _cartaoController.atualizarDados();
    _cartaoController.dataSourceCartao.map((cartao) {
      myCards.add({
        'value': cartao.idCartao.toString(),
        'label': cartao.nome.toString(),
      });
    }).toList();
  }

  void loadTipoOperacao() async {
    await _tipoOperacaoController.getTiposOperacao();

    _gastoController.idTipoOperacao.text = _tipoOperacaoController.dataSourceTipoOperacao.firstWhere((element) => element.descricao == 'Entrada').idTipoOperacao.toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadCartoes();
    loadTipoOperacao();

    _gastoController.reembolso.text = 'false';
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
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
                  height: MediaQuery.of(context).size.height,
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
                          text: 'Entrada',
                          color: AppColors.success,
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
                              label: 'Valor',
                              controller: _gastoController.valor,
                              keyboardType: TextInputType.number,
                              formatters: [Mask.money()],
                            ),
                            FormInputComponent(
                              label: 'Detalhes',
                              controller: _gastoController.detalhes,
                            ),
                            FormCheckboxComponent(
                              label: 'Ressarcimento',
                              checkVariable: ressarcimento,
                              onChanged: (value) {
                                setState(() {
                                  ressarcimento = value;
                                  _gastoController.reembolso.text = value.toString();
                                });
                              },
                            ),
                            Visibility(
                              visible: ressarcimento!,
                              child: FormDropdownComponent(
                                label: 'Cartão',
                                items: myCards,
                                startValue: '',
                                onChanged: (value) {
                                  _gastoController.idCartao.text = value.toString();
                                },
                              )
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 16.0),
                              width: MediaQuery.of(context).size.width-32,
                              child: ButtonComponent(
                                onPressed: () {
                                  _gastoController.handleSubmitEntry(
                                    onSuccess: () {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const GastoScreen(),
                                        ),
                                        (route) => false
                                      );

                                      MotionToast.success(description: const Text('Entrada adicionada com sucesso!')).show(context);

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
                                style: 'success',
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
      ),
      bottomNavigationBar: const BottomMenu(),
    );
  }
}