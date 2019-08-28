import 'package:shared_preferences/shared_preferences.dart';

// 增、改
// sharedPreferences.setString(key, value);
// 删
// sharedPreferences.remove(key);
// 查
// sharedPreferences.get(key);

class LocalStorage {
  
  static Future getString(String key) async {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      return sharedPreferences.getString(key);
  }
  
  static Future setString(String key, String value) async {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString(key, value);
  }

  static Future getBool(String key) async {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      return sharedPreferences.getBool(key);
  }

  static Future setBool(String key, bool value) async {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setBool(key, value);
  }

  static Future remove(String key) async {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.remove(key);
  }
  
}

