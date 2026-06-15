import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:home_service_app/core/utils/validation/validators_helper.dart';

part 'forget_password_state.dart';

@injectable
class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  String _email = '';
  bool _hasError = false;

  String get email => _email;
  bool get hasError => _hasError;
  bool get hasInput => _email.trim().isNotEmpty;
  bool get isValid {
    return ValidatorsHelper.isValidEmail(_email);
  }

  void updateEmail(String value) {
    _email = value;
    if (_hasError) {
      _hasError = false;
    }
    emit(ForgetPasswordUpdated());
  }

  void clearError() {
    _hasError = false;
    emit(ForgetPasswordUpdated());
  }

  void setError() {
    _hasError = true;
    emit(ForgetPasswordUpdated());
  }

  void onSendResetCode() {
    if (!isValid) {
      setError();
      return;
    }
    clearError();
    emit(ForgetPasswordSendCodeRequested(_email.trim()));
  }

  @override
  Future<void> close() {
    _email = '';
    _hasError = false;
    return super.close();
  }
}
