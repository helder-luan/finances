
import 'package:finances/src/controllers/gasto_controller.dart';
import 'package:finances/src/controllers/mes_referencia_controller.dart';
import 'package:finances/src/controllers/tipo_operacao_controller.dart';
import 'package:finances/src/core/app_colors.dart';
import 'package:finances/src/data/models/tipo_operacao_model.dart';
import 'package:finances/src/data/models/transacao.dart';
import 'package:finances/src/helpers/functions.dart';
import 'package:finances/src/ui/components/BottomMenu/index.dart';
import 'package:finances/src/ui/components/TextComponent/index.dart';
import 'package:finances/src/ui/screens/DetalhesTransacao/index.dart';
import 'package:flutter/material.dart';

class HistoricoScreen extends StatefulWidget {
  const HistoricoScreen({super.key});

  @override
  State<HistoricoScreen> createState() => _HistoricoScreenState();
}

class _HistoricoScreenState extends State<HistoricoScreen> {
  final GastoController _gastoController = GastoController();
  final TipoOperacaoController _tipoOperacaoController = TipoOperacaoController();
  final MesReferenciaController _mesReferenciaController = MesReferenciaController();

  List<Transacao> historico = [];

  Future<void> loadTipoOperacao() async {
    await _tipoOperacaoController.getTiposOperacao();
  }

  Future<void> loadHistorico() async {
    await _gastoController.getTransacoesMesAtual(_mesReferenciaController.current);

    historico = _gastoController.dataSourceTransacao;
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
                      child: TextComponent(
                        text: 'Histórico',
                        style: 'title',
                      ),
                    ),
                    TextComponent(
                      text: Functions.fullMonthName(DateTime.now().month),
                      style: 'subtitle',
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
                              Transacao transacao = historico[index];

                              double valor = transacao.valor!;

                              bool parcelado = transacao.parcelado == 1 ? true : false;

                              if (parcelado) {
                                valor = valor / transacao.totalParcelas!;
                              }
                              
                              String valorFormatado = Functions.toCurrency(valor);

                              TipoOperacao entrada = _tipoOperacaoController.dataSourceTipoOperacao.where((element) => element.descricao == 'Entrada').first;
                          
                              if (historico.isNotEmpty) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetalhesTransacao(transacao: transacao),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextComponent(
                                          text: transacao.descricao.toString().length > 20 ? '${transacao.descricao.toString().substring(0, 20).toUpperCase()}...' : transacao.descricao.toString().toUpperCase(),
                                        ),
                                        TextComponent(
                                          text: "${parcelado ? "${transacao.parcelaAtual}/${transacao.totalParcelas}" : ""} ${transacao.idTipoOperacao == entrada.idTipoOperacao ? "+ ${valorFormatado.toString()}" : "- ${valorFormatado.toString()}"}",
                                          color: transacao.idTipoOperacao == entrada.idTipoOperacao ? AppColors.success : AppColors.danger,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
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
        
      bottomNavigationBar: const BottomMenu(),
    );
  }
}