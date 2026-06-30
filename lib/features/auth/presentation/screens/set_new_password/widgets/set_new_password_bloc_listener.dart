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
    final cubit = context.watch<AuthCubit>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (cubit.state is! AuthInitial && cubit.state is! AuthLoadingState && cubit.state is! PasswordResetSuccessState) {
        cubit.resetState();
      }
    });

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is PasswordResetSuccessState) {
          GoRouter.of(context).go(AppRouter.passwordChangedSuccessfully);
        } else if (state is PasswordResetErrorState || state is AuthErrorState) {
          final msg = state is PasswordResetErrorState ? state.message : (state as AuthErrorState).message;
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text(msg),
              backgroundColor: AppColors.errorRed,
              behavior: SnackBarBehavior.floating,
            ));
        }
      },
      child: child,
    );
  }
}
