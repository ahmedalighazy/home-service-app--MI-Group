import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/widgets.dart';

// ── States ────────────────────────────────

sealed class ForgetPasswordState {}

final class ForgetPasswordInitial extends ForgetPasswordState {}

final class ForgetPasswordUpdated extends ForgetPasswordState {
  final String email;
  final bool hasError;
  final bool isValid;
  ForgetPasswordUpdated({
    required this.email,
    required this.hasError,
    required this.isValid,
  });
}

final class ForgetPasswordSendCodeRequested extends ForgetPasswordState {
  final String email;
  ForgetPasswordSendCodeRequested({required this.email});
}

// ── Cubit ─────────────────────────────────

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final TextEditingController emailCtrl = TextEditingController();

  ForgetPasswordCubit() : super(ForgetPasswordInitial()) {
    emailCtrl.addListener(() {
      updateEmail(emailCtrl.text);
    });
  }

  String _email = '';

  bool get hasError => _email.isNotEmpty && !_isValidEmail(_email);
  bool get isValid => _email.isNotEmpty && _isValidEmail(_email);

  void updateEmail(String value) {
    _email = value.trim();
    emit(ForgetPasswordUpdated(
      email: _email,
      hasError: hasError,
      isValid: isValid,
    ));
  }

  void onSendResetCode() {
    if (!isValid) return;
    emit(ForgetPasswordSendCodeRequested(email: _email));
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w\-.]+@([\w\-]+\.)+[\w\-]{2,4}$').hasMatch(email);
  }

  @override
  Future<void> close() {
    emailCtrl.dispose();
    return super.close();
  }
}
