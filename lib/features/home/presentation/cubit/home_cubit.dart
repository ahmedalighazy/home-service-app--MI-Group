import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/get_home_data_usecase.dart';
import 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._getHomeDataUseCase) : super(const HomeInitial());

  final GetHomeDataUseCase _getHomeDataUseCase;

  Future<void> getHomeData() async {
    emit(const HomeLoading());

    final result = await _getHomeDataUseCase();

    result.fold(
      (failure) {
        emit(HomeError(failure.message));
      },
      (data) {
        emit(HomeLoaded(data: data));
      },
    );
  }
}
