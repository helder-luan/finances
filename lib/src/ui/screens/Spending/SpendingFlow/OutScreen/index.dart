import 'package:finances/src/controllers/spending_controller.dart';
import 'package:finances/src/core/app_colors.dart';
import 'package:finances/src/mock/mockDataUser.dart';
import 'package:finances/src/ui/components/BottomMenu/index.dart';
import 'package:finances/src/ui/components/Button/index.dart';
import 'package:finances/src/ui/components/Form/Checkbox/index.dart';
import 'package:finances/src/ui/components/Form/Dropdown/index.dart';
import 'package:finances/src/ui/components/Form/Input/index.dart';
import 'package:finances/src/ui/components/TextComponent/index.dart';
import 'package:finances/src/ui/screens/Spending/index.dart';
import 'package:flutter/material.dart';
import 'package:mask/mask/mask.dart';
import 'package:motion_toast/motion_toast.dart';

class OutScreen extends StatefulWidget {
  const OutScreen({super.key});

  @override
  State<OutScreen> createState() => _OutScreenState();
}

class _OutScreenState extends State<OutScreen> {
  var _formKey;
  final _controller = SpendingController();

  List<Map<dynamic, String>> formPayment = [
    {'value': '0', 'label': 'Selecione uma forma de pagamento'},
    {'value': 'M', 'label': 'Dinheiro'},
    {'value': 'C', 'label': 'Cartão de crédito'},
    {'value': 'D', 'label': 'Cartão de débito'},
  ];

  List<Map<dynamic, String>> myDebitCards = [
    {
      'value': '0',
      'label': 'Selecione um cartão',
    }
  ];

  List<Map<dynamic, String>> myCreditCards = [
    {
      'value': '0',
      'label': 'Selecione um cartão',
    }
  ];

  @override
  void initState() {
    super.initState();
    _controller.movimentType.text = 'out';
    _controller.refound.text = 'false';
    _controller.paymentInstallments.text = 'false';
    _controller.monthlyExpense.text = 'false';

    cards.map((card) {
      if (card.type == "credit") {
        myCreditCards.add({
          'value': card.id.toString(),
          'label': card.name.toString(),
        });
      }

      if (card.type == "debit") {
        myDebitCards.add({
          'value': card.id.toString(),
          'label': card.name.toString(),
        });
      }
    }).toList();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                        key: _formKey,
                        child: Column(
                          children: [
                            FormDropdownComponent(
                              label: 'Forma de pagamento',
                              items: formPayment,
                              startValue: '0',
                              onChanged: (value) {
                                setState(() {
                                  _controller.formPayment.text = value;
                                  _controller.paymentInstallments.text = "false";
                                });
                              },
                            ),
                            // conditional rendering
                            Visibility(
                              visible: _controller.formPayment.text == 'M',
                              child: Column(
                                children: [
                                  FormInputComponent(
                                    label: 'Descrição',
                                    controller: _controller.description,
                                  ),
                                  FormInputComponent(
                                    label: 'Valor',
                                    keyboardType: TextInputType.number,
                                    formatters: [Mask.money()],
                                    controller: _controller.value,
                                  ),
                                  FormInputComponent(
                                    label: 'Detalhes',
                                    controller: _controller.details,
                                  ),
                                ]
                              ),
                            ),
                            Visibility(
                              visible: _controller.formPayment.text != 'M',
                              child: Column(
                                children: [
                                  FormDropdownComponent(
                                    label: 'Cartão Usado',
                                    items: _controller.formPayment.text == 'D' ? myDebitCards : myCreditCards,
                                    startValue: '0',
                                    onChanged: (value) {
                                      setState(() {
                                        _controller.cardId.text = value;
                                      });
                                    },
                                  ),
                                  FormInputComponent(
                                    label: 'Descrição',
                                    controller: _controller.description,
                                  ),
                                  FormInputComponent(
                                    label: 'Valor',
                                    keyboardType: TextInputType.number,
                                    formatters: [Mask.money()],
                                    controller: _controller.value,
                                  ),
                                  FormInputComponent(
                                    label: 'Detalhes',
                                    controller: _controller.details,
                                  ),
                                  Visibility(
                                    visible: _controller.formPayment.text == 'C' && _controller.paymentInstallments.text == 'false',
                                    child: FormCheckboxComponent(
                                      label: 'Cobrança recorrente',
                                      checkVariable: _controller.monthlyExpense.text == 'true' ? true : false,
                                      onChanged: (value) {
                                        setState(() {
                                          _controller.monthlyExpense.text = value.toString();
                                        });
                                      },
                                    )
                                  ),
                                  Visibility(
                                    visible: _controller.formPayment.text == 'C' && _controller.monthlyExpense.text == 'false',
                                    child: FormCheckboxComponent(
                                      label: 'Parcelado',
                                      checkVariable: _controller.paymentInstallments.text == 'true' ? true : false,
                                      onChanged: (value) {
                                        setState(() {
                                          _controller.paymentInstallments.text = value.toString();
                                        });
                                      },
                                    )
                                  ),
                                  Visibility(
                                    visible: _controller.paymentInstallments.text == 'true',
                                    child: Column(
                                      children: [
                                        FormInputComponent(
                                          label: 'Quantidade de Parcelas',
                                          keyboardType: TextInputType.number,
                                          controller: _controller.totalInstallments,
                                        ),
                                        FormInputComponent(
                                          label: 'Parcela Atual',
                                          keyboardType: TextInputType.number,
                                          controller: _controller.currentInstallments,
                                        ),
                                      ]
                                    ),
                                  )
                                ]
                              )
                            ),
                            Visibility(
                              visible: _controller.formPayment.text != 'C',
                              child: FormCheckboxComponent(
                                label: 'Gasto mensal',
                                checkVariable: _controller.monthlyExpense.text == 'true' ? true : false,
                                onChanged: (value) {
                                  setState(() {
                                    _controller.monthlyExpense.text = value.toString();
                                  });
                                },
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 16.0),
                              width: MediaQuery.of(context).size.width-32,
                              child: ButtonComponent(
                                onPressed: () {
                                  _controller.handleSubmitOut(
                                    onSuccess: () {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const SpendingScreen(),
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
                                style: 'danger',
                                children: TextComponent(
                                  text: 'Adicionar',
                                  weigth: FontWeight.bold
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