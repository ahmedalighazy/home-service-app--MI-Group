import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/widgets/custom_back_arrow_button.dart';
import 'package:home_service_app/features/auth/cubit/forgot_password/forgot_password_cubit.dart';
import 'new_password_fields.dart';
import 'new_password_confirm_button.dart';

class SetNewPasswordScaffold extends StatefulWidget {
  final String email;
  final String code;

  const SetNewPasswordScaffold({
    super.key,
    required this.email,
    required this.code,
  });

  @override
  State<SetNewPasswordScaffold> createState() => _SetNewPasswordScaffoldState();
}

class _SetNewPasswordScaffoldState extends State<SetNewPasswordScaffold> {
  late final ForgotPasswordCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ForgotPasswordCubit>();
    _cubit.initPasswordListeners();
  }

  @override
  void dispose() {
    _cubit.disposePasswordListeners();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsets.all(8.w),
          child: CustomBackArrowButton(),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          context.tr('setNewPasswordTitle'),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          context.tr('setNewPasswordDescription'),
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 32),
                        const NewPasswordFields(),
                        const Spacer(),
                        const SizedBox(height: 20),
                        NewPasswordConfirmButton(
                          email: widget.email,
                          code: widget.code,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
