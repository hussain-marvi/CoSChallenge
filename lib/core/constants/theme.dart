import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primaryColor,
      primaryColorDark: AppColors.secondaryColor,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryColor,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      primaryTextTheme: Typography().white,
      textTheme: Typography().white,
      textSelectionTheme:
          const TextSelectionThemeData(cursorColor: AppColors.secondaryColor),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondaryColor,
          textStyle: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.secondaryColor,
            width: 2.0,
          ),
        ),
        hintStyle: const TextStyle(
          color: AppColors.secondaryColor,
        ),
        labelStyle: const TextStyle(
          color: AppColors.secondaryColor,
        ),
      ),
    );
  }
}
