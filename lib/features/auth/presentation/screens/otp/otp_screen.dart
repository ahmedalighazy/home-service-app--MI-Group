import 'package:flutter/material.dart';
import 'widgets/otp_bloc_listener.dart';
import 'widgets/otp_scaffold.dart';

class OtpScreen extends StatelessWidget {
  final String email;
  const OtpScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return OtpBlocListener(
      email: email,
      child: OtpScaffold(email: email),
    );
  }
}
