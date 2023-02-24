
import 'package:finances/src/controllers/cartao_controller.dart';
import 'package:finances/src/controllers/tipo_cartao_controller.dart';
import 'package:finances/src/core/app_colors.dart';
import 'package:finances/src/data/models/cartao.dart';
import 'package:finances/src/ui/components/BottomMenu/index.dart';
import 'package:finances/src/ui/components/Button/index.dart';
import 'package:finances/src/ui/components/Cartao/index.dart';
import 'package:finances/src/ui/components/Form/Dropdown/index.dart';
import 'package:finances/src/ui/components/Form/Input/index.dart';
import 'package:finances/src/ui/components/TextComponent/index.dart';
import 'package:finances/src/ui/screens/Cartao/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:motion_toast/motion_toast.dart';

class RegistrarCartaoScreen extends StatefulWidget {
  Cartao? cartao;

  RegistrarCartaoScreen({
    super.key,
    this.cartao,
  });

  @override
  State<RegistrarCartaoScreen> createState() => _RegistrarCartaoScreenState();
}

class _RegistrarCartaoScreenState extends State<RegistrarCartaoScreen> {
  final CartaoController _cartaoController = CartaoController();
  final TipoCartaoController _tipoCartaoController = TipoCartaoController();

  List<Map<dynamic, String>> tiposCartao = [
    {
      'value': '',
      'label': 'Selecione um tipo de cartão',
    }
  ];
  
  // Future verificaContrasteDaCorHexadecimal(String hexColor) async {
  //   if (hexColor.length == 10) {
  //     hexColor = hexColor.substring(4, 10);
  //   }

  //   final r = int.parse(hexColor.substring(0, 2), radix: 16);
  //   final g = int.parse(hexColor.substring(2, 4), radix: 16);
  //   final b = int.parse(hexColor.substring(4, 6), radix: 16);

  //   final brightness = ((r * 299) + (g * 587) + (b * 114)) / 1000;

  //   if (brightness > 125) {
  //     _cartaoController.textoCorController.text = Colors.white.toString().substring(10, Colors.white.toString().length - 1);
  //   } else {
  //     _cartaoController.textoCorController.text = Colors.black.toString().substring(10, Colors.black.toString().length - 1);
  //   }
  // }

  void changeColor(Color color) async {
    setState(() {
      _cartaoController.hexCorController.text = color.toString().substring(10, color.toString().length - 1);
    });
  }

  void mapTipoCartao() {
    for (var tipo in _tipoCartaoController.dataSourceTipoCartao) {
      tiposCartao.add({
        'value': tipo.idTipoCartao.toString(),
        'label': tipo.descricao.toString(),
      });
    }
  }

  Future loadTipoCartao() async {
    await _tipoCartaoController.getTiposCartao();

    tiposCartao.length <= 1 ? mapTipoCartao() : null;
  }

  @override
  void initState() {
    super.initState();
    loadTipoCartao();

    _cartaoController.current = widget.cartao;
    _cartaoController.idTipoCartaoController.text = _cartaoController.current?.idTipoCartao.toString() ?? '';
    
    if (_cartaoController.hexCorController.text.isEmpty) {
      _cartaoController.hexCorController.text = AppColors.purple.toString().substring(10, AppColors.purple.toString().length - 1);
    }
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
                          text: _cartaoController.current == null ? 'Cadastrar cartão' : 'Editar cartão',
                          style: 'title',
                        ),
                      ),
                      Form(
                        child: Column(
                          children: [
                            FormInputComponent(
                              controller: _cartaoController.nomeController,
                              label: 'Nome para o cartão'
                            ),
                            FormInputComponent(
                              controller: _cartaoController.finalCartaoController,
                              label: 'Final do cartão',
                              keyboardType: TextInputType.number,
                              isRequired: false,
                            ),
                            FormInputComponent(
                              controller: _cartaoController.diaVencimentoController,
                              label: 'Dia de vencimento',
                              keyboardType: TextInputType.number,
                              isRequired: false,
                            ),
                            FormInputComponent(
                              controller: _cartaoController.diaFechamentoController,
                              label: 'Dia de fechamento',
                              keyboardType: TextInputType.number,
                              isRequired: false,
                            ),
                            FutureBuilder(
                              future: loadTipoCartao(),
                              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                if (tiposCartao.length > 1) {
                                  return FormDropdownComponent(
                                    label: 'Tipo de cartão',
                                    items: tiposCartao,
                                    startValue: _cartaoController.idTipoCartaoController.text,
                                    onChanged: (value) {
                                      _cartaoController.idTipoCartaoController.text = value;
                                    },
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
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
                                          pickerColor: Color(int.tryParse("0xff${_cartaoController.hexCorController.text}")!),
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
                      CartaoComponent(
                        cardName: _cartaoController.nomeController.text,
                        cardNumVenc: _cartaoController.diaVencimentoController.text,
                        cardNumFinal: _cartaoController.finalCartaoController.text,
                        cardColor: Color(int.tryParse("0xff${_cartaoController.hexCorController.text}")!),
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
                            _cartaoController.handleSubmit(
                              onSuccess: () {
    
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CartaoScreen(),
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
                          },
                          children: TextComponent(
                            text: 'Salvar',
                            weight: FontWeight.bold,
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