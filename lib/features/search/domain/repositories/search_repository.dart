import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/search_result_entity.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<SearchResultEntity>>> search(String query);
}
