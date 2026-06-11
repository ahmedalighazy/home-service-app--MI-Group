import '../models/search_result_model.dart';

abstract class SearchLocalDataSource {
  Future<void> cacheSearchResults(String query, List<SearchResultModel> results);
  Future<List<SearchResultModel>?> getCachedSearchResults(String query);
  Future<void> clearCache();
}
