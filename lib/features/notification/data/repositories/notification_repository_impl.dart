import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/repositories/notification_repository.dart';
import '../datasources/remote/notification_remote_data_source.dart';

@LazySingleton(as: NotificationRepository)
class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  NotificationRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications() async {
    try {
      if (await networkInfo.isConnected) {
        final notifications = await remoteDataSource.getNotifications();

        return Right(notifications.map((e) => e.toEntity()).toList());
      }

      return const Left(NetworkFailure('No internet connection'));
    } catch (e) {
      return const Left(ServerFailure('Failed to load notifications'));
    }
  }

  @override
  Future<Either<Failure, void>> markAsRead(String id) async {
    try {
      if (await networkInfo.isConnected) {
        await remoteDataSource.markAsRead(id);
        return const Right(null);
      }

      return const Left(NetworkFailure('No Internet Connection'));
    } catch (_) {
      return const Left(ServerFailure('Failed to mark notification as read'));
    }
  }
}
