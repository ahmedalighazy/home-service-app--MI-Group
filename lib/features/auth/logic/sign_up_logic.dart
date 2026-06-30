import '../data/models/complete_responses.dart';
import '../data/models/register_responses.dart';
import '../data/repos/auth_repo.dart';
import '../presentation/cubits/auth_cubit.dart';

class SignUpLogic {
  final AuthRepo _authRepo;

  SignUpLogic(this._authRepo);

  Future<void> register(
    AuthCubit cubit, {
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    cubit.emitState(AuthLoadingState());
    final result = await _authRepo.register(
      RegisterResponses(name: name, email: email, password: password, phone: phone, role: 'user'),
    );
    if (cubit.isClosed) return;
    result.when(
      success: (msg) => cubit.emitState(RegisterSuccessState(message: msg)),
      failure: (e) => cubit.emitState(AuthErrorState(message: e.message ?? 'فشل إنشاء الحساب')),
    );
  }

  Future<void> completeProfile(
    AuthCubit cubit, {
    required String email,
    required String name,
    required String phone,
    required String password,
  }) async {
    cubit.emitState(AuthLoadingState());
    final result = await _authRepo.completeProfile(
      CompleteResponses(email: email, name: name, phone: phone, password: password),
    );
    if (cubit.isClosed) return;
    result.when(
      success: (msg) => cubit.emitState(RegisterSuccessState(message: msg)),
      failure: (e) => cubit.emitState(AuthErrorState(message: e.message ?? 'فشل إتمام البروفايل')),
    );
  }

  Future<void> signUpWithGoogle(AuthCubit cubit) async {
    cubit.emitState(AuthLoadingState());
    final result = await _authRepo.loginWithGoogle({'provider': 'google'});
    if (cubit.isClosed) return;
    result.when(
      success: (res) => cubit.emitState(RegisterSuccessState(message: res.name != null ? 'مرحباً ${res.name}' : null)),
      failure: (e) => cubit.emitState(AuthErrorState(message: e.message ?? 'فشل التسجيل بـ Google')),
    );
  }

  Future<void> signUpWithApple(AuthCubit cubit) async {
    cubit.emitState(AuthLoadingState());
    final result = await _authRepo.loginWithGoogle({'provider': 'apple'});
    if (cubit.isClosed) return;
    result.when(
      success: (res) => cubit.emitState(RegisterSuccessState(message: res.name != null ? 'مرحباً ${res.name}' : null)),
      failure: (e) => cubit.emitState(AuthErrorState(message: e.message ?? 'فشل التسجيل بـ Apple')),
    );
  }
}
