import 'package:home_service_app/features/auth/presentation/screens/otp/widgets/otp_field_state.dart';
import 'auth_animation.dart';
import 'otp_timer.dart';

class AuthUiState {
  bool rememberMe = false;
  bool hasSignInError = false;
  bool signUpHasError = false;
  String? signUpErrorMessage;

  OtpFieldState otpFieldState = OtpFieldState.idle;
  int otpSecondsLeft = 59;
  bool otpCanResend = false;
  OtpTimer? otpTimer;
  final AuthAnimation otpAnimation = AuthAnimation();
  bool otpInitialized = false;

  OtpFieldState resetFieldState = OtpFieldState.idle;
  final AuthAnimation resetAnimation = AuthAnimation();

  bool obscureCompleteProfilePass = true;
  bool obscureCompleteProfileConfirm = true;

  bool obscureNewPassword = true;
  bool obscureConfirmNewPassword = true;

  OtpTimer? emailVerificationTimer;
  int emailVerificationSecondsLeft = 59;
  bool emailVerificationTimerActive = true;
  bool emailVerificationButtonEnabled = false;

  void dispose() {
    otpTimer?.stop();
    otpAnimation.dispose();
    resetAnimation.dispose();
    emailVerificationTimer?.stop();
  }
}
