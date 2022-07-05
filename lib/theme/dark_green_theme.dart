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
  
}
