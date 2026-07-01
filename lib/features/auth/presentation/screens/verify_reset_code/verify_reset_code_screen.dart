import 'package:flutter/material.dart';
import 'package:home_service_app/features/auth/listeners/verify_reset_code_listener.dart';
import 'widgets/verify_reset_code_scaffold.dart';

class VerifyResetCodeScreen extends StatelessWidget {
  final String email;

  const VerifyResetCodeScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return VerifyResetCodeListener(
      email: email,
      child: VerifyResetCodeScaffold(email: email),
    );
  }
}
