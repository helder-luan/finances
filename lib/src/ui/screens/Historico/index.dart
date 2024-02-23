

import 'package:finances/src/controllers/gasto_controller.dart';
import 'package:finances/src/controllers/mes_referencia_controller.dart';
import 'package:finances/src/core/app_colors.dart';
import 'package:finances/src/data/models/lancamento.dart';
import 'package:finances/src/helpers/functions.dart';
import 'package:finances/src/ui/components/BottomMenu/index.dart';
import 'package:finances/src/ui/components/TextComponent/index.dart';
import 'package:finances/src/ui/screens/DetalhesLancamento/index.dart';
import 'package:flutter/material.dart';

class HistoricoScreen extends StatefulWidget {
  const HistoricoScreen({super.key});

  @override
  State<HistoricoScreen> createState() => _HistoricoScreenState();
}

class _HistoricoScreenState extends State<HistoricoScreen> {
  final GastoController _gastoController = GastoController();

  List<Lancamento> historico = [];
  Future<void> loadHistorico() async {
    await _gastoController.getLancamentos();

    historico = _gastoController.dataSourceLancamento;
  }

  Future loadAll() async {
    await loadHistorico();
  }

  @override
  void initState() {
    super.initState();
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
                        margin: const EdgeInsets.only(bottom: 16.0),
                        child: TextComponent(
                          text: 'Histórico',
                          style: 'title',
                        ),
                      ),
                      FutureBuilder(
                        future: loadAll(),
                        builder: (context, snapshot) {
                          if (historico.isEmpty) {
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 32.0),
                              alignment: Alignment.center,
                              child: TextComponent(
                                text: 'Ainda não há transações',
                              ),
                            );
                          } else {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: historico.length,
                              itemBuilder: (BuildContext context, int index) {
                                Lancamento lancamento = historico[index];
      
                                double valor = lancamento.valor;
                            
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetalhesLancamento(lancamento: lancamento),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextComponent(
                                          text: lancamento.descricao.toString().length > 20 ? '${lancamento.descricao.toString().substring(0, 20).toUpperCase()}...' : lancamento.descricao.toString().toUpperCase(),
                                        ),
                                        TextComponent(
                                          text: "${lancamento.tipo == 'R' ? "+" : "-"} ${Functions.toCurrency(valor)}",
                                          color: lancamento.tipo == 'R' ? AppColors.success : AppColors.danger,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        }
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