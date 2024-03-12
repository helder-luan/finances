import 'package:finances/src/controllers/gasto_controller.dart';
import 'package:finances/src/controllers/mes_referencia_controller.dart';
import 'package:finances/src/core/app_colors.dart';
import 'package:finances/src/data/models/lancamento.dart';
import 'package:finances/src/helpers/functions.dart';
import 'package:finances/src/ui/components/BottomMenu/index.dart';
import 'package:finances/src/ui/components/Button/index.dart';
import 'package:finances/src/ui/components/TextComponent/index.dart';
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
      if (lancamento.tipo == Lancamento.despesa) {
        gastoMes += lancamento.valor;

        if (lancamento.recorrente == 'S') {
          gastoFixo += lancamento.valor;
        }
      } else {
        gastoMes -= lancamento.valor;
      }
    }
  }

  Future loadAll() async {
    await loadHistorico();

    await calculaTotal();
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
          future: loadAll(),
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
                                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
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
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
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
                                      const TextComponent(text: 'Gasto Mês', style: 'subtitle'),
                                      TextComponent(text: Functions.toCurrency(gastoMes), style: 'title'),
                                    ]
                                  ),
                                ),
                              ),
                              Container(
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
                                      const TextComponent(text: 'Gasto Fíxo', style: 'subtitle'),
                                      TextComponent(text: Functions.toCurrency(gastoFixo), style: 'title'),
                                    ]
                                  ),
                                ),
                              ),
                            ]
                          ),
                        ),
                      ]
                    ),
                  ),
                  // list
                  Container(
                    margin: const EdgeInsets.all(16.0),
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
                              Container(
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
                                          TextComponent(text: lancamento.descricao.toUpperCase(), style: 'subtitle'),
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
    );
  }
}
