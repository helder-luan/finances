
import 'package:finances/src/controllers/tipo_operacao_controller.dart';
import 'package:finances/src/core/app_colors.dart';
import 'package:finances/src/data/models/tipo_operacao_model.dart';
import 'package:finances/src/data/models/transacao.dart';
import 'package:finances/src/helpers/functions.dart';
import 'package:finances/src/ui/components/BottomMenu/index.dart';
import 'package:finances/src/ui/components/TextComponent/index.dart';
import 'package:flutter/material.dart';

class DetalhesTransacao extends StatefulWidget {
  Transacao transacao;
  DetalhesTransacao({super.key, required this.transacao});

  @override
  State<DetalhesTransacao> createState() => _DetalhesTransacaoState();
}

class _DetalhesTransacaoState extends State<DetalhesTransacao> {
  final TipoOperacaoController _tipoOperacaoController = TipoOperacaoController();

  TipoOperacao? entrada;

  Future<void> loadTipoOperacao() async {
    await _tipoOperacaoController.getTiposOperacao().then((value) {
      entrada = _tipoOperacaoController.dataSourceTipoOperacao.firstWhere((element) => element.descricao == "Entrada");
    },);
  }

  Future loadAll() async {
    await loadTipoOperacao();
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
                child: FutureBuilder(
                  future: loadAll(),
                  builder: (context, snapshot) {
                    bool parcelado = widget.transacao.parcelado == 1 ? true : false;

                    double valor = widget.transacao.valor!;

                    if (parcelado) {
                      valor = valor / int.parse(widget.transacao.totalParcelas.toString());
                    }
                    
                    String valorFormatado = Functions.toCurrency(valor);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 16.0),
                          child: TextComponent(
                            text: 'Detalhes da Transação',
                            style: 'title',
                          ),
                        ),
                        TextComponent(
                          text: Functions.formataData(widget.transacao.dataCadastro.toString()),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextComponent(
                                text: 'Descrição',
                                weight: FontWeight.w600,
                                size: 20,
                              ),
                              TextComponent(
                                text: widget.transacao.descricao.toString(),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextComponent(
                                text: 'Valor',
                                weight: FontWeight.w600,
                                size: 20,
                              ),
                              TextComponent(
                                text: "${parcelado ? "${widget.transacao.parcelaAtual}/${widget.transacao.totalParcelas}" : ""} ${widget.transacao.idTipoOperacao == entrada!.idTipoOperacao ? "+ ${valorFormatado.toString()}" : "- ${valorFormatado.toString()}"}",
                                color: widget.transacao.idTipoOperacao == entrada!.idTipoOperacao ? AppColors.success : AppColors.danger,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextComponent(
                                text: 'Detalhes',
                                weight: FontWeight.w600,
                                size: 20,
                              ),
                              TextComponent(
                                text: widget.transacao.detalhes.toString() != " " ? "Nenhum detalhe adicionado" : widget.transacao.detalhes.toString(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
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