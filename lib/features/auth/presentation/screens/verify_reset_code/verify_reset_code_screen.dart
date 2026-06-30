import 'package:flutter/material.dart';
import 'widgets/verify_reset_code_scaffold.dart';
import 'widgets/verify_reset_code_bloc_listener.dart';

class VerifyResetCodeScreen extends StatelessWidget {
  final String email;

  const VerifyResetCodeScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return VerifyResetCodeBlocListener(
      email: email,
      child: VerifyResetCodeScaffold(email: email),
    );
  }
}
