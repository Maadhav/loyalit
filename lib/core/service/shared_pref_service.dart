import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static const String languageCode = "pls.languageCode";

  Future<void> setBoolKey({required String key, required bool value}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  Future<bool> getBoolKey(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(key) ?? false;
  }

  Future<void> setStringKey(
      {required String key, required String value}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<String> getStringKey({required String key, required String defValue}) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key) ?? defValue;
  }
}
