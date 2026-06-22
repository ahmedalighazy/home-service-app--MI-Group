import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_app_config_usecase.dart';
import '../../domain/repositories/splash_repository.dart';
import '../states/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final GetAppConfigUseCase getAppConfigUseCase;
  final SplashRepository splashRepository;

  SplashCubit({
    required this.getAppConfigUseCase,
    required this.splashRepository,
  }) : super(SplashInitial());

  Future<void> loadAppConfig() async {
    emit(SplashLoading());
    try {
      final config = await getAppConfigUseCase();
      emit(SplashLoaded(config));
    } catch (e) {
      emit(SplashError(e.toString()));
    }
  }

  Future<void> setFirstLaunch(bool isFirstLaunch) async {
    await splashRepository.setFirstLaunch(isFirstLaunch);
  }
}
