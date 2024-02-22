import 'package:finances/src/controllers/gasto_controller.dart';
import 'package:finances/src/core/app_colors.dart';
import 'package:finances/src/data/models/lancamento.dart';
import 'package:finances/src/ui/components/BottomMenu/index.dart';
import 'package:finances/src/ui/components/CardMes/index.dart';
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

  Map<String, List<Lancamento>> lancamentos = {};

  Future loadHistorico() async {
    //
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
                          text: "Histórico Dos Meses",
                          style: 'title',
                        ),
                      ),
                      FutureBuilder(
                        future: loadHistorico(),
                        builder: (context, snapshot) {
                          return Wrap(
                            children: [
                              for (var mesReferencia in lancamentos.keys)
                                CardMes(mesReferencia: mesReferencia),
                            ]
                          );
                        },
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