
import 'package:finances/src/controllers/card_controller.dart';
import 'package:finances/src/core/app_colors.dart';
import 'package:finances/src/data/models/card.dart' as card_model;
import 'package:finances/src/ui/components/BottomMenu/index.dart';
import 'package:finances/src/ui/components/Button/index.dart';
import 'package:finances/src/ui/components/Card/index.dart';
import 'package:finances/src/ui/components/Form/Dropdown/index.dart';
import 'package:finances/src/ui/components/Form/Input/index.dart';
import 'package:finances/src/ui/components/TextComponent/index.dart';
import 'package:finances/src/ui/screens/Card/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:motion_toast/motion_toast.dart';

class RegisterCardScreen extends StatefulWidget {
  card_model.Card? card;

  RegisterCardScreen({
    super.key,
    this.card,
  });

  @override
  State<RegisterCardScreen> createState() => _RegisterCardScreenState();
}

class _RegisterCardScreenState extends State<RegisterCardScreen> {
  var _formKey;
  final _controller = CardController();

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _controller.current = widget.card;
    _controller.typeController.text = _controller.current?.type ?? 'credit';
    
    if (_controller.hexColorController.text.isEmpty) {
      _controller.hexColorController.text = AppColors.purple.toString().substring(10, AppColors.purple.toString().length - 1);
    }
  }

  void changeColor(Color color) {
    setState(() => _controller.hexColorController.text = color.toString().substring(10, color.toString().length - 1));
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
                          text: _controller.current == null ? 'Cadastrar cartão' : 'Editar cartão',
                          style: 'title',
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            FormInputComponent(
                              controller: _controller.nameController,
                              label: 'Nome para o cartão'
                            ),
                            FormInputComponent(
                              controller: _controller.finalNumberController,
                              label: 'Final do cartão',
                              keyboardType: TextInputType.number,
                              isRequired: false,
                            ),
                            FormInputComponent(
                              controller: _controller.dueDayController,
                              label: 'Dia de vencimento',
                              keyboardType: TextInputType.number,
                              isRequired: false,
                            ),
                            FormDropdownComponent(
                              label: 'Tipo de cartão',
                              items: const [
                                {'value': 'credit', 'label': 'Crédito'},
                                {'value': 'debit', 'label': 'Débito'},
                              ],
                              startValue: _controller.typeController.text,
                              onChanged: (value) {
                                _controller.typeController.text = value;
                              },
                            ),
                            TextButton(
                              onPressed: () async {
                                await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Pick a color!'),
                                      content: SingleChildScrollView(
                                        child: ColorPicker(
                                          pickerColor: Color(int.parse("0xff${_controller.hexColorController.text}")),
                                          onColorChanged: changeColor,
                                        ),
                                      ),
                                      actions: <Widget>[
                                        ElevatedButton(
                                          child: const Text('Ok'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.color_lens),
                                    onPressed: (){},
                                  ),
                                  TextComponent(text: 'Selecionar uma cor para o cartão'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 16.0),
                        child: TextComponent(
                          text: 'Preview',
                          style: 'subtitle',
                        ),
                      ),
                      CardComponent(
                        cardName: _controller.nameController.text,
                        cardNumVenc: _controller.dueDayController.text,
                        cardNumFinal: _controller.finalNumberController.text,
                        cardColor: Color(int.parse("0xff${_controller.hexColorController.text}")),
                        onPressed: () {},
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 16.0),
                        width: MediaQuery.of(context).size.width-32,
                        decoration: BoxDecoration(
                          gradient: AppColors.gradient,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 1,
                              blurRadius: 8,
                              offset: Offset(0, 4), // changes position of shadow
                            ),
                          ],
                        ),
                        child: ButtonComponent(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _controller.handleSubmit(
                                onSuccess: () {

                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const CardScreen(),
                                    ),
                                    (route) => false
                                  );

                                  MotionToast.success(description: const Text('Cartão cadastrado com sucesso')).show(context);

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
                              setState(() {});
                            }
                          },
                          children: TextComponent(
                            text: 'Salvar',
                            weigth: FontWeight.bold,
                            color: Colors.white,
                          ),
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