import 'dart:convert';
import 'package:home_service_app/core/utils/helpers/cache_helper.dart';
import '../models/favorite_responses.dart';

class LocalFavoritesManager {
  static const String _key = 'local_favorites';

  static List<Content> getLocalFavorites() {
    final dynamic jsonStr = CacheHelper.getData(_key);
    if (jsonStr == null || jsonStr is! String || jsonStr.isEmpty) return [];
    try {
      final List<dynamic> list = jsonDecode(jsonStr);
      return list.map((item) => Content.fromJson(item)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<void> addFavorite(Content item) async {
    final List<Content> favorites = getLocalFavorites();
    if (!favorites.any((element) => element.id == item.id)) {
      favorites.add(item);
      final jsonStr = jsonEncode(favorites.map((e) => e.toJson()).toList());
      await CacheHelper.saveData(_key, jsonStr);
    }
  }

  static Future<void> saveAllFavorites(List<Content> items) async {
    final jsonStr = jsonEncode(items.map((e) => e.toJson()).toList());
    await CacheHelper.saveData(_key, jsonStr);
  }

  static Future<void> removeFavorite(String id) async {
    final List<Content> favorites = getLocalFavorites();
    favorites.removeWhere((element) => element.id == id);
    final jsonStr = jsonEncode(favorites.map((e) => e.toJson()).toList());
    await CacheHelper.saveData(_key, jsonStr);
  }

  static bool isFavorite(String id) {
    final List<Content> favorites = getLocalFavorites();
    return favorites.any((element) => element.id == id);
  }
}
