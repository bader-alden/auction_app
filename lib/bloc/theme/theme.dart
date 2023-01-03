import 'package:flutter/material.dart';

Color main_red = const Color.fromARGB(255, 222, 82, 81);
// Color main_red = const Color.fromARGB(255, 235, 29, 54);
Color sec_color = const Color.fromARGB(255, 237, 220, 194);
// Color sec_color = const Color.fromARGB(255, 245, 237, 220);
ThemeData theme_light()  {
  return ThemeData(
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
   // textTheme: TextTheme(bodyText1: TextStyle(color: Colors.green))
  brightness: Brightness.light,
    primaryColor: main_red,
      appBarTheme: const AppBarTheme(backgroundColor: Colors.white,actionsIconTheme: IconThemeData(color: Colors.black),titleTextStyle: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold)),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Colors.white,selectedItemColor: main_red), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: main_red)
  );
}
ThemeData theme_dark()  {
  return ThemeData(
      backgroundColor: Colors.black,
      scaffoldBackgroundColor: Colors.black,
      //textTheme: TextTheme(bodyText1: TextStyle(color: Colors.white)),
    brightness: Brightness.dark,
    primaryColor: main_red,
      appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Colors.black,selectedItemColor: main_red)
  );
}