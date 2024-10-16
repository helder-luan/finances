import 'package:fingen/src/core/app_images.dart';
import 'package:fingen/src/ui/screens/Home/index.dart';
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
            onPressed: () {},
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
                (route) => false
              );
            },
            icon: Image(image: AssetImage(AppImages.home)),
            iconSize: 32,
          ),
          IconButton(
            onPressed: () {},
            icon: Image(image: AssetImage(AppImages.historicoMensal)),
            iconSize: 32,
          ),
        ],
      ),
    );
  }
}