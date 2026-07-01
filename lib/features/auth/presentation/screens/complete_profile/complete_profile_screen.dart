import 'package:flutter/material.dart';
import 'package:home_service_app/features/auth/listeners/complete_profile_listener.dart';
import 'widgets/complete_profile_scaffold.dart';

class CompleteProfileScreen extends StatelessWidget {
  final String? email;
  const CompleteProfileScreen({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    return CompleteProfileListener(
      email: email,
      child: CompleteProfileScaffold(email: email),
    );
  }
}
