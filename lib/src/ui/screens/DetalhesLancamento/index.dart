import 'package:finances/src/core/app_colors.dart';
import 'package:finances/src/data/models/lancamento.dart';
import 'package:finances/src/helpers/functions.dart';
import 'package:finances/src/ui/components/BottomMenu/index.dart';
import 'package:finances/src/ui/components/TextComponent/index.dart';
import 'package:flutter/material.dart';

class DetalhesLancamento extends StatefulWidget {
  final Lancamento lancamento;
  const DetalhesLancamento({super.key, required this.lancamento});

  @override
  State<DetalhesLancamento> createState() => _DetalhesLancamentoState();
}

class _DetalhesLancamentoState extends State<DetalhesLancamento> {
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
                child: Builder(
                  builder: (context) {                    
                    String textoValorFormatado = "${widget.lancamento.tipo == 'R' ? "+" : "-"} ${widget.lancamento.valor}";
                
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 8.0),
                          child: TextComponent(
                            text: 'Detalhes da Transação',
                            style: 'title',
                          ),
                        ),
                        TextComponent(
                          text: "Data: ${Functions.formataData(widget.lancamento.created_at.toString())}",
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
                                text: widget.lancamento.descricao.toString(),
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
                                text: textoValorFormatado,
                                color: widget.lancamento.tipo == 'R' ? AppColors.success : AppColors.danger,
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
                                text: widget.lancamento.detalhes.toString().isEmpty ? "Nenhum detalhe adicionado" : '"${widget.lancamento.detalhes.toString()}"',
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
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