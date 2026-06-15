import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/booking_repository.dart';
import 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final BookingRepository _repository;

  BookingCubit(this._repository) : super(BookingInitial());

  Future<void> fetchBookings() async {
    emit(BookingLoading());
    try {
      final bookings = await _repository.getBookings();
      if (bookings.isEmpty) {
        emit(BookingEmpty());
      } else {
        emit(BookingSuccess(bookings));
      }
    } catch (e) {
      emit(BookingError(e.toString()));
    }
  }

  int selectedDayIndex = 0;
  int selectedTimeIndex = 0;

  void selectDay(int index) {
    selectedDayIndex = index;
    emit(BookingDaySelected(index));
  }

  void selectTime(int index) {
    selectedTimeIndex = index;
    emit(BookingTimeSelected(index));
  }
}
