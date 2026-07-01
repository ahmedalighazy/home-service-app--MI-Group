import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_cubit.dart';

class SetNewPasswordBlocListener extends StatelessWidget {
  final Widget child;

  const SetNewPasswordBlocListener({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          current is PasswordResetSuccess || current is PasswordResetFailure,
      listener: (context, state) {
        if (state is PasswordResetSuccess) {
          context.read<AuthCubit>().resetState();
          GoRouter.of(context).go(AppRouter.passwordChangedSuccessfully);
        } else if (state is PasswordResetFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.errorRed,
              behavior: SnackBarBehavior.floating,
            ));
        }
      },
      child: child,
    );
  }
}
