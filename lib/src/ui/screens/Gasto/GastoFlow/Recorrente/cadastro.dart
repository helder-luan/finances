import 'package:finances/src/controllers/categoria_controller.dart';
import 'package:finances/src/controllers/gasto_controller.dart';
import 'package:finances/src/core/app_colors.dart';
import 'package:finances/src/ui/components/BottomMenu/index.dart';
import 'package:finances/src/ui/components/Button/index.dart';
import 'package:finances/src/ui/components/Form/DatePicker/index.dart';
import 'package:finances/src/ui/components/Form/Dropdown/index.dart';
import 'package:finances/src/ui/components/Form/Input/index.dart';
import 'package:finances/src/ui/components/TextComponent/index.dart';
import 'package:finances/src/ui/screens/Gasto/GastoFlow/Recorrente/index.dart';
import 'package:flutter/material.dart';
import 'package:mask/mask/mask.dart';
import 'package:toast/toast.dart';

class CadastroRecorrente extends StatefulWidget {
  const CadastroRecorrente({super.key});

  @override
  State<CadastroRecorrente> createState() => _CadastroRecorrenteState();
}

class _CadastroRecorrenteState extends State<CadastroRecorrente> {
  final GastoController _gastoController = GastoController();
  final CategoriaController _categoriaController = CategoriaController();

  List<Map<dynamic, String>> categorias = [];

  Future<void> montaListaCategorias() async {
    categorias = [{'value': '', 'label': 'Selecione uma categoria'}];

    await _categoriaController.getCategorias();

    for (var categoria in _categoriaController.dataSourceCategoria) {
      categorias.add({
        'value': categoria.idCategoria.toString(),
        'label': categoria.descricao
      });
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
                  height: MediaQuery.of(context).size.height - 100,
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
                        margin: const EdgeInsets.only(bottom: 16.0),
                        child: const Text(
                          'Cadastrar Recorrência',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
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
                              width: MediaQuery.of(context).size.width - 32,
                              decoration: const BoxDecoration(
                                gradient: AppColors.gradient,
                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                              ),
                              child: ButtonComponent(
                                onPressed: () async {
                                  await _gastoController.cadastrarRecorrente()
                                    .then((value) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const CobrancaRecorrenteScreen(),
                                        ),
                                      );

                                      ToastContext().context = context;
                                      
                                      Toast.show(
                                        'Recorrência cadastrada com sucesso',
                                        duration: 3,
                                        gravity: Toast.bottom,
                                      );
                                    });
                                },
                                child: const TextComponent(
                                  text: 'Adicionar',
                                  weight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ),
        ),
      ),
      bottomNavigationBar: const BottomMenu(),
    );
  }
}