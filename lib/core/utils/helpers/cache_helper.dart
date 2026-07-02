import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // ── SharedPreferences ──────────────────────────────────────

  static dynamic getData(String key) {
    return sharedPreferences.get(key);
  }

  static Future<bool> saveData(String key, dynamic value) async {
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);
    if (value is double) return await sharedPreferences.setDouble(key, value);
    return false;
  }

  static Future<bool> removeData(String key) async {
    return await sharedPreferences.remove(key);
  }

  static Future<bool> clearData() async {
    return await sharedPreferences.clear();
  }

  // ── FlutterSecureStorage ───────────────────────────────────

  static Future<String?> getSecure(String key) {
    return _secureStorage.read(key: key);
  }

  static Future<void> setSecure(String key, String value) {
    return _secureStorage.write(key: key, value: value);
  }

  static Future<void> removeSecure(String key) {
    return _secureStorage.delete(key: key);
  }
}
