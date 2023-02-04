
import 'package:finances/src/core/app_colors.dart';
import 'package:finances/src/core/app_images.dart';
import 'package:finances/src/helpers/functions.dart';
import 'package:finances/src/mock/mockDataUser.dart';
import 'package:finances/src/data/models/card.dart' as card_model;
import 'package:finances/src/ui/components/BottomMenu/index.dart';
import 'package:finances/src/ui/components/Button/index.dart';
import 'package:finances/src/ui/components/TextComponent/index.dart';
import 'package:flutter/material.dart';

class CardDetails extends StatefulWidget {
  final card_model.Card card;
  const CardDetails({super.key, required this.card});

  @override
  State<CardDetails> createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> {
  var historyCurrentYear = history['${DateTime.now().year}'];
  
  var historyCurrentMonth;

  var historyDetails;

  double faturaTotal = 0;

  @override
  void initState() {
    super.initState();

    loadCurrentTransactions();

    if (historyDetails != null) {
      faturaTotal = historyDetails
        .where((element) => element.type == 'out' && element.cardId == widget.card.id)
        .fold(0, (previousValue, element) => previousValue + element.value);
    } else {
      faturaTotal = 0;
    }
  }
  
  void loadCurrentTransactions() {
    historyCurrentMonth = historyCurrentYear!.firstWhere((element) => element['monthNumber'] == DateTime.now().month, orElse: () => {});
    
    historyDetails = historyCurrentMonth != null ? historyCurrentMonth!['transactions'] : null;
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
                          Row(
                            children: [
                              TextComponent(
                                text: "Cartão - ",
                                size: 24.0,
                              ),
                              TextComponent(
                                text: widget.card.name.toString().toUpperCase(),
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
                    historyDetails == null
                    ? Container(
                      margin: const EdgeInsets.symmetric(vertical: 32.0),
                      alignment: Alignment.center,
                      child: TextComponent(
                        text: 'Ainda não há compras nesse cartão',
                      ),
                    )
                    : ListView.builder(
                      shrinkWrap: true,
                      itemCount: historyDetails.isNotEmpty ? historyDetails.length : 1,
                      itemBuilder: (BuildContext context, int index) {
                        var formattedValue = Functions.toCurrency(historyDetails[index].value);
          
                        if (historyDetails.isNotEmpty && historyDetails[index].cardId == widget.card.id) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextComponent(
                                text: historyDetails[index].description.toString(),
                              ),
                              TextComponent(
                                text: historyDetails[index].type == 'entry' ? "+ ${formattedValue.toString()}" : "- ${formattedValue.toString()}",
                                color: historyDetails[index].type == 'entry' ? AppColors.success : AppColors.danger,
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
                              text: widget.card.dueDay.toString(),
                            ),
                          ),
                          TextComponent(
                            text: 'Final ',
                            weigth: FontWeight.bold,
                          ),
                          TextComponent(
                            text: widget.card.finalNumber.toString(),
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