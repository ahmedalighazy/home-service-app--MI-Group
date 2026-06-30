import '../data/repos/auth_repo.dart';
import '../presentation/cubits/auth_cubit.dart';

class OtpLogic {
  final AuthRepo _authRepo;

  OtpLogic(this._authRepo);

  Future<void> sendSmsCode(AuthCubit cubit, String email) async {
    cubit.emitState(AuthLoadingState());
    final result = await _authRepo.sendSmsCode(email);
    if (cubit.isClosed) return;
    result.when(
      success: (msg) => cubit.emitState(OtpSentState(email: email, message: msg)),
      failure: (e) => cubit.emitState(AuthErrorState(message: e.message ?? 'فشل إرسال الكود')),
    );
  }

  Future<void> verifyOtp(AuthCubit cubit, {required String phoneNumber, required String otp}) async {
    cubit.emitState(AuthLoadingState());
    final result = await _authRepo.verifyOtp(email: phoneNumber, otp: otp);
    if (cubit.isClosed) return;
    result.when(
      success: (msg) => cubit.emitState(OtpVerifiedState(email: phoneNumber, message: msg)),
      failure: (e) => cubit.emitState(OtpErrorState(message: e.message ?? 'كود غير صحيح')),
    );
  }

  Future<void> loginWithPhone(AuthCubit cubit, String phone) async {
    cubit.emitState(AuthLoadingState());
    final result = await _authRepo.loginWithPhone({'phone': phone});
    if (cubit.isClosed) return;
    result.when(
      success: (res) => cubit.emitState(OtpSentState(email: phone)),
      failure: (e) => cubit.emitState(AuthErrorState(message: e.message ?? 'فشل إرسال الكود')),
    );
  }

  Future<void> resendOtp(AuthCubit cubit, String email) async {
    cubit.emitState(AuthLoadingState());
    final result = await _authRepo.resendOtp(email);
    if (cubit.isClosed) return;
    result.when(
      success: (msg) => cubit.emitState(OtpSentState(email: email, message: msg)),
      failure: (e) => cubit.emitState(OtpErrorState(message: e.message ?? 'فشل إعادة الإرسال')),
    );
  }
}
