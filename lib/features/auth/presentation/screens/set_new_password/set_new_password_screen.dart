import 'package:flutter/material.dart';
import 'widgets/set_new_password_bloc_listener.dart';
import 'widgets/set_new_password_scaffold.dart';

class SetNewPasswordScreen extends StatelessWidget {
  final String email;
  final String code;

  const SetNewPasswordScreen({
    super.key,
    required this.email,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    return SetNewPasswordBlocListener(
      child: SetNewPasswordScaffold(email: email, code: code),
    );
  }
}
