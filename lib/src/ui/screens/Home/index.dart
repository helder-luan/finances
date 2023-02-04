
import 'package:finances/src/core/app_colors.dart';
import 'package:finances/src/helpers/functions.dart';
import 'package:finances/src/mock/mockDataUser.dart';
import 'package:finances/src/ui/components/BottomMenu/index.dart';
import 'package:finances/src/ui/components/Button/index.dart';
import 'package:finances/src/ui/components/Card/index.dart';
import 'package:finances/src/ui/components/TextComponent/index.dart';
import 'package:finances/src/ui/screens/CardDetails/index.dart';
import 'package:finances/src/ui/screens/MonthlyHistory/index.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var historyCurrentYear = history['${DateTime.now().year}'];
  var historyCurrentMonth;
  var historyDetails;

  late double gastoTotal;
  late double dividaTotal;

  void loadCurrentTransactions() {
    historyCurrentMonth = historyCurrentYear!.firstWhere((element) => element['monthNumber'] == DateTime.now().month, orElse: () => {});
    
    historyDetails = historyCurrentMonth != null ? historyCurrentMonth!['transactions'] : null;
  }

  @override
  void initState() {
    super.initState();
    loadCurrentTransactions();

    if (historyDetails != null) {
      gastoTotal = historyDetails
        !.where((element) => element.type == 'out')
        .fold(0, (previousValue, element) => previousValue + element.value);

      dividaTotal = historyDetails
        !.where((element) => element.type == 'out' && element.monthlyExpense)
        .fold(0, (previousValue, element) => previousValue + element.value);
    } else {
      gastoTotal = 0;
      dividaTotal = 0;
    }
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
                              builder: (context) => const MonthlyHistory(),
                            ),
                          );
                        },
                        children: Padding(
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
                    Row(
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
                    ),
                    // cards
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: cards.length,
                      itemBuilder: (context, index) {
                        var card = cards[index];
                            
                        return CardComponent(
                          cardName: card.name.toString(),
                          cardNumVenc: card.dueDay.toString(),
                          cardNumFinal: card.finalNumber.toString(),
                          cardColor: Color(int.parse("0xFF${card.hexColor}")),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CardDetails(card: card),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ]
          ),
        ),
      ),
      bottomNavigationBar: const BottomMenu(),
    );
  }
}
