import 'package:finances/src/controllers/gasto_controller.dart';
import 'package:finances/src/controllers/mes_referencia_controller.dart';
import 'package:finances/src/core/app_colors.dart';
import 'package:finances/src/data/models/lancamento.dart';
import 'package:finances/src/helpers/functions.dart';
import 'package:finances/src/ui/components/BottomMenu/index.dart';
import 'package:finances/src/ui/components/Button/index.dart';
import 'package:finances/src/ui/components/QuickActionsMenu/index.dart';
import 'package:finances/src/ui/components/QuickActionsMenu/quick_action.dart';
import 'package:finances/src/ui/components/TextComponent/index.dart';
import 'package:finances/src/ui/screens/DetalhesLancamento/index.dart';
import 'package:finances/src/ui/screens/Gasto/GastoFlow/EntradaScreen/index.dart';
import 'package:finances/src/ui/screens/Gasto/GastoFlow/Recorrente/index.dart';
import 'package:finances/src/ui/screens/Gasto/GastoFlow/SaidaScreen/index.dart';
import 'package:finances/src/ui/screens/HistoricoMensal/index.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GastoController _gastoController = GastoController();
  final MesReferenciaController _mesReferenciaController = MesReferenciaController();

  List<Lancamento> lancamentos = [];

  double gastoFixo = 0.0;
  double gastoMes = 0.0;

  Future<void> loadHistorico() async {
    await _gastoController.getLancamentosMesAtual(_mesReferenciaController.current);
    lancamentos = _gastoController.dataSourceLancamento;
  }

  Future<void> calculaTotal() async {
    gastoFixo = 0.0;
    gastoMes = 0.0;

    for (var lancamento in lancamentos) {
      if (lancamento.situacao != 'A') continue;

      if (lancamento.tipo == Lancamento.despesa) {
        gastoMes += lancamento.valor;

        if (lancamento.recorrente == 'S' || lancamento.parcelado == 'S') {
          gastoFixo += lancamento.valor;
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: loadHistorico(),
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: AppColors.gradient,
                    ),
                    child: Column(
                      children: [
                        // header
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(0),
                                  backgroundColor: Colors.transparent,
                                ),
                                child: const ClipOval(
                                  child: Image(image: AssetImage('assets/upload/gary-final-space.jpg'), height: 50, width: 50, fit: BoxFit.cover),
                                ),
                              ),
                  
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(100.0)),
                                ),
                                alignment: Alignment.centerRight,
                                child: ButtonComponent(
                                  style: 'primary',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const HistoricoMensal(),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: TextComponent(
                                      text: Functions.fullMonthName(DateTime.now().month),
                                      style: 'subtitle',
                                    ),
                                  ),
                                ),
                              )
                            ]
                          ),
                        ),
                  
                        // body
                        FutureBuilder(
                          future: calculaTotal(),
                          builder: (context, snapshot) {
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(bottom: 8.0),
                                        child: const TextComponent(
                                          text: 'Gasto Mês',
                                          style: 'subtitle',
                                          color: Colors.white,
                                        ),
                                      ),
                                      Container(
                                        width: (MediaQuery.of(context).size.width / 2) - 24,
                                        margin: const EdgeInsets.only(bottom: 16.0),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 8.0,
                                              spreadRadius: 1.0,
                                              offset: Offset(-5, 5),
                                            )
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextComponent(text: Functions.toCurrency(gastoMes), style: 'title'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(bottom: 8.0),
                                        child: const TextComponent(
                                          text: 'Gasto Fíxo',
                                          style: 'subtitle',
                                          color: Colors.white,
                                          align:'right',
                                        ),
                                      ),
                                      Container(
                                        width: (MediaQuery.of(context).size.width / 2) - 24,
                                        margin: const EdgeInsets.only(bottom: 16.0),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 8.0,
                                              spreadRadius: 1.0,
                                              offset: Offset(-5, 5),
                                            )
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextComponent(text: Functions.toCurrency(gastoFixo), style: 'title'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]
                              ),
                            );
                          },
                        ),
                      ]
                    ),
                  ),
                  // list
                  Container(
                    margin: const EdgeInsets.only(top: 16.0, bottom: 76.0, left: 16.0, right: 16.0),
                    child: Builder(
                      builder: (context) {
                        if (lancamentos.isEmpty) {
                          return const Center(
                            child: TextComponent(text: 'Nenhum lançamento registrado', style: 'subtitle'),
                          );
                        }

                        return Column(
                          children: [
                            for (var lancamento in lancamentos)
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetalhesLancamento(lancamento: lancamento),
                                    ),
                                  );
                                },
                                onLongPress: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Opções'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ButtonComponent(
                                              style: 'primary',
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => DetalhesLancamento(lancamento: lancamento),
                                                  ),
                                                );
                                              },
                                              child: const TextComponent(
                                                text: 'Detalhes',
                                                style: 'subtitle',
                                              ),
                                            ),
                                            ButtonComponent(
                                              style: 'danger',
                                              onPressed: () {
                                                _gastoController.excluirCobranca(lancamento.idLancamento.toString());
                                                Navigator.pop(context);
                                                setState(() {});
                                              },
                                              child: const TextComponent(
                                                text: 'Excluir',
                                                style: 'subtitle',
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 16.0),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 8.0,
                                        spreadRadius: 1.0,
                                        offset: Offset(-5, 5),
                                      )
                                    ],
                                  ),
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            TextComponent(
                                              text: lancamento.descricao.length > 15 ? '${lancamento.descricao.substring(0, 15).toUpperCase()}...' : lancamento.descricao.toUpperCase(),
                                              style: 'subtitle'
                                            ),
                                          ]
                                        ),
                                        TextComponent(
                                          text: "${lancamento.tipo == Lancamento.receita ? "+" : "-"} ${Functions.toCurrency(lancamento.valor)}",
                                          color: lancamento.tipo == Lancamento.despesa ? AppColors.danger : AppColors.success,
                                        ),
                                      ]
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        );
                      }
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: const BottomMenu(),
      floatingActionButton: QuickActionMenu(
        onTap: () {},
        icon: Icons.menu,
        backgroundColor: AppColors.primary,
        actions: [
          QuickAction(
            icon: Icons.add,
            iconColor: Colors.white,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EntradaScreen()),
              );
            },
            backgroundColor: AppColors.success,
          ),
          QuickAction(
            icon: Icons.remove_outlined,
            iconColor: Colors.white,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SaidaScreen()),
              );
            },
            backgroundColor: AppColors.danger,
          ),
          QuickAction(
            icon: Icons.repeat,
            iconColor: Colors.white,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CobrancaRecorrenteScreen()),
              );
            },
            backgroundColor: AppColors.purple,
          ),
        ],
        child: const Icon(Icons.menu, color: Colors.white),
      ),
    );
  }
}