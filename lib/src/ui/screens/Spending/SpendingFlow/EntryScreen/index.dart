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

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  var _formKey;
  bool? ressarcimento = false;

  final _controller = SpendingController();

  List<Map<String, String>> myCards = [
    {
      'value': '0',
      'label': 'Selecione um cartão',
    }
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    cards.map((card) {
      myCards.add({
        'value': card.id.toString(),
        'label': card.name.toString(),
      });
    }).toList();

    _controller.movimentType.text = 'entry';
    _controller.refound.text = 'false';
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
                        key: _formKey,
                        child: Column(
                          children: [
                            FormInputComponent(
                              label: 'Descrição',
                              controller: _controller.description,
                            ),
                            FormInputComponent(
                              label: 'Valor',
                              controller: _controller.value,
                              keyboardType: TextInputType.number,
                              formatters: [Mask.money()],
                            ),
                            FormInputComponent(
                              label: 'Detalhes',
                              controller: _controller.details,
                            ),
                            FormCheckboxComponent(
                              label: 'Ressarcimento',
                              checkVariable: ressarcimento,
                              onChanged: (value) {
                                setState(() {
                                  ressarcimento = value;
                                  _controller.refound.text = value.toString();
                                });
                              },
                            ),
                            Visibility(
                              visible: ressarcimento!,
                              child: FormDropdownComponent(
                                label: 'Cartão',
                                items: myCards,
                                startValue: '0',
                                onChanged: (value) {
                                  _controller.cardId.text = value.toString();
                                },
                              )
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 16.0),
                              width: MediaQuery.of(context).size.width-32,
                              child: ButtonComponent(
                                onPressed: () {
                                  _controller.handleSubmitEntry(
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
                                style: 'success',
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