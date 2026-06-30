import '../data/repos/auth_repo.dart';
import '../presentation/cubits/auth_cubit.dart';

class ResetPasswordLogic {
  final AuthRepo _authRepo;

  ResetPasswordLogic(this._authRepo);

  Future<void> sendResetCode(AuthCubit cubit, String email) async {
    cubit.emitState(AuthLoadingState());
    final result = await _authRepo.sendResetCode(email);
    if (cubit.isClosed) return;
    result.when(
      success: (msg) => cubit.emitState(ResetCodeSentState(email: email, message: msg)),
      failure: (e) => cubit.emitState(AuthErrorState(message: e.message ?? 'فشل إرسال كود الاستعادة')),
    );
  }

  Future<void> verifyResetCode(AuthCubit cubit, String email, String code) async {
    cubit.emitState(AuthLoadingState());
    final result = await _authRepo.verifyResetCode(email: email, otp: code);
    if (cubit.isClosed) return;
    result.when(
      success: (_) => cubit.emitState(ResetCodeVerifiedState(email: email, code: code)),
      failure: (e) => cubit.emitState(ResetCodeError(message: e.message ?? 'كود غير صحيح')),
    );
  }

  Future<void> resetPassword(
    AuthCubit cubit, {
    required String email,
    required String code,
    required String newPassword,
  }) async {
    cubit.emitState(AuthLoadingState());
    final result = await _authRepo.resetPassword(email: email, otp: code, newPassword: newPassword);
    if (cubit.isClosed) return;
    result.when(
      success: (msg) => cubit.emitState(PasswordResetSuccessState(message: msg)),
      failure: (e) => cubit.emitState(PasswordResetErrorState(message: e.message ?? 'فشل تغيير كلمة المرور')),
    );
  }
}
