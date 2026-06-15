import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../entities/home_data_entity.dart';
import '../repositories/home_repository.dart';

@lazySingleton
class GetHomeDataUseCase {
  final HomeRepository repository;

  GetHomeDataUseCase(this.repository);

  Future<Either<Failure, HomeDataEntity>> call() {
    return repository.getHomeData();
  }
}
