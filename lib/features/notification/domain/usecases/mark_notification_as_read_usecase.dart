import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../repositories/notification_repository.dart';

@lazySingleton
class MarkNotificationAsReadUseCase {
  final NotificationRepository repository;

  MarkNotificationAsReadUseCase(this.repository);

  Future<Either<Failure, void>> call(String id) {
    return repository.markAsRead(id);
  }
}
