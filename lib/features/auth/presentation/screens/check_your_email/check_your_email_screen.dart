import 'package:flutter/material.dart';
import 'widgets/verification_bloc_listener.dart';
import 'widgets/verification_scaffold.dart';

class VerificationScreen extends StatelessWidget {
  final String email;
  final String code;

  const VerificationScreen({
    super.key,
    required this.email,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    return VerificationBlocListener(
      email: email,
      code: code,
      child: VerificationScaffold(email: email, code: code),
    );
  }
}
