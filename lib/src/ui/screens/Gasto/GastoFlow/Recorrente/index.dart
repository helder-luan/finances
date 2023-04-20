
import 'package:finances/src/controllers/gasto_controller.dart';
import 'package:finances/src/core/app_colors.dart';
import 'package:finances/src/data/models/transacao.dart';
import 'package:finances/src/helpers/functions.dart';
import 'package:finances/src/ui/components/BottomMenu/index.dart';
import 'package:finances/src/ui/components/TextComponent/index.dart';
import 'package:flutter/material.dart';

class CobrancaRecorrenteScreen extends StatefulWidget {
  const CobrancaRecorrenteScreen({super.key});

  @override
  State<CobrancaRecorrenteScreen> createState() => _CobrancaRecorrenteScreenState();
}

class _CobrancaRecorrenteScreenState extends State<CobrancaRecorrenteScreen> {
  final GastoController _gastoController = GastoController();
  List<Transacao> historico = [];

  Future loadTransacoesRecorrentes() async {
    historico = await _gastoController.getTransacoesRecorrentes();
  }

  Future loadAll() async {
    await loadTransacoesRecorrentes();
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
                        child: TextComponent(
                          text: 'Gerenciar',
                          style: 'title',
                        ),
                      ),
                      TextComponent(
                        text: 'Cobranças Recorrentes',
                        style: 'subtitle',
                      ),
                      FutureBuilder(
                        future: loadAll(),
                        builder: ((context, snapshot) {
                          if (historico.isNotEmpty) {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: historico.length,
                              itemBuilder: ((context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(top: 16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: TextComponent(
                                          text: historico[index].descricao.toString().toUpperCase(),
                                        ),
                                      ),
                                      TextComponent(
                                        text: Functions.toCurrency(double.parse(historico[index].valor.toString())),
                                      ),
                                      IconButton(
                                        onPressed: (){
                                          print('Excluir cobrança recorrente');
                                        },
                                        icon: const Icon(Icons.close_outlined, color: Colors.red,)
                                      )
                                    ],
                                  ),
                                );
                              }),
                            );
                          } else {
                            return const Center(
                              child: Text('Nenhuma cobrança recorrente'),
                            );
                          }
                        }),
                      ),
                    ],
                  )
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomMenu(),
    );
  }
}