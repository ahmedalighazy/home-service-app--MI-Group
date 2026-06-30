import '../data/models/request/login_request_model.dart';
import '../data/repos/auth_repo.dart';
import '../presentation/cubits/auth_cubit.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';

class SignInLogic {
  final AuthRepo _authRepo;

  SignInLogic(this._authRepo);

  Future<void> login(AuthCubit cubit, {required String identifier, required String password}) async {
    if (identifier.trim().isEmpty || password.isEmpty) {
      cubit.setSignInError(true);
      cubit.emitState(AuthErrorState(
        message: LocalizationService.instance.translate('errorFieldRequired'),
      ));
      return;
    }
    cubit.setSignInError(false);
    cubit.emitState(AuthLoadingState());
    final result = await _authRepo.login(
      LoginRequestModel(identifier: identifier, password: password),
    );
    if (cubit.isClosed) return;
    result.when(
      success: (res) => cubit.emitState(LoginSuccessState(message: res.name != null ? 'مرحباً ${res.name}' : null)),
      failure: (e) => cubit.emitState(AuthErrorState(message: e.message ?? 'فشل تسجيل الدخول')),
    );
  }

  Future<void> signInWithGoogle(AuthCubit cubit) async {
    cubit.emitState(AuthLoadingState());
    final result = await _authRepo.loginWithGoogle({'provider': 'google'});
    if (cubit.isClosed) return;
    result.when(
      success: (res) => cubit.emitState(LoginSuccessState(message: res.name != null ? 'مرحباً ${res.name}' : null)),
      failure: (e) => cubit.emitState(AuthErrorState(message: e.message ?? 'فشل تسجيل الدخول بـ Google')),
    );
  }

  Future<void> signInWithApple(AuthCubit cubit) async {
    cubit.emitState(AuthLoadingState());
    final result = await _authRepo.loginWithGoogle({'provider': 'apple'});
    if (cubit.isClosed) return;
    result.when(
      success: (res) => cubit.emitState(LoginSuccessState(message: res.name != null ? 'مرحباً ${res.name}' : null)),
      failure: (e) => cubit.emitState(AuthErrorState(message: e.message ?? 'فشل تسجيل الدخول بـ Apple')),
    );
  }

  void loginAsGuest(AuthCubit cubit) {
    cubit.emitState(GuestLoginSuccessState());
  }
}
