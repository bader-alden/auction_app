import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Color main_red = const Color.fromARGB(255, 222, 82, 81);
Color main_black = const  Color.fromRGBO(22, 22, 22, 1);
Color main_white = const  Color.fromRGBO(255, 250, 250, 1.0);
// Color main_red = const Color.fromARGB(255, 235, 29, 54);
Color sec_color = const Color.fromARGB(255, 237, 220, 194);
// Color sec_color = const Color.fromARGB(255, 245, 237, 220);
ThemeData theme_light()  {
  return ThemeData(
    backgroundColor: main_white,
    scaffoldBackgroundColor: main_white,
   // textTheme: TextTheme(bodyText1: TextStyle(color: Colors.green))
  brightness: Brightness.light,
    primaryColor: main_red,
      appBarTheme:  AppBarTheme(backgroundColor:main_white,actionsIconTheme: IconThemeData(color: Colors.red),titleTextStyle: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),elevation: 0,systemOverlayStyle: SystemUiOverlayStyle(statusBarColor:main_white,systemNavigationBarColor: main_white,statusBarBrightness: Brightness.light)),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: main_white,selectedItemColor: main_red), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: main_red)
  );
}//Color(-15329770)
ThemeData theme_dark()  {
  return ThemeData(
      backgroundColor: Color.fromRGBO(22, 22, 22, 1),
      scaffoldBackgroundColor: Color.fromRGBO(22, 22, 22, 1),
      //textTheme: TextTheme(bodyText1: TextStyle(color: Colors.white)),
    brightness: Brightness.dark,
    primaryColor: main_red,
      appBarTheme: const AppBarTheme(backgroundColor: Color.fromRGBO(22, 22, 22, 1),elevation: 0,systemOverlayStyle: SystemUiOverlayStyle(statusBarColor:Color.fromRGBO(22, 22, 22, 1),systemNavigationBarColor:Color.fromRGBO(22, 22, 22, 1) ,statusBarBrightness: Brightness.dark)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Color.fromRGBO(22, 22, 22, 1),selectedItemColor: main_red)
  );
}