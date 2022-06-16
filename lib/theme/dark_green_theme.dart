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
            elevation: 10));
  }
}
