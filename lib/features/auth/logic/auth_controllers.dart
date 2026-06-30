import 'package:flutter/widgets.dart';

class AuthControllers {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final signUpEmailCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final newPasswordCtrl = TextEditingController();
  final confirmPasswordCtrl = TextEditingController();
  final otpCodeCtrl = TextEditingController();
  final resetCodeCtrl = TextEditingController();

  final otpFocusNode = FocusNode();
  final resetFocusNode = FocusNode();

  final emailVerificationControllers = List.generate(6, (_) => TextEditingController());
  final emailVerificationFocusNodes = List.generate(6, (_) => FocusNode());

  final signInFormKey = GlobalKey<FormState>();
  final signUpFormKey = GlobalKey<FormState>();
  final completeProfileFormKey = GlobalKey<FormState>();
  final resetPasswordFormKey = GlobalKey<FormState>();

  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    signUpEmailCtrl.dispose();
    nameCtrl.dispose();
    phoneCtrl.dispose();
    newPasswordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    otpCodeCtrl.dispose();
    resetCodeCtrl.dispose();
    otpFocusNode.dispose();
    resetFocusNode.dispose();

    for (final ctrl in emailVerificationControllers) {
      ctrl.dispose();
    }
    for (final node in emailVerificationFocusNodes) {
      node.dispose();
    }
  }
}
