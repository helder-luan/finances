
import 'package:finances/src/core/app_colors.dart';
import 'package:finances/src/helpers/functions.dart';
import 'package:finances/src/mock/mockDataUser.dart';
import 'package:finances/src/ui/components/BottomMenu/index.dart';
import 'package:finances/src/ui/components/TextComponent/index.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  var historyCurrentYear = history['${DateTime.now().year}'];
  
  var historyCurrentMonth;

  var historyDetails;

  @override
  void initState() {
    super.initState();

    loadCurrentTransactions();
  }
  
  void loadCurrentTransactions() {
    historyCurrentMonth = historyCurrentYear!.firstWhere((element) => element['monthNumber'] == DateTime.now().month, orElse: () => {});
    
    historyDetails = historyCurrentMonth != null ? historyCurrentMonth!['transactions'] : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              loadCurrentTransactions();
            });
          },
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
                        visible: historyDetails == null,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 32.0),
                          alignment: Alignment.center,
                          child: TextComponent(
                            text: 'Ainda não há transações',
                          ),
                        )
                      ),
                      Visibility(
                        visible: historyDetails != null,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: historyDetails != null ? historyDetails.length : 1,
                          itemBuilder: (BuildContext context, int index) {
                            var formattedValue = Functions.toCurrency(historyDetails[index].value);
                      
                            if (historyDetails != null) {
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
                      )
                    ],
                  )
                )
              ],
            )
          ),
        ),
      ),
      bottomNavigationBar: const BottomMenu(),
    );
  }
}