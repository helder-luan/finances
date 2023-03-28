
import 'package:finances/src/controllers/cartao_controller.dart';
import 'package:finances/src/controllers/gasto_controller.dart';
import 'package:finances/src/controllers/tipo_cartao_controller.dart';
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

class SaidaScreen extends StatefulWidget {
  const SaidaScreen({super.key});

  @override
  State<SaidaScreen> createState() => _SaidaScreenState();
}

class _SaidaScreenState extends State<SaidaScreen> {
  final GastoController _gastoController = GastoController();
  final CartaoController _cartaoController = CartaoController();
  final TipoOperacaoController _tipoOperacaoController = TipoOperacaoController();
  final TipoCartaoController _tipoCartaoController = TipoCartaoController();

  List<Map<dynamic, String>> formaDePagamento = [
    {'value': '0', 'label': 'Selecione uma forma de pagamento'},
    {'value': 'M', 'label': 'Dinheiro'},
    {'value': 'C', 'label': 'Cartão de crédito'},
    {'value': 'D', 'label': 'Cartão de débito'},
  ];

  List<Map<dynamic, String>> cartoesDeDebito = [
    {
      'value': '0',
      'label': 'Selecione um cartão de débito',
    }
  ];

  List<Map<dynamic, String>> cartoesDeCredito = [
    {
      'value': '0',
      'label': 'Selecione um cartão de crédito',
    }
  ];

  Future loadTipoOperacao() async {
    await _tipoOperacaoController.getTiposOperacao();

    _gastoController.idTipoOperacao.text = _tipoOperacaoController.dataSourceTipoOperacao.firstWhere((element) => element.descricao == 'Saída').idTipoOperacao.toString();
  }

  Future loadTiposCartao() async {
    await _tipoCartaoController.getTiposCartao();
  }

  void separaCartoes() {
    if (cartoesDeCredito.length <= 1 && cartoesDeDebito.length <= 1) {
      for (var cartao in _cartaoController.dataSourceCartao) {
        if (cartao.idTipoCartao == _tipoCartaoController.dataSourceTipoCartao.where((element) => element.descricao == 'Crédito').first.idTipoCartao) {
          cartoesDeCredito.add({
            'value': cartao.idCartao.toString(),
            'label': cartao.nome.toString(),
          });
        } else if (cartao.idTipoCartao == _tipoCartaoController.dataSourceTipoCartao.where((element) => element.descricao == 'Débito').first.idTipoCartao) {
          cartoesDeDebito.add({
            'value': cartao.idCartao.toString(),
            'label': cartao.nome.toString(),
          });
        } else if (cartao.idTipoCartao == _tipoCartaoController.dataSourceTipoCartao.where((element) => element.descricao == 'Ambos').first.idTipoCartao) {
          cartoesDeCredito.add({
            'value': cartao.idCartao.toString(),
            'label': cartao.nome.toString(),
          });
          
          cartoesDeDebito.add({
            'value': cartao.idCartao.toString(),
            'label': cartao.nome.toString(),
          });
        }
      }
    }
  }

  Future loadCartoes() async {
    await _cartaoController.atualizarDados();

    separaCartoes();
  }

  Future loadAll() async {
    await loadTipoOperacao();
    await loadTiposCartao();
    await loadCartoes();
  }

  @override
  void initState() {
    super.initState();
    _gastoController.reembolso.text = 'false';
    _gastoController.parcelado.text = 'false';
    _gastoController.gastoMensal.text = 'false';
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loadAll(),
        builder: ((context, snapshot) {
          if (
            _cartaoController.dataSourceCartao.isNotEmpty &&
            _tipoCartaoController.dataSourceTipoCartao.isNotEmpty &&
            _tipoOperacaoController.dataSourceTipoOperacao.isNotEmpty
          ) {
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
                                  FormDropdownComponent(
                                    label: 'Forma de pagamento',
                                    items: formaDePagamento,
                                    startValue: '0',
                                    onChanged: (value) {
                                      setState(() {
                                        _gastoController.formaDePagamento.text = value;
                                        _gastoController.parcelado.text = "false";
                                      });
                                    },
                                  ),
                                  // conditional rendering
                                  Visibility(
                                    visible: _gastoController.formaDePagamento.text == 'M',
                                    child: Column(
                                      children: [
                                        FormInputComponent(
                                          label: 'Descrição',
                                          controller: _gastoController.descricao,
                                        ),
                                        FormInputComponent(
                                          label: 'Valor',
                                          keyboardType: TextInputType.number,
                                          formatters: [Mask.money()],
                                          controller: _gastoController.valor,
                                        ),
                                        FormInputComponent(
                                          label: 'Detalhes',
                                          controller: _gastoController.detalhes,
                                        ),
                                      ]
                                    ),
                                  ),
                                  Visibility(
                                    visible: _gastoController.formaDePagamento.text != 'M',
                                    child: Column(
                                      children: [
                                        FormDropdownComponent(
                                          label: 'Cartão Usado',
                                          items: _gastoController.formaDePagamento.text == 'D' ? cartoesDeDebito : cartoesDeCredito,
                                          startValue: '0',
                                          onChanged: (value) {
                                            setState(() {
                                              _gastoController.idCartao.text = value;
                                            });
                                          },
                                        ),
                                        FormInputComponent(
                                          label: 'Descrição',
                                          controller: _gastoController.descricao,
                                        ),
                                        FormInputComponent(
                                          label: 'Valor',
                                          keyboardType: TextInputType.number,
                                          formatters: [Mask.money()],
                                          controller: _gastoController.valor,
                                        ),
                                        FormInputComponent(
                                          label: 'Detalhes',
                                          controller: _gastoController.detalhes,
                                        ),
                                        Visibility(
                                          visible: _gastoController.formaDePagamento.text == 'C' && _gastoController.parcelado.text == 'false',
                                          child: FormCheckboxComponent(
                                            label: 'Cobrança recorrente',
                                            checkVariable: _gastoController.gastoMensal.text == 'true' ? true : false,
                                            onChanged: (value) {
                                              setState(() {
                                                _gastoController.gastoMensal.text = value.toString();
                                              });
                                            },
                                          )
                                        ),
                                        Visibility(
                                          visible: _gastoController.formaDePagamento.text == 'C' && _gastoController.gastoMensal.text == 'false',
                                          child: FormCheckboxComponent(
                                            label: 'Parcelado',
                                            checkVariable: _gastoController.parcelado.text == 'true' ? true : false,
                                            onChanged: (value) {
                                              setState(() {
                                                _gastoController.parcelado.text = value.toString();
                                              });
                                            },
                                          )
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
                                        )
                                      ]
                                    )
                                  ),
                                  Visibility(
                                    visible: _gastoController.formaDePagamento.text != 'C',
                                    child: FormCheckboxComponent(
                                      label: 'Gasto mensal',
                                      checkVariable: _gastoController.gastoMensal.text == 'true' ? true : false,
                                      onChanged: (value) {
                                        setState(() {
                                          _gastoController.gastoMensal.text = value.toString();
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 16.0),
                                    width: MediaQuery.of(context).size.width-32,
                                    child: ButtonComponent(
                                      onPressed: () {
                                        _gastoController.handleSubmitOut(
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
                                      children: TextComponent(
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
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
      bottomNavigationBar: const BottomMenu(),
    );
  }
}