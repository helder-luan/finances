import 'package:flutter/material.dart';

abstract class AppColors {
  static const primary = Color(0xFF1400FF);

  static const gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF9600DD),
      Color(0xFF1400FF),
    ],
  );

  static const success = Color(0xFF00CD00);
  static const danger = Color(0xFFEC0000);
  static const purple = Color(0xFF9600DD);
  static const blue = Color(0xFF1400FF);
}
