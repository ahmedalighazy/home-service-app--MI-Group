import 'package:flutter/material.dart';
import 'package:home_service_app/features/auth/listeners/set_new_password_listener.dart';
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
    return SetNewPasswordListener(
      child: SetNewPasswordScaffold(email: email, code: code),
    );
  }
}
