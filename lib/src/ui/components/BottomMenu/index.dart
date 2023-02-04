import 'package:finances/src/core/app_images.dart';
import 'package:finances/src/ui/screens/Card/index.dart';
import 'package:finances/src/ui/screens/History/index.dart';
import 'package:finances/src/ui/screens/Home/index.dart';
import 'package:finances/src/ui/screens/Spending/index.dart';
import 'package:flutter/material.dart';

class BottomMenu extends StatelessWidget {
  const BottomMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        color: Color(0xFFFEFEFE),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8.0,
            spreadRadius: 1.0,
            offset: Offset(0, 0),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SpendingScreen(),
                  ),
                  (route) => false);
            },
            icon: Image(image: AssetImage(AppImages.gastos)),
            iconSize: 32,
          ),
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CardScreen(),
                  ),
                  (route) => false);
            },
            icon: Image(image: AssetImage(AppImages.cartao)),
            iconSize: 32,
          ),
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                  (route) => false);
            },
            icon: Image(image: AssetImage(AppImages.home)),
            iconSize: 32,
          ),
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HistoryScreen(),
                  ),
                  (route) => false);
            },
            icon: Image(image: AssetImage(AppImages.historico)),
            iconSize: 32,
          ),
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                  (route) => false);
            },
            icon: Image(image: AssetImage(AppImages.historicoMensal)),
            iconSize: 32,
          ),
        ],
      ),
    );
  }
}