import 'package:finances/src/controllers/categoria_controller.dart';
import 'package:finances/src/controllers/gasto_controller.dart';
import 'package:finances/src/core/app_colors.dart';
import 'package:finances/src/helpers/functions.dart';
import 'package:finances/src/ui/components/BottomMenu/index.dart';
import 'package:finances/src/ui/components/Button/index.dart';
import 'package:finances/src/ui/components/Form/DatePicker/index.dart';
import 'package:finances/src/ui/components/Form/Dropdown/index.dart';
import 'package:finances/src/ui/components/Form/Input/index.dart';
import 'package:finances/src/ui/components/TextComponent/index.dart';
import 'package:finances/src/ui/screens/Home/index.dart';
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

  Future<void> loadAll() async {
    _gastoController.tipo.text = 'R';
    _gastoController.dataOcorrencia.text = Functions.dataPt("${DateTime.now().toLocal()}".split(' ')[0]);
    await montaListaCategorias();
  }

  @override
  void initState() {
    super.initState();
    loadAll();
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
                        child: const TextComponent(
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
                              label: 'Detalhes',
                              controller: _gastoController.detalhes,
                              isRequired: false,
                            ),
                            FormInputComponent(
                              label: 'Valor',
                              controller: _gastoController.valor,
                              keyboardType: TextInputType.number,
                              formatters: [Mask.money()],
                            ),
                            FormDatePickerComponent(
                              label: 'Data da ocorrência',
                              controller: _gastoController.dataOcorrencia,
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
                                          builder: (context) => const HomeScreen(),
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
                                child: const TextComponent(
                                  text: 'Adicionar',
                                  weight: FontWeight.bold,
                                  color: Colors.white,
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