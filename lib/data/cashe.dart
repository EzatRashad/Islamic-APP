import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putData({required String key, required bool value})async
  {
    return await sharedPreferences.setBool(key, value);
  }

  static bool? getData({required String key})
  {
    return  sharedPreferences.getBool(key);
  }

  static Future<bool> putDataint({required String key, required int value})async
  {
    return await sharedPreferences.setInt(key, value);
  }

  static int? getDataint({required String key})
  {
    return  sharedPreferences.getInt(key);
  }
}
