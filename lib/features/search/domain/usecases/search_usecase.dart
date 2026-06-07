import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../entities/search_result_entity.dart';
import '../repositories/search_repository.dart';

@lazySingleton
class SearchUseCase {
  final SearchRepository repository;

  SearchUseCase(this.repository);

  Future<Either<Failure, List<SearchResultEntity>>> call(String query) {
    return repository.search(query);
  }
}
