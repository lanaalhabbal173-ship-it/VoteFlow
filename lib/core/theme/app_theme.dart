import 'package:flutter/material.dart';
import '../colors/app_colors.dart';


class AppTheme {


  static ThemeData lightTheme = ThemeData(

    scaffoldBackgroundColor: AppColors.background,

    primaryColor: AppColors.primary,

    colorScheme: ColorScheme.light(

      primary: AppColors.primary,

      secondary: AppColors.secondary,

      error: AppColors.error,

    ),


    appBarTheme: AppBarTheme(

      backgroundColor: AppColors.primary,

      foregroundColor: AppColors.white,

      elevation: 0,

      centerTitle: true,

    ),


    elevatedButtonTheme: ElevatedButtonThemeData(

      style: ElevatedButton.styleFrom(

        backgroundColor: AppColors.primary,

        foregroundColor: AppColors.white,

        minimumSize: Size(double.infinity, 55),

        shape: RoundedRectangleBorder(

          borderRadius: BorderRadius.circular(15),

        ),

      ),

    ),


    inputDecorationTheme: InputDecorationTheme(

      filled: true,

      fillColor: AppColors.white,

      border: OutlineInputBorder(

        borderRadius: BorderRadius.circular(15),

        borderSide: BorderSide.none,

      ),

    ),

  );


}