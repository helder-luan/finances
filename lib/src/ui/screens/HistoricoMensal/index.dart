

import 'package:finances/src/controllers/gasto_controller.dart';
import 'package:finances/src/core/app_colors.dart';
import 'package:finances/src/core/app_images.dart';
import 'package:finances/src/data/models/transacao.dart';
import 'package:finances/src/helpers/functions.dart';
import 'package:finances/src/ui/components/BottomMenu/index.dart';
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

  Map<String, List<Transacao>> transacoes = {};

  Future loadHistorico() async {
    await _gastoController.getTransacoes();

    ordenaPorMes();
  }

  void ordenaPorMes() {
    _gastoController.dataSourceTransacao.sort((a, b) => a.mesReferencia!.compareTo(b.mesReferencia!));

    
    for(var transacao in _gastoController.dataSourceTransacao) {
      if (transacoes.containsKey(transacao.mesReferencia.toString())) {
        transacoes[transacao.mesReferencia.toString()]?.add(transacao);
      } else {
        transacoes[transacao.mesReferencia.toString()] = [transacao];
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
      body: SingleChildScrollView(
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextComponent(
                            text: "Histórico Dos Meses",
                            style: 'title',
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Image(image: AssetImage(AppImages.voltar)),
                            iconSize: 16,
                          )
                        ],
                      )
                    ),
                    FutureBuilder(
                      future: loadHistorico(),
                      builder: (context, snapshot) {
                        return Wrap(
                          children: [
                            for (var mesReferencia in transacoes.keys)
                              Container(
                                width: (MediaQuery.of(context).size.width / 2) - 32,
                                margin: const EdgeInsets.only(bottom: 16.0, right: 16.0),
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: int.parse(mesReferencia) == DateTime.now().month ? AppColors.primary : Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primary.withOpacity(0.25),
                                      spreadRadius: 0,
                                      blurRadius: 4,
                                      offset: const Offset(0, 4), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextComponent(
                                      text: "Mês",
                                      color: int.parse(mesReferencia) == DateTime.now().month ? Colors.white : Colors.black,
                                    ),
                                    TextComponent(
                                      text: Functions.fullMonthName(int.parse(mesReferencia.toString())),
                                      style: 'subtitle',
                                      color: int.parse(mesReferencia) == DateTime.now().month ? Colors.white : Colors.black,
                                    ),
                                  ],
                                ),
                              )
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
      bottomNavigationBar: const BottomMenu(),
    );
  }
}