import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  CacheHelper._();

  static late SharedPreferences sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // ===========================================================================
  // Primitive Types
  // ===========================================================================

  static dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return sharedPreferences.setString(key, value);
    }

    if (value is int) {
      return sharedPreferences.setInt(key, value);
    }

    if (value is bool) {
      return sharedPreferences.setBool(key, value);
    }

    if (value is double) {
      return sharedPreferences.setDouble(key, value);
    }

    return false;
  }

  // ===========================================================================
  // JSON
  // ===========================================================================

  static Future<bool> saveJson({
    required String key,
    required Map<String, dynamic> value,
  }) async {
    return sharedPreferences.setString(key, jsonEncode(value));
  }

  static Map<String, dynamic>? getJson({required String key}) {
    final json = sharedPreferences.getString(key);

    if (json == null || json.isEmpty) {
      return null;
    }

    return jsonDecode(json) as Map<String, dynamic>;
  }

  // ===========================================================================
  // List<String>
  // ===========================================================================

  static Future<bool> saveStringList({
    required String key,
    required List<String> value,
  }) async {
    return sharedPreferences.setStringList(key, value);
  }

  static List<String>? getStringList({required String key}) {
    return sharedPreferences.getStringList(key);
  }

  // ===========================================================================
  // Remove
  // ===========================================================================

  static Future<bool> removeData({required String key}) async {
    return sharedPreferences.remove(key);
  }

  static bool containsKey({required String key}) {
    return sharedPreferences.containsKey(key);
  }

  static Future<bool> clearData() async {
    return sharedPreferences.clear();
  }
}
