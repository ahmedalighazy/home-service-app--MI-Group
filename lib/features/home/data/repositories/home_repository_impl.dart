import 'package:dartz/dartz.dart';
import 'package:home_service_app/core/network/network_info.dart';
import 'package:home_service_app/features/home/data/datasources/local/home_local_data_source.dart';
import 'package:home_service_app/features/home/data/datasources/remote/home_remote_data_source.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/home_data_entity.dart';
import '../../domain/repositories/home_repository.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeLocalDataSource localDataSource;
  final HomeRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  HomeRepositoryImpl(
    this.localDataSource,
    this.remoteDataSource,
    this.networkInfo,
  );

  @override
  Future<Either<Failure, HomeDataEntity>> getHomeData() async {
    try {
      if (await networkInfo.isConnected) {
        final homeData = await remoteDataSource.getHomeData();

        return Right(homeData.toEntity());
      }

      final homeData = await localDataSource.getHomeData();

      return Right(homeData.toEntity());
    } catch (e) {
      return const Left(ServerFailure('Failed to load home data'));
    }
  }
}
