import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier{
  String currentLang='ar';
  ThemeMode currentTheme =ThemeMode.dark;
  bool isDark(){
    return currentTheme==ThemeMode.dark;
  }
  void changeTheme(ThemeMode newTheme){
    if(newTheme==currentTheme)return;
    currentTheme=newTheme;
    notifyListeners();
  }
  void changeLang(String newLang){
    if(newLang==currentLang)return;
    currentLang=newLang;
    notifyListeners();
  }
}