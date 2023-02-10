
import 'package:finances/src/controllers/gasto_controller.dart';
import 'package:finances/src/core/app_colors.dart';
import 'package:finances/src/core/app_images.dart';
import 'package:finances/src/helpers/functions.dart';
import 'package:finances/src/data/models/cartao.dart';
import 'package:finances/src/ui/components/BottomMenu/index.dart';
import 'package:finances/src/ui/components/Button/index.dart';
import 'package:finances/src/ui/components/TextComponent/index.dart';
import 'package:flutter/material.dart';

class DetalhesCartao extends StatefulWidget {
  final Cartao cartao;
  const DetalhesCartao({super.key, required this.cartao});

  @override
  State<DetalhesCartao> createState() => _DetalhesCartaoState();
}

class _DetalhesCartaoState extends State<DetalhesCartao> {
  final GastoController _gastoController = GastoController();
  
  List<Map<String, dynamic>> historico = [];

  double faturaTotal = 0;

  Future loadHistorico() async {
    historico = await _gastoController.getTransacoesMesAtualECartao();
  }

  void calculaValorFatura() {
    for (var element in historico) {
      faturaTotal += element['valor'];
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loadHistorico().then((value) => print(historico)),
        builder: (context, snapshot) {
          if (historico.isNotEmpty) {
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    TextComponent(
                                      text: "Cartão - ",
                                      size: 24.0,
                                    ),
                                    TextComponent(
                                      text: widget.cartao.nome.toString().toUpperCase(),
                                      weigth: FontWeight.bold,
                                      size: 24.0,
                                    ),
                                  ],
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
                          Container(
                            alignment: Alignment.center,
                            child: TextComponent(
                              text: Functions.fullMonthName(DateTime.now().month),
                              style: 'subtitle',
                            ),
                          ),
                          historico.isNotEmpty
                          ? Container(
                            margin: const EdgeInsets.symmetric(vertical: 32.0),
                            alignment: Alignment.center,
                            child: TextComponent(
                              text: 'Ainda não há compras nesse cartão',
                            ),
                          )
                          : ListView.builder(
                            shrinkWrap: true,
                            itemCount: historico.isNotEmpty ? historico.length : 1,
                            itemBuilder: (BuildContext context, int index) {
                              var formattedValue = Functions.toCurrency(historico[index]['valor']);
                
                              if (historico.isNotEmpty && historico[index]['idCartao'] == widget.cartao.idCartao) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextComponent(
                                      text: historico[index]['descricao'].toString(),
                                    ),
                                    TextComponent(
                                      text: historico[index]['type'] == 'entry' ? "+ ${formattedValue.toString()}" : "- ${formattedValue.toString()}",
                                      color: historico[index]['type'] == 'entry' ? AppColors.success : AppColors.danger,
                                    ),
                                  ],
                                );
                              } else {
                                return Container();
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextComponent(
                                text: 'Valor da Fatura: ',
                                weigth: FontWeight.bold,
                              ),
                              TextComponent(
                                text: Functions.toCurrency(faturaTotal),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextComponent(
                                  text: 'Venc. ',
                                  weigth: FontWeight.bold,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 8.0),
                                  child: TextComponent(
                                    text: widget.cartao.diaVencimento.toString(),
                                  ),
                                ),
                                TextComponent(
                                  text: 'Final ',
                                  weigth: FontWeight.bold,
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
            );
          } else {
            return Container(
              margin: const EdgeInsets.only(top: 32.0),
              child: Center(
                child: TextComponent(text: 'Não há histórico ainda'),
              ),
            );
          }
        },
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
            weigth: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: const BottomMenu(),
    );
  }
}