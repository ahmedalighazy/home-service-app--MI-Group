import 'package:flutter_bloc/flutter_bloc.dart';
import '../states/auth_state.dart';

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
      emit(AuthAuthenticated());
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
      // TODO: replace with real API / Firebase call
      await Future.delayed(const Duration(seconds: 2));

      // Accept any password for testing
      emit(ResetPasswordSuccess());
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

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));
      // Accept any email and password for testing
      emit(AuthAuthenticated(email: email, displayName: null));
    } catch (e) {
      emit(AuthError('حدث خطأ في الاتصال، يرجى المحاولة مرة أخرى'));
    }
  }

  Future<void> forgotPassword({required String email}) async {
    emit(AuthLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));
      emit(ResetCodeSent(email));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> verifyResetCode(String email, String code) async {
    emit(AuthLoading());
    try {
      // TODO: replace with real API / Firebase call
      await Future.delayed(const Duration(seconds: 2));

      // Simulate: code "000000" = wrong/expired, anything else = success
      if (code == '000000') {
        emit(ResetCodeError('الرمز غير صحيح أو منتهي الصلاحية، يرجى المحاولة مرة أخرى'));
      } else {
        emit(ResetCodeVerified());
      }
    } catch (e) {
      emit(ResetCodeError('فشل التحقق من الرمز، يرجى المحاولة مرة أخرى'));
    }
  }

  // ── Social Sign-In ──────────────────────────────────────────────────────────

  Future<void> signInWithGoogle() async {
    emit(SocialSignInLoading());
    try {
      // TODO: Replace with real Google Sign-In via firebase_auth + google_sign_in packages:
      //
      // final googleUser = await GoogleSignIn().signIn();
      // if (googleUser == null) { emit(SocialSignInCancelled()); return; }
      // final googleAuth = await googleUser.authentication;
      // final credential = GoogleAuthProvider.credential(
      //   accessToken: googleAuth.accessToken,
      //   idToken: googleAuth.idToken,
      // );
      // final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      // emit(GoogleSignInSuccess(
      //   email: userCredential.user?.email,
      //   displayName: userCredential.user?.displayName,
      // ));

      await Future.delayed(const Duration(seconds: 2));
      emit(GoogleSignInSuccess(
        email: 'user@gmail.com',
        displayName: 'Google User',
      ));
    } catch (e) {
      emit(SocialSignInError('فشل تسجيل الدخول عبر Google، يرجى المحاولة مرة أخرى'));
    }
  }

  Future<void> signInWithApple() async {
    emit(SocialSignInLoading());
    try {
      // TODO: Replace with real Apple Sign-In via firebase_auth + sign_in_with_apple packages:
      //
      // final appleCredential = await SignInWithApple.getAppleIDCredential(
      //   scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName],
      // );
      // final oauthCredential = OAuthProvider('apple.com').credential(
      //   idToken: appleCredential.identityToken,
      //   accessToken: appleCredential.authorizationCode,
      // );
      // final userCredential = await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      // emit(AppleSignInSuccess(
      //   email: userCredential.user?.email,
      //   displayName: userCredential.user?.displayName,
      // ));

      await Future.delayed(const Duration(seconds: 2));
      emit(AppleSignInSuccess(
        email: 'user@icloud.com',
        displayName: 'Apple User',
      ));
    } catch (e) {
      emit(SocialSignInError('فشل تسجيل الدخول عبر Apple، يرجى المحاولة مرة أخرى'));
    }
  }

  // ── Sign Up Flow ────────────────────────────────────────────────────────────

  Future<void> sendOtp({
    required String phoneNumber,
    String? email,
  }) async {
    emit(AuthLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));
      emit(OtpSent());
    } catch (e) {
      emit(AuthError('فشل إرسال رمز OTP، يرجى المحاولة مرة أخرى'));
    }
  }

  Future<void> verifyOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    emit(AuthLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));
      // Accept any 6-digit code
      emit(OtpVerified());
    } catch (e) {
      emit(AuthError('فشل التحقق من OTP، يرجى المحاولة مرة أخرى'));
    }
  }

  Future<void> completeProfile({
    required String phoneNumber,
    required String name,
    required String email,
    required String gender,
    String? address,
    String? bio,
  }) async {
    emit(AuthLoading());
    try {
      // Validation
      if (name.isEmpty) {
        emit(ProfileCompletionError('الاسم مطلوب'));
        return;
      }
      if (email.isEmpty) {
        emit(ProfileCompletionError('البريد الإلكتروني مطلوب'));
        return;
      }
      if (!_isValidEmail(email)) {
        emit(ProfileCompletionError('البريد الإلكتروني غير صحيح'));
        return;
      }
      if (gender.isEmpty) {
        emit(ProfileCompletionError('النوع مطلوب'));
        return;
      }

      // TODO: Send data to backend API
      // Example: POST /api/users/complete-profile
      // {
      //   "phoneNumber": phoneNumber,
      //   "name": name,
      //   "email": email,
      //   "gender": gender,
      //   "address": address,
      //   "bio": bio
      // }

      await Future.delayed(const Duration(seconds: 2));
      emit(ProfileCompletionSuccess(
        message: 'تم إكمال الملف الشخصي بنجاح! جاري إعادة التوجيه...',
      ));
    } catch (e) {
      emit(ProfileCompletionError('فشل إكمال الملف الشخصي، يرجى المحاولة مرة أخرى'));
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(email);
  }

  Future<void> signUpWithGoogle() async {
    emit(SocialSignInLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));
      emit(GoogleSignInSuccess(
        email: 'user@gmail.com',
        displayName: 'Google User',
      ));
    } catch (e) {
      emit(SocialSignInError('فشل التسجيل عبر Google، يرجى المحاولة مرة أخرى'));
    }
  }

  Future<void> signUpWithApple() async {
    emit(SocialSignInLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));
      emit(AppleSignInSuccess(
        email: 'user@icloud.com',
        displayName: 'Apple User',
      ));
    } catch (e) {
      emit(SocialSignInError('فشل التسجيل عبر Apple، يرجى المحاولة مرة أخرى'));
    }
  }
}
