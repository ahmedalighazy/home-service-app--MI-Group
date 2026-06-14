part of 'forget_password_cubit.dart';

abstract class ForgetPasswordState {}

class ForgetPasswordInitial extends ForgetPasswordState {}

class ForgetPasswordUpdated extends ForgetPasswordState {}

class ForgetPasswordSendCodeRequested extends ForgetPasswordState {
  final String email;

  ForgetPasswordSendCodeRequested(this.email);
}
