
import 'package:finances/src/controllers/fatura_controller.dart';
import 'package:finances/src/controllers/gasto_controller.dart';
import 'package:finances/src/controllers/mes_referencia_controller.dart';
import 'package:finances/src/controllers/tipo_operacao_controller.dart';
import 'package:finances/src/core/app_colors.dart';
import 'package:finances/src/data/models/tipo_operacao_model.dart';
import 'package:finances/src/data/models/transacao.dart';
import 'package:finances/src/helpers/functions.dart';
import 'package:finances/src/data/models/cartao.dart';
import 'package:finances/src/ui/components/BottomMenu/index.dart';
import 'package:finances/src/ui/components/Button/index.dart';
import 'package:finances/src/ui/components/TextComponent/index.dart';
import 'package:finances/src/ui/screens/DetalhesTransacao/index.dart';
import 'package:flutter/material.dart';

class DetalhesCartao extends StatefulWidget {
  final Cartao cartao;
  const DetalhesCartao({super.key, required this.cartao});

  @override
  State<DetalhesCartao> createState() => _DetalhesCartaoState();
}

class _DetalhesCartaoState extends State<DetalhesCartao> {
  final GastoController _gastoController = GastoController();
  final FaturaController _faturaController = FaturaController();
  final TipoOperacaoController _tipoOperacaoController = TipoOperacaoController();
  final MesReferenciaController _mesReferenciaController = MesReferenciaController();

  List<Transacao> historico = [];

  double? faturaTotal = 0;

  Future loadHistorico() async {
    await _gastoController.getTransacoesMesAtualECartao(widget.cartao.idCartao.toString());

    historico = _gastoController.dataSourceTransacao;
  }

  Future loadTipoOperacao() async {
    await _tipoOperacaoController.getTiposOperacao();
  }

  Future loadAll() async {
    await loadHistorico();
    await loadTipoOperacao();
    await calculaValorFatura();
  }

  Future<void> calculaValorFatura() async {
    _faturaController
      .verificaSeExisteFaturaMesAtualDoCartao(widget.cartao.idCartao.toString(), _mesReferenciaController.current.toString())
      .then((value) {
        if (value != null) {
          faturaTotal = value.valorTotal;
        }
      });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
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
                        children: [
                          TextComponent(
                            text: "Cartão - ",
                            size: 24.0,
                          ),
                          TextComponent(
                            text: widget.cartao.nome.toString().toUpperCase(),
                            weight: FontWeight.bold,
                            size: 24.0,
                          ),
                        ],
                      )
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: TextComponent(
                        text: Functions.fullMonthName(DateTime.now().month),
                        style: 'subtitle',
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
                              text: 'Ainda não há compras nesse cartão',
                            ),
                          );
                        } else {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: historico.isNotEmpty ? historico.length : 1,
                            itemBuilder: (BuildContext context, int index) {
                              Transacao transacao = historico[index];

                              double valor = transacao.valor!;

                              bool parcelado = transacao.parcelado == 1 ? true : false;

                              if (parcelado) {
                                valor = valor / int.parse(transacao.totalParcelas.toString());
                              }

                              String valorFormatado = Functions.toCurrency(valor);

                              TipoOperacao entrada = _tipoOperacaoController.dataSourceTipoOperacao.where((element) => element.descricao == 'Entrada').first;

                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetalhesTransacao(transacao: transacao),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextComponent(
                                      text: transacao.descricao.toString(),
                                    ),
                                    TextComponent(
                                      text: "${parcelado ? "${transacao.parcelaAtual}/${transacao.totalParcelas}" : ""} ${transacao.idTipoOperacao == entrada.idTipoOperacao ? "+ ${valorFormatado.toString()}" : "- ${valorFormatado.toString()}"}",
                                      color: transacao.idTipoOperacao == entrada.idTipoOperacao ? AppColors.success : AppColors.danger,
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: const Divider(
                          color: AppColors.primary,
                          thickness: 2,
                        ),
                      ),
                    ),
                    FutureBuilder(
                      future: calculaValorFatura(),
                      builder: (context, snapshot) {
                        String valorFatura = Functions.toCurrency(faturaTotal!);

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextComponent(
                              text: 'Valor da Fatura: ',
                              weight: FontWeight.bold,
                            ),
                            TextComponent(
                              text: valorFatura,
                            ),
                          ],
                        );
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextComponent(
                            text: 'Venc. ',
                            weight: FontWeight.bold,
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 8.0),
                            child: TextComponent(
                              text: widget.cartao.diaVencimento.toString().padLeft(2, '0'),
                            ),
                          ),
                          TextComponent(
                            text: 'Final ',
                            weight: FontWeight.bold,
                          ),
                          TextComponent(
                            text: widget.cartao.finalCartao.toString(),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              )
            ],
          )
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(top: 16.0),
        width: MediaQuery.of(context).size.width * 0.6,
        decoration: BoxDecoration(
          gradient: AppColors.gradient,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 1,
              blurRadius: 8,
              offset: Offset(0, 4), // changes position of shadow
            ),
          ],
        ),
        child: ButtonComponent(
          onPressed: () {},
          children: TextComponent(
            text: 'Pagar fatura',
            weight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: const BottomMenu(),
    );
  }
}