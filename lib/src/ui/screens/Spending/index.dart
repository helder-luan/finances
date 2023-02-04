import 'package:finances/src/core/app_colors.dart';
import 'package:finances/src/core/app_images.dart';
import 'package:finances/src/ui/components/BottomMenu/index.dart';
import 'package:finances/src/ui/components/Button/index.dart';
import 'package:finances/src/ui/components/TextComponent/index.dart';
import 'package:finances/src/ui/screens/Spending/SpendingFlow/EntryScreen/index.dart';
import 'package:finances/src/ui/screens/Spending/SpendingFlow/OutScreen/index.dart';
import 'package:flutter/material.dart';

class SpendingScreen extends StatefulWidget {
  const SpendingScreen({super.key});

  @override
  State<SpendingScreen> createState() => _SpendingScreenState();
}

class _SpendingScreenState extends State<SpendingScreen> {
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
                  height: MediaQuery.of(context).size.height,
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
                            child: TextComponent(text: 'Gerenciar Gastos', style: 'title'),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Image(image: AssetImage(AppImages.voltar)),
                            iconSize: 16,
                          )
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 16.0),
                        child: TextComponent(text: 'Cadastrar', style: 'subtitle'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 35.0,
                            width: (MediaQuery.of(context).size.width-32)/2,
                            child: ButtonComponent(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const EntryScreen()),
                                );
                              },
                              style: 'success',
                              children: TextComponent(text: 'Entrada', color: Colors.white, weigth: FontWeight.bold,)
                            ),
                          ),
                          SizedBox(
                            height: 35.0,
                            width: (MediaQuery.of(context).size.width-48)/2,
                            child: ButtonComponent(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const OutScreen()),
                                );
                              },
                              style: 'danger',
                              children: TextComponent(text: 'Saída', color: Colors.white, weigth: FontWeight.bold,)
                            ),
                          ),
                        ],
                      ),
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