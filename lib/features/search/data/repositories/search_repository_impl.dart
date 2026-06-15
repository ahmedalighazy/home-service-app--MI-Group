import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/search_result_entity.dart';
import '../../domain/repositories/search_repository.dart';
import '../datasources/search_remote_datasource.dart';
import '../datasources/search_local_datasource.dart';
import '../models/search_result_model.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource remoteDataSource;
  final SearchLocalDataSource localDataSource;

  SearchRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<SearchResultEntity>>> search(String query) async {
    try {
      final resultModels = await remoteDataSource.search(query);
      await localDataSource.cacheSearchResults(query, resultModels);
      final entities = resultModels.map((model) => _toSearchResultEntity(model)).toList();
      return Right(entities);
    } catch (e) {
      final cached = await localDataSource.getCachedSearchResults(query);
      if (cached != null) {
        final entities = cached.map((model) => _toSearchResultEntity(model)).toList();
        return Right(entities);
      }
      return Left(ServerFailure('Search failed: $e'));
    }
  }

  SearchResultEntity _toSearchResultEntity(SearchResultModel model) {
    return SearchResultEntity(
      id: model.id,
      title: model.title,
      description: '',
      type: '',
    );
  }
}
