import '../repositories/service_details_repository.dart';

class BookServiceUseCase {
  final ServiceDetailsRepository repository;

  BookServiceUseCase(this.repository);

  Future<void> call(Map<String, dynamic> bookingData) {
    return repository.bookService(bookingData);
  }
}
