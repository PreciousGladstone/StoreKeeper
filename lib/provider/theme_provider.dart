import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  static const _prefKey = 'isDark';

  //loads theme and save it for for the next time the app is being open

  Future<void> loadTheme() async {
    final pref = await SharedPreferences.getInstance();
    final isDark = pref.getBool(_prefKey);
    if(isDark != null){
      _themeMode = isDark? ThemeMode.dark: ThemeMode.light;
      notifyListeners();
    }
  }

  Future<void> setdark(bool dark) async{
    _themeMode = dark? ThemeMode.dark: ThemeMode.light;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefKey, dark);
  }


}