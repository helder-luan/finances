import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF1400FF);

  static const gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.centerRight,
    colors: [
      AppColors.lightblue,
      AppColors.blue,
    ],
  );

  static const success = Color(0xFF00CD00);
  static const danger = Color(0xFFEC0000);
  static const purple = Color(0xFF9600DD);
  static const blue = Color(0xFF1400FF);
  static const lightblue = Color.fromARGB(255, 0, 238, 255);
}
