import 'package:finances/src/controllers/categoria_controller.dart';
import 'package:finances/src/controllers/gasto_controller.dart';
import 'package:finances/src/core/app_colors.dart';
import 'package:finances/src/helpers/functions.dart';
import 'package:finances/src/ui/components/BottomMenu/index.dart';
import 'package:finances/src/ui/components/Button/index.dart';
import 'package:finances/src/ui/components/Form/Checkbox/index.dart';
import 'package:finances/src/ui/components/Form/DatePicker/index.dart';
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
  final CategoriaController _categoriaController = CategoriaController();

  List<Map<dynamic, String>> categorias = [
    {'value': '', 'label': 'Selecione uma categoria'}
  ];

  Future<void> montaListaCategorias() async {
    await _categoriaController.getCategorias();

    categorias.clear();
    categorias.add({'value': '', 'label': 'Selecione uma categoria'});

    for (var categoria in _categoriaController.dataSourceCategoria) {
      categorias.add({
        'value': categoria.idCategoria.toString(),
        'label': categoria.descricao
      });
    }
  }

  Future loadAll() async {
    //
  }

  @override
  void initState() {
    super.initState();
    _gastoController.tipo.text = 'D';
    _gastoController.dataOcorrencia.text = Functions.dataPt("${DateTime.now().toLocal()}".split(' ')[0]);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loadAll(),
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
                            child: const TextComponent(
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
                                FormDatePickerComponent(
                                  label: 'Data da ocorrência',
                                  controller: _gastoController.dataOcorrencia,
                                ),
                                Visibility(
                                  visible: _gastoController.parcelado.text == 'N',
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                                    child: FormCheckboxComponent(
                                      label: 'Gasto Fixo',
                                      checkVariable: _gastoController.gastoMensal.text == 'S' ? true : false,
                                      onChanged: (value) {
                                        setState(() {
                                          _gastoController.gastoMensal.text = (value.toString() == 'true') ? 'S' : 'N';
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: _gastoController.gastoMensal.text == 'N',
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 8.0, top: 4.0),
                                    child: FormCheckboxComponent(
                                      label: 'Parcelado',
                                      checkVariable: _gastoController.parcelado.text == 'S' ? true : false,
                                      onChanged: (value) {
                                        setState(() {
                                          _gastoController.parcelado.text = (value.toString() == 'true') ? 'S' : 'N';
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: _gastoController.parcelado.text == 'S',
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
                                FutureBuilder(
                                  future: montaListaCategorias(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return const Text('Erro ao carregar categorias');
                                    }

                                    return FormDropdownComponent(
                                      label: 'Categoria',
                                      items: categorias,
                                      startValue: '',
                                      onChanged: (value) {
                                        _gastoController.idCategoria.text = value;
                                      },
                                    );
                                  }
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