import 'package:finances/src/controllers/gasto_controller.dart';
import 'package:finances/src/core/app_colors.dart';
import 'package:finances/src/data/models/lancamento.dart';
import 'package:finances/src/helpers/functions.dart';
import 'package:finances/src/ui/components/BottomMenu/index.dart';
import 'package:finances/src/ui/components/Button/index.dart';
import 'package:finances/src/ui/components/Form/DatePicker/index.dart';
import 'package:finances/src/ui/components/TextComponent/index.dart';
import 'package:flutter/material.dart';

class HistoricoMensal
 extends StatefulWidget {
  const HistoricoMensal({super.key});

  @override
  State<HistoricoMensal> createState() => _HistoricoMensalState();
}

class _HistoricoMensalState extends State<HistoricoMensal> {
  final GastoController _gastoController = GastoController();

  List<Lancamento> lancamentos = [];

  Future<void> buscarLancamentos() async {
    await _gastoController.getLancamentosDatas();
    lancamentos = _gastoController.dataSourceLancamento;
    setState(() {});
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
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 16.0),
                        child: TextComponent(
                          text: "Histórico Por Mês",
                          style: 'title',
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 16.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: (MediaQuery.of(context).size.width / 2) - 32.0,
                                  child: FormDatePickerComponent(
                                    label: 'Data Inicial',
                                    controller: _gastoController.dataInicial,
                                  ),
                                ),
                                SizedBox(
                                  width: (MediaQuery.of(context).size.width / 2) - 32.0,
                                  child: FormDatePickerComponent(
                                    label: 'Data Final',
                                    controller: _gastoController.dataFinal,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 16.0),
                              width: MediaQuery.of(context).size.width - 32,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                gradient: AppColors.gradient,
                              ),
                              child: ButtonComponent(
                                style: 'primary',
                                onPressed: () async {
                                  await buscarLancamentos();
                                },
                                child: const Text('Buscar')
                              ),
                            )
                          ],
                        ),
                      ),
                      // renderizar lancamentos
                      Builder(
                        builder: (context) {
                          if (lancamentos.isNotEmpty) {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: lancamentos.length,
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
                                          text: lancamentos[index].descricao.toString().toUpperCase(),
                                        ),
                                      ),
                                      TextComponent(
                                        text: "${lancamentos[index].tipo == Lancamento.despesa ? '-' : '+'} ${Functions.toCurrency(lancamentos[index].valor)}",
                                        color: lancamentos[index].tipo == Lancamento.despesa ? AppColors.danger : AppColors.success,
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            );
                          } else {
                            return Container(
                              margin: const EdgeInsets.only(top: 16.0),
                              child: TextComponent(
                                text: "Nenhum lançamento encontrado",
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomMenu(),
    );
  }
}