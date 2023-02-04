import 'package:finances/src/core/app_colors.dart';
import 'package:finances/src/core/app_images.dart';
import 'package:finances/src/mock/mockDataUser.dart';
import 'package:finances/src/ui/components/BottomMenu/index.dart';
import 'package:finances/src/ui/components/Button/index.dart';
import 'package:finances/src/ui/components/MyCard/index.dart';
import 'package:finances/src/ui/components/TextComponent/index.dart';
import 'package:finances/src/ui/screens/Home/index.dart';
import 'package:finances/src/ui/screens/RegisterCard/index.dart';
import 'package:flutter/material.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({
    super.key
  });

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  var _formKey;

  List<Map<dynamic, String>> formPayment = [
    {'value': '1', 'label': 'Dinheiro'},
    {'value': '2', 'label': 'Cartão de débito'},
    {'value': '3', 'label': 'Cartão de crédito'},
  ];

  List<Map<dynamic, String>> myCards = [
    {'value': '1', 'label': 'Cartão 1'},
    {'value': '2', 'label': 'Cartão 2'},
    {'value': '3', 'label': 'Cartão 3'}
  ];

  var formPaymentChoice = '1';
  var cardChoice = '1';

  var monthlyExpense = false;

  var installments = false;
  var cardInstallments = '1';

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 24.0),
                            child: TextComponent(
                              text: 'Cartões',
                              style: 'title',
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                                (route) => false,
                              );
                            },
                            icon: Image(image: AssetImage(AppImages.voltar)),
                            iconSize: 16,
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RefreshIndicator(
                            onRefresh: () async {
                              setState(() {});
                            },
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: cards.length,
                              itemBuilder: (context, index) {
                                var card = cards[index];
                          
                                return MyCardComponent(card: card);
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 16.0),
                            width: MediaQuery.of(context).size.width-32,
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
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterCardScreen(),
                                  )
                                );
                              },
                              children: TextComponent(
                                text: 'Adicionar',
                                weigth: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
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