import 'package:flutter/material.dart';
import 'widgets/complete_profile_bloc_listener.dart';
import 'widgets/complete_profile_scaffold.dart';

class CompleteProfileScreen extends StatelessWidget {
  final String? email;
  const CompleteProfileScreen({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    return CompleteProfileBlocListener(
      email: email,
      child: CompleteProfileScaffold(email: email),
    );
  }
}
