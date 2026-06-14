import 'package:flutter/material.dart';
import 'package:home_service_app/features/auth/presentation/screens/password_changed/widgets/pass_widgets.dart';

import 'logic/pass_logic.dart';


class PasswordChangedSuccessfullyScreen extends StatelessWidget {
  const PasswordChangedSuccessfullyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = PasswordChangedLogic();

    return Scaffold(
      backgroundColor: const Color(0xFF727A89),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'نجاح تغيير الباسورد',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withValues(alpha: 0.4),
                  ),
                ),

                const SizedBox(height: 20),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 36,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SuccessIcon(),

                      const SizedBox(height: 24),

                      const SuccessTextSection(),

                      const SizedBox(height: 32),

                      SuccessGradientButton(
                        onPressed: () => logic.onSignInPressed(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}