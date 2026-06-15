import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/features/auth/presentation/cubits/sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(const SignUpInitial());

  void emailChanged(String email) {
    final isValid = _isValidEmail(email);
    final currentState = state as SignUpChanged?;
    
    emit(SignUpChanged(
      email: email,
      emailError: isValid ? null : 'البريد غير صحيح',
      password: currentState?.password ?? '',
      passwordError: currentState?.passwordError,
      confirmPassword: currentState?.confirmPassword ?? '',
      confirmPasswordError: currentState?.confirmPasswordError,
      firstName: currentState?.firstName ?? '',
      lastName: currentState?.lastName ?? '',
      phoneNumber: currentState?.phoneNumber ?? '',
    ));
  }

  void passwordChanged(String password) {
    final isValid = password.length >= 6;
    final currentState = state as SignUpChanged?;
    
    emit(SignUpChanged(
      email: currentState?.email ?? '',
      emailError: currentState?.emailError,
      password: password,
      passwordError: isValid ? null : 'كلمة المرور قصيرة جداً',
      confirmPassword: currentState?.confirmPassword ?? '',
      confirmPasswordError: currentState?.confirmPasswordError,
      firstName: currentState?.firstName ?? '',
      lastName: currentState?.lastName ?? '',
      phoneNumber: currentState?.phoneNumber ?? '',
    ));
  }

  void confirmPasswordChanged(String confirmPassword) {
    final currentState = state as SignUpChanged?;
    final passwordMatch = confirmPassword == currentState?.password;
    
    emit(SignUpChanged(
      email: currentState?.email ?? '',
      emailError: currentState?.emailError,
      password: currentState?.password ?? '',
      passwordError: currentState?.passwordError,
      confirmPassword: confirmPassword,
      confirmPasswordError: passwordMatch ? null : 'كلمات المرور غير متطابقة',
      firstName: currentState?.firstName ?? '',
      lastName: currentState?.lastName ?? '',
      phoneNumber: currentState?.phoneNumber ?? '',
    ));
  }

  void firstNameChanged(String firstName) {
    final currentState = state as SignUpChanged?;
    
    emit(SignUpChanged(
      email: currentState?.email ?? '',
      emailError: currentState?.emailError,
      password: currentState?.password ?? '',
      passwordError: currentState?.passwordError,
      confirmPassword: currentState?.confirmPassword ?? '',
      confirmPasswordError: currentState?.confirmPasswordError,
      firstName: firstName,
      lastName: currentState?.lastName ?? '',
      phoneNumber: currentState?.phoneNumber ?? '',
    ));
  }

  void lastNameChanged(String lastName) {
    final currentState = state as SignUpChanged?;
    
    emit(SignUpChanged(
      email: currentState?.email ?? '',
      emailError: currentState?.emailError,
      password: currentState?.password ?? '',
      passwordError: currentState?.passwordError,
      confirmPassword: currentState?.confirmPassword ?? '',
      confirmPasswordError: currentState?.confirmPasswordError,
      firstName: currentState?.firstName ?? '',
      lastName: lastName,
      phoneNumber: currentState?.phoneNumber ?? '',
    ));
  }

  void phoneNumberChanged(String phoneNumber) {
    final currentState = state as SignUpChanged?;
    
    emit(SignUpChanged(
      email: currentState?.email ?? '',
      emailError: currentState?.emailError,
      password: currentState?.password ?? '',
      passwordError: currentState?.passwordError,
      confirmPassword: currentState?.confirmPassword ?? '',
      confirmPasswordError: currentState?.confirmPasswordError,
      firstName: currentState?.firstName ?? '',
      lastName: currentState?.lastName ?? '',
      phoneNumber: phoneNumber,
    ));
  }

  Future<void> register() async {
    final currentState = state as SignUpChanged?;
    if (currentState == null) return;

    if (currentState.emailError != null || 
        currentState.passwordError != null || 
        currentState.confirmPasswordError != null) {
      emit(const SignUpError('يوجد أخطاء في النموذج'));
      return;
    }

    try {
      emit(const SignUpLoading());
      await Future.delayed(const Duration(seconds: 2));
      emit(const SignUpSuccess());
    } catch (e) {
      emit(SignUpError(e.toString()));
    }
  }

  bool _isValidEmail(String email) {
    return email.contains('@') && email.contains('.');
  }
}
