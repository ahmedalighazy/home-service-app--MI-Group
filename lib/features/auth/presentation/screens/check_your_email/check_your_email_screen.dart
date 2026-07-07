import 'package:flutter/material.dart';
import 'package:home_service_app/features/auth/listeners/check_your_email_listener.dart';
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
    return CheckYourEmailListener(
      email: email,
      code: code,
      child: VerificationScaffold(email: email, code: code),
    );
  }
}
