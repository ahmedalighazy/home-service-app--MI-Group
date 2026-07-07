import 'package:equatable/equatable.dart';

class NewPassBtnData extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isPasswordsValid;

  const NewPassBtnData({
    required this.isLoading,
    required this.isSuccess,
    required this.isPasswordsValid,
  });

  @override
  List<Object?> get props => [isLoading, isSuccess, isPasswordsValid];
}
