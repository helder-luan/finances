import 'package:fingen/src/core/app_sizes.dart';
import 'package:fingen/src/theme/color_scheme.dart';
import 'package:flutter/material.dart';

class FinancesTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(
        backgroundColor: ColorSchemeCustom.primary,
        foregroundColor: ColorSchemeCustom.textHighlight
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder> {
          TargetPlatform.android:
            FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS:
            FadeUpwardsPageTransitionsBuilder()
        }
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontSize: AppSizes.textPrimary,
          color: ColorSchemeCustom.textPrimary
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: ColorSchemeCustom.primary,
        hintStyle: TextStyle(
          color: ColorSchemeCustom.secondary,
        ),
        labelStyle: TextStyle(
          color: ColorSchemeCustom.textPrimary,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorSchemeCustom.textHighlight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
      textButtonTheme: const TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(ColorSchemeCustom.textHighlight),
          backgroundColor: WidgetStatePropertyAll(Colors.transparent),
          textStyle: WidgetStatePropertyAll(TextStyle(
            fontSize: AppSizes.textPrimary,
            decoration: TextDecoration.underline
          )),
          padding: WidgetStatePropertyAll(EdgeInsets.all(0)),
        ),
      ),
      elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(ColorSchemeCustom.textHighlight),
          foregroundColor: WidgetStatePropertyAll(ColorSchemeCustom.primary),
          shadowColor: WidgetStatePropertyAll(ColorSchemeCustom.separator),
          textStyle: WidgetStatePropertyAll(TextStyle(
            fontSize: AppSizes.textPrimary,
            color: ColorSchemeCustom.primary
          )),
          padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 8, horizontal: 16)),
          side: WidgetStatePropertyAll(BorderSide.none),
          elevation: WidgetStatePropertyAll(5),
        ),
      ),
      outlinedButtonTheme: const OutlinedButtonThemeData(
        style: ButtonStyle(
          shadowColor: WidgetStatePropertyAll(ColorSchemeCustom.separator),
          textStyle: WidgetStatePropertyAll(TextStyle(
            fontSize: AppSizes.textPrimary,
            color: ColorSchemeCustom.textHighlight
          )),
          padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 8, horizontal: 16)),
          side: WidgetStatePropertyAll(BorderSide(
            color: ColorSchemeCustom.separator,
            width: 1
          )),
          elevation: WidgetStatePropertyAll(5)
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: ColorSchemeCustom.textPrimary,
        foregroundColor: ColorSchemeCustom.textHighlight
      )
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
        backgroundColor: ColorSchemeCustom.primary,
        foregroundColor: ColorSchemeCustom.textHighlight,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder> {
          TargetPlatform.android:
            FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS:
            FadeUpwardsPageTransitionsBuilder()
        }
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontSize: AppSizes.textPrimary,
          color: ColorSchemeCustom.textPrimary,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: ColorSchemeCustom.textHighlight,
        hintStyle: TextStyle(
          color: ColorSchemeCustom.textPrimary,
        ),
        labelStyle: TextStyle(
          color: ColorSchemeCustom.primary,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorSchemeCustom.primary,
          ),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
      textButtonTheme: const TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(ColorSchemeCustom.primary),
          backgroundColor: WidgetStatePropertyAll(Colors.transparent),
          textStyle: WidgetStatePropertyAll(TextStyle(
            fontSize: AppSizes.textPrimary,
            decoration: TextDecoration.underline
          )),
          padding: WidgetStatePropertyAll(EdgeInsets.all(0)),
        ),
      ),
      elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(ColorSchemeCustom.primary),
          foregroundColor: WidgetStatePropertyAll(ColorSchemeCustom.textHighlight),
          shadowColor: WidgetStatePropertyAll(ColorSchemeCustom.separator),
          textStyle: WidgetStatePropertyAll(TextStyle(
            fontSize: AppSizes.textPrimary,
            color: ColorSchemeCustom.primary
          )),
          padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 8, horizontal: 16)),
          side: WidgetStatePropertyAll(BorderSide.none),
          elevation: WidgetStatePropertyAll(5)
        ),
      ),
      outlinedButtonTheme: const OutlinedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(ColorSchemeCustom.primary),
          foregroundColor: WidgetStatePropertyAll(ColorSchemeCustom.textHighlight),
          shadowColor: WidgetStatePropertyAll(ColorSchemeCustom.separator),
          textStyle: WidgetStatePropertyAll(TextStyle(
            fontSize: AppSizes.textPrimary,
            color: ColorSchemeCustom.textHighlight
          )),
          padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 8, horizontal: 16)),
          side: WidgetStatePropertyAll(BorderSide(
            color: ColorSchemeCustom.separator,
            width: 1,
          )),
          elevation: WidgetStatePropertyAll(5),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: ColorSchemeCustom.textPrimary,
        backgroundColor: ColorSchemeCustom.textHighlight
      )
    );
  }
}