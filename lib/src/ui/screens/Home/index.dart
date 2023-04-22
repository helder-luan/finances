
import 'package:finances/src/controllers/cartao_controller.dart';
import 'package:finances/src/controllers/gasto_controller.dart';
import 'package:finances/src/controllers/mes_referencia_controller.dart';
import 'package:finances/src/controllers/tipo_operacao_controller.dart';
import 'package:finances/src/core/app_colors.dart';
import 'package:finances/src/data/models/tipo_operacao_model.dart';
import 'package:finances/src/data/models/transacao.dart';
import 'package:finances/src/helpers/functions.dart';
import 'package:finances/src/ui/components/BottomMenu/index.dart';
import 'package:finances/src/ui/components/Button/index.dart';
import 'package:finances/src/ui/components/Cartao/index.dart';
import 'package:finances/src/ui/components/TextComponent/index.dart';
import 'package:finances/src/ui/screens/DetalhesCartao/index.dart';
import 'package:finances/src/ui/screens/HistoricoMensal/index.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GastoController _gastoController = GastoController();
  final TipoOperacaoController _tipoOperacaoController = TipoOperacaoController();
  final CartaoController _cartaoController = CartaoController();
  final MesReferenciaController _mesReferenciaController = MesReferenciaController();

  List<Transacao> historico = [];

  double gastoTotal = 0.0;
  double dividaTotal = 0.0;

  Future<void> loadCartoes() async {
    await _cartaoController.atualizarDados();
  }

  Future<void> loadTipoOperacao() async {
    await _tipoOperacaoController.getTiposOperacao();
  }

  Future<void> loadHistorico() async {
    await _gastoController.getTransacoes();

    historico = _gastoController.dataSourceTransacao;
    
    calculaGastos();
  }

  void calculaGastos() {
    TipoOperacao saida = _tipoOperacaoController.dataSourceTipoOperacao.firstWhere((element) => element.descricao == 'Saída');

    if (historico.isNotEmpty) {
      gastoTotal = historico.where(
        (transacao) => 
          (transacao.idTipoOperacao == saida.idTipoOperacao || transacao.gastoMensal == 1)
          &&
          transacao.mesReferencia == _mesReferenciaController.current
      )
      .fold(
        0,
        (double previousValue, transacao) {
          if (transacao.parcelado == 1) {
            return previousValue + (transacao.valor! / transacao.totalParcelas!);
          } else if (transacao.reembolso == 1) {
            return previousValue - transacao.valor!;
          } else {
            return previousValue + transacao.valor!;
          }
        },
      );

      dividaTotal = historico.where(
        (transacao) =>
          transacao.idTipoOperacao == saida.idTipoOperacao
          &&
          (transacao.gastoMensal == 1 || transacao.parcelado == 1)
          &&
          transacao.mesReferencia == _mesReferenciaController.current
      )
      .fold(
        0,
        (previousValue, transacao) =>
          transacao.parcelado == 1 ? previousValue + (transacao.valor! / transacao.totalParcelas!) : previousValue + transacao.valor!,
      );
    } else {
      gastoTotal = 0;
      dividaTotal = 0;
    }
  }

  Future loadAll() async {
    await loadCartoes();
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
      body: SafeArea(
        child: FutureBuilder(
          future: loadAll(),
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Container(
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
                            width: (MediaQuery.of(context).size.width-64)/2,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            ),
                            alignment: Alignment.centerRight,
                            child: ButtonComponent(
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        TextComponent(
                                          text: 'Mês'
                                        ),
                                        TextComponent(
                                          text: Functions.fullMonthName(DateTime.now().month),
                                          style: 'title',
                                        ),
                                      ]
                                    )
                                  ],
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
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
                      ),
                      child: Column(
                        children: [
                          FutureBuilder(
                            future: loadAll(),
                            builder: (context, snapshot) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: (MediaQuery.of(context).size.width-64)/2,
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
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          TextComponent(text: 'Gasto total'),
                                          TextComponent(text: Functions.toCurrency(gastoTotal), style: 'title'),
                                        ]
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: (MediaQuery.of(context).size.width-64)/2,
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
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          TextComponent(text: 'Dívida total'),
                                          TextComponent(text: Functions.toCurrency(dividaTotal), style: 'title'),
                                        ]
                                      ),
                                    ),
                                  ),
                                ]
                              );
                            },
                          ),
                          // cards
                          Container(
                            margin: const EdgeInsets.only(top: 16.0),
                            child: FutureBuilder(
                              future: loadAll(),
                              builder: (context, snapshot) {
                                if (_cartaoController.dataSourceCartao.isNotEmpty) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: _cartaoController.dataSourceCartao.length,
                                    itemBuilder: (context, index) {
                                      var cartao = _cartaoController.dataSourceCartao[index];
                                          
                                      return CartaoComponent(
                                        cardName: cartao.nome.toString(),
                                        cardNumVenc: cartao.diaVencimento.toString(),
                                        cardNumFinal: cartao.finalCartao.toString(),
                                        cardColor: Color(int.tryParse("0xFF${cartao.hexCor}")!),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => DetalhesCartao(cartao: cartao),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                } else {
                                  return Container(
                                    margin: const EdgeInsets.only(top: 32.0),
                                    child: Center(
                                      child: TextComponent(text: 'Nenhum cartão cadastrado'),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: const BottomMenu(),
    );
  }
}
