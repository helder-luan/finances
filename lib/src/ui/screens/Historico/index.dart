
import 'package:finances/src/controllers/gasto_controller.dart';
import 'package:finances/src/controllers/tipo_operacao_controller.dart';
import 'package:finances/src/core/app_colors.dart';
import 'package:finances/src/helpers/functions.dart';
import 'package:finances/src/ui/components/BottomMenu/index.dart';
import 'package:finances/src/ui/components/TextComponent/index.dart';
import 'package:flutter/material.dart';

class HistoricoScreen extends StatefulWidget {
  const HistoricoScreen({super.key});

  @override
  State<HistoricoScreen> createState() => _HistoricoScreenState();
}

class _HistoricoScreenState extends State<HistoricoScreen> {
  final GastoController _gastoController = GastoController();
  final TipoOperacaoController _tipoOperacaoController = TipoOperacaoController();

  List<Map<String, dynamic>> historico = [];

  Future loadTipoOperacao() async {
    await _tipoOperacaoController.getTiposOperacao();
  }

  Future loadHistorico() async {
    historico = await _gastoController.getTransacoesMesAtual();
  }

  Future loadAll() async {
    await loadTipoOperacao();
    await loadHistorico();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loadAll(),
        builder: (context, snapshot) {
          return SingleChildScrollView(
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
                        TextComponent(
                          text: Functions.fullMonthName(DateTime.now().month),
                          style: 'subtitle',
                        ),
                        Visibility(
                          visible: historico.isEmpty,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 32.0),
                            alignment: Alignment.center,
                            child: TextComponent(
                              text: 'Ainda não há transações',
                            ),
                          )
                        ),
                        Visibility(
                          visible: historico.isNotEmpty,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: historico.isNotEmpty ? historico.length : 1,
                            itemBuilder: (BuildContext context, int index) {
                              var valor = double.tryParse("${historico[index]['valor'].toString().substring(0, historico[index]['valor'].toString().length - 2)}.${historico[index]['valor'].toString().substring(historico[index]['valor'].toString().length - 2, historico[index]['valor'].toString().length)}".replaceAll("R\$ ", ""));
                              
                              var valorFormatado = Functions.toCurrency(valor!);

                              bool entrada = false;

                              if (
                                historico[index]['idTipoOperacao'] == _tipoOperacaoController.dataSourceTipoOperacao.first.idTipoOperacao
                                &&
                                _tipoOperacaoController.dataSourceTipoOperacao.first.descricao == 'Entrada'
                              ) {
                                entrada = true;
                              }
                        
                              if (historico.isNotEmpty) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextComponent(
                                      text: historico[index]['descricao'],
                                    ),
                                    TextComponent(
                                      text: entrada ? "+ ${valorFormatado.toString()}" : "- ${valorFormatado.toString()}",
                                      color: entrada ? AppColors.success : AppColors.danger,
                                    ),
                                  ],
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                        )
                      ],
                    )
                  )
                ],
              )
            ),
          );
        },
      ),
      bottomNavigationBar: const BottomMenu(),
    );
  }
}