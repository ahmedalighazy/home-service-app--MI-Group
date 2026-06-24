import 'package:dartz/dartz.dart';
import 'package:home_service_app/features/search/domain/entities/search_result_entity.dart';

import '../../../../core/error/failures.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<SearchResultEntity>>> search(String query);
}
