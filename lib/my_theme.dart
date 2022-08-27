import 'package:flutter/material.dart';

class MyTheme{
  static const Color lightPrimary=Color(0xFF5D9CEC);
  static const Color lightScafoldBackground=Color(0xFFDFECDB);
  static const Color darkScafoldBackground=Color(0xFF060E1E);
  static const Color green=Color(0xFF61E757);
  static const Color red=Color(0xFFEC4B4B);
  static const Color icons=Color(0xFF707070);

  static final lightTheme=ThemeData(

      bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.white),
    primaryColor: lightPrimary,
    scaffoldBackgroundColor: lightScafoldBackground,
    appBarTheme: AppBarTheme(
      color: lightPrimary,
        titleTextStyle: TextStyle(
            color: Colors.white
        )
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedIconTheme: IconThemeData(
        size: 36,
      color:icons
      ),
      unselectedIconTheme:IconThemeData(
        size: 36
    )
    ),
    textTheme: TextTheme(
      titleMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: lightPrimary
      ),
      titleSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black
      ),
      bodySmall: TextStyle(
          fontSize: 12,
        color: Colors.black,
      ),
    ),
      bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.white
      )
  );
  static final darkTheme=ThemeData(
      bottomSheetTheme: BottomSheetThemeData(backgroundColor: darkScafoldBackground),
    primaryColor: lightPrimary,
    scaffoldBackgroundColor: darkScafoldBackground,
    appBarTheme: AppBarTheme(
        color: lightPrimary,
      titleTextStyle: TextStyle(
        color: Colors.black
      )
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,

        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedIconTheme: IconThemeData(
            size: 36
        ),
        unselectedIconTheme:IconThemeData(
          color: icons,
            size: 36
        )
    ),
    textTheme: TextTheme(
      titleMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: lightPrimary
      ),
      titleSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        color: Colors.white,
      ),
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: Colors.black
    )
  );
}