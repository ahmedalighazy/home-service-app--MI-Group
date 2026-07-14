import 'package:home_service_app/core/network/api_error_handler.dart';
import 'package:home_service_app/core/network/api_result.dart';
import 'package:home_service_app/core/network/api_service.dart';
import '../models/favorite_responses.dart';
import '../models/add_favorites_success.dart';
import '../models/removed_favorites.dart';
import '../models/check_favorite_responses.dart';
import '../models/count_favorites_responses.dart';

class FavoritesRepo {
  final ApiService _apiService;

  FavoritesRepo(this._apiService);

  Future<ApiResult<FavoriteResponses>> getFavorites({int? page, int? size}) async {
    try {
      final response = await _apiService.getFavorites(page, size);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<AddFavoritesSuccess>> addFavorite(String listingId) async {
    try {
      final response = await _apiService.addFavorite(listingId);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<RemovedFavorites>> removeFavorite(String listingId) async {
    try {
      final response = await _apiService.removeFavorite(listingId);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<CheckFavoriteResponses>> checkFavorite(String listingId) async {
    try {
      final response = await _apiService.checkFavorite(listingId);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<CountFavoritesResponses>> getFavoritesCount() async {
    try {
      final response = await _apiService.getFavoritesCount();
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
