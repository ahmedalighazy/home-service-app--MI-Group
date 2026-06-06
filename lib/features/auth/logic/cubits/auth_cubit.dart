import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../states/auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> register({
    required String name,
    required String email,
    String? phone,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> sendSmsCode(String phoneNumber) async {
    emit(AuthLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));
      emit(SmsCodeSent(phoneNumber));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> verifySmsCode(String code) async {
    emit(AuthLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));
      emit(SmsCodeVerified());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> sendResetCode(String email) async {
    emit(AuthLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));
      emit(ResetCodeSent(email));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    emit(AuthLoading());
    try {
      //  replace with real API / Firebase call
      await Future.delayed(const Duration(seconds: 2));

      // Simulate: password "error" triggers failure, anything else = success
      if (newPassword == 'error') {
        emit(
          ResetPasswordError(
            'فشل تعيين كلمة المرور الجديدة، يرجى المحاولة مرة أخرى',
          ),
        );
      } else {
        emit(ResetPasswordSuccess());
      }
    } catch (e) {
      emit(ResetPasswordError('حدث خطأ في الاتصال، يرجى المحاولة مرة أخرى'));
    }
  }

  Future<void> loginWithPhone(String phoneNumber) async {
    emit(AuthLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));
      emit(OtpSent());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> loginWithEmail(String email, String password) async {
    emit(AuthLoading());
    try {
      // replace with real API / Firebase call
      await Future.delayed(const Duration(seconds: 2));

      // Simulate: wrong password triggers invalid-credentials state
      if (password == 'wrong') {
        emit(SignInInvalidCredentials());
      } else {
        emit(SignInSuccess());
      }
    } catch (e) {
      emit(SignInError('حدث خطأ في الاتصال، يرجى المحاولة مرة أخرى'));
    }
  }

  Future<void> verifyResetCode(String email, String code) async {
    emit(AuthLoading());
    try {
      // replace with real API / Firebase call
      await Future.delayed(const Duration(seconds: 2));

      // Simulate: code "000000" = wrong/expired, anything else = success
      if (code == '000000') {
        emit(
          ResetCodeError(
            'الرمز غير صحيح أو منتهي الصلاحية، يرجى المحاولة مرة أخرى',
          ),
        );
      } else {
        emit(ResetCodeVerified());
      }
    } catch (e) {
      emit(ResetCodeError('فشل التحقق من الرمز، يرجى المحاولة مرة أخرى'));
    }
  }

  Future<void> verifyOtp(String phoneNumber, String code) async {
    emit(AuthLoading());
    try {
      // replace with real Firebase / API verification
      await Future.delayed(const Duration(seconds: 2));

      // Simulate: code "000000" = wrong, anything else = success
      if (code == '000000') {
        emit(OtpError('الرمز غير صحيح، يرجى المحاولة مرة أخرى'));
      } else {
        emit(OtpVerified());
      }
    } catch (e) {
      emit(OtpError('فشل التحقق من الرمز، يرجى المحاولة مرة أخرى'));
    }
  }
}
