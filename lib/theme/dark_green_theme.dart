import 'package:flutter/material.dart';

import 'colors.dart';

class CustomTheme {
  static ThemeData get darkTheme {
    return ThemeData(
        primaryColor: CustomColors.green,
        scaffoldBackgroundColor: CustomColors.black,
        fontFamily: 'Montserrat',
        appBarTheme: const AppBarTheme(
            color: CustomColors.lightBlack,
            foregroundColor: CustomColors.green),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: CustomColors.lightBlack,
            selectedItemColor: CustomColors.green,
            unselectedItemColor: CustomColors.grey,
            elevation: 10),
    dialogTheme: const DialogTheme(
      backgroundColor: CustomColors.black,
      titleTextStyle: TextStyle(color: CustomColors.white, fontSize: 18, fontWeight: FontWeight.bold),
      contentTextStyle: TextStyle(color: CustomColors.white, fontSize: 14)
    ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: CustomColors.mint,
      scaffoldBackgroundColor: CustomColors.white,
      fontFamily: 'Montserrat',
      appBarTheme: const AppBarTheme(
          color: CustomColors.grey,
          foregroundColor: CustomColors.mint),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: CustomColors.grey,
          selectedItemColor: CustomColors.mint,
          unselectedItemColor: CustomColors.black,
          elevation: 10),
      dialogTheme: const DialogTheme(
          backgroundColor: CustomColors.grey,
          titleTextStyle: TextStyle(color: CustomColors.black, fontSize: 18, fontWeight: FontWeight.bold),
          contentTextStyle: TextStyle(color: CustomColors.black, fontSize: 14)
      ),
    );
  }

}
