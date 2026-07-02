import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/request/auth_request.dart';
import '../../data/repos/auth_repo.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo authRepo;

  LoginCubit(this.authRepo) : super(LoginInitial());

  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  Future<void> login(String identifier, String password) async {
    if (identifier.isEmpty || password.isEmpty) {
      emit(LoginFailure(message: 'Email and password are required'));
      return;
    }
    emit(LoginLoading());
    final r = await authRepo.login(
      LoginRequestModel(identifier: identifier, password: password),
    );
    if (isClosed) return;
    r.when(
      success: (d) => emit(LoginSuccess(message: d.name)),
      failure: (e) => emit(LoginFailure(message: e.message ?? 'Login failed')),
    );
  }

  Future<void> signInWithGoogle() async {
    emit(LoginLoading());
    final r = await authRepo.loginWithGoogle(idToken: '');
    if (isClosed) return;
    r.when(
      success: (d) => emit(LoginSuccess(message: d.name)),
      failure: (e) =>
          emit(LoginFailure(message: e.message ?? 'Google sign-in failed')),
    );
  }

  void signInWithApple() {
    emit(LoginFailure(message: 'Apple sign-in is not yet supported'));
  }

  void loginAsGuest() => emit(GuestLoginSuccess());

  @override
  Future<void> close() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    return super.close();
  }
}
