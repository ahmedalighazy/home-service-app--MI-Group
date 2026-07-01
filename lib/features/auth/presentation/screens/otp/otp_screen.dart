import 'package:flutter/material.dart';
import 'package:home_service_app/features/auth/listeners/otp_listener.dart';
import 'widgets/otp_scaffold.dart';

class OtpScreen extends StatelessWidget {
  final String email;
  const OtpScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return OtpListener(
      email: email,
      child: OtpScaffold(email: email),
    );
  }
}
