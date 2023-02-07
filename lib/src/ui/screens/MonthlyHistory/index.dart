

import 'package:finances/src/controllers/gasto_controller.dart';
import 'package:finances/src/core/app_colors.dart';
import 'package:finances/src/core/app_images.dart';
import 'package:finances/src/helpers/functions.dart';
import 'package:finances/src/ui/components/BottomMenu/index.dart';
import 'package:finances/src/ui/components/TextComponent/index.dart';
import 'package:flutter/material.dart';

class MonthlyHistory extends StatefulWidget {
  const MonthlyHistory({super.key});

  @override
  State<MonthlyHistory> createState() => _MonthlyHistoryState();
}

class _MonthlyHistoryState extends State<MonthlyHistory> {
  final GastoController _gastoController = GastoController();

  void loadHistorico() async {
    await _gastoController.getTransacoes();
  }
  
  @override
  void initState() {
    super.initState();

    loadHistorico();
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
                    // Visibility(
                    //   visible: historyCurrentYear != null && historyCurrentYear!.isNotEmpty,
                    //   child: ListView.builder(
                    //     shrinkWrap: true,
                    //     itemCount: historyCurrentYear!.length,
                    //     itemBuilder: (context, index) {
                    //       var month = historyCurrentYear?[index];

                    //       return Container(
                    //         width: (MediaQuery.of(context).size.width / 2) - 32,
                    //         margin: const EdgeInsets.only(bottom: 16.0, right: 16.0),
                    //         padding: const EdgeInsets.all(16.0),
                    //         decoration: BoxDecoration(
                    //           color: month?['monthNumber'] == DateTime.now().month ? AppColors.primary : Colors.white,
                    //           borderRadius: BorderRadius.circular(8.0),
                    //           boxShadow: [
                    //             BoxShadow(
                    //               color: AppColors.primary.withOpacity(0.25),
                    //               spreadRadius: 0,
                    //               blurRadius: 4,
                    //               offset: const Offset(0, 4), // changes position of shadow
                    //             ),
                    //           ],
                    //         ),
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.center,
                    //           children: [
                    //             TextComponent(
                    //               text: "Mês",
                    //               color: month?['monthNumber'] == DateTime.now().month ? Colors.white : Colors.black,
                    //             ),
                    //             TextComponent(
                    //               text: month?['month'],
                    //               style: 'subtitle',
                    //               color: month?['monthNumber'] == DateTime.now().month ? Colors.white : Colors.black,
                    //             ),
                    //           ],
                    //         ),
                    //       );
                    //     }
                    //   ),
                    // ),
                    Wrap(
                      children: [
                        for (var transacao in _gastoController.dataSourceTransacao)
                          Container(
                            width: (MediaQuery.of(context).size.width / 2) - 32,
                            margin: const EdgeInsets.only(bottom: 16.0, right: 16.0),
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: transacao.mesReferencia == DateTime.now().month ? AppColors.primary : Colors.white,
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
                                  color: transacao.mesReferencia == DateTime.now().month ? Colors.white : Colors.black,
                                ),
                                TextComponent(
                                  text: Functions.fullMonthName(int.tryParse(transacao.mesReferencia.toString())!),
                                  style: 'subtitle',
                                  color: transacao.mesReferencia == DateTime.now().month ? Colors.white : Colors.black,
                                ),
                              ],
                            ),
                          ),
                      ]
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