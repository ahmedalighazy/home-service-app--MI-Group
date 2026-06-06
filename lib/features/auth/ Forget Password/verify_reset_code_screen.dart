import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/features/auth/logic/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/logic/states/auth_state.dart';
import '../../../core/di/injection.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/themes/colors/app_colors.dart';
import '../../../core/themes/image/app_assets.dart';
import '../../../core/themes/text/app_text.dart';
import '../../../core/utils/l10n/app_strings.dart';
import '../presentation/widgets/auth_back_button.dart';
import '../presentation/widgets/otp_confirm_button.dart';
import '../presentation/widgets/otp_input_row.dart';

class VerifyResetCodeScreen extends StatefulWidget {
  final String email;
  const VerifyResetCodeScreen({super.key, required this.email});

  @override
  State<VerifyResetCodeScreen> createState() => _VerifyResetCodeScreenState();
}

class _VerifyResetCodeScreenState extends State<VerifyResetCodeScreen>
    with SingleTickerProviderStateMixin {
  // Design uses 4-digit reset code
  static const int _length = 4;

  final TextEditingController _ctrl = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  OtpFieldState _fieldState = OtpFieldState.idle;

  late AnimationController _shakeCtrl;
  late Animation<double> _shakeAnim;

  @override
  void initState() {
    super.initState();

    _shakeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _shakeAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -8.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -8.0, end: 8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8.0, end: -8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -8.0, end: 8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8.0, end: 0.0), weight: 1),
    ]).animate(CurvedAnimation(parent: _shakeCtrl, curve: Curves.easeInOut));

    _ctrl.addListener(() {
      final raw = _ctrl.text.replaceAll(RegExp(r'\D'), '');
      final capped = raw.length > _length ? raw.substring(0, _length) : raw;
      if (_ctrl.text != capped) {
        _ctrl.value = _ctrl.value.copyWith(
          text: capped,
          selection: TextSelection.collapsed(offset: capped.length),
        );
        return;
      }
      if (_fieldState == OtpFieldState.error) {
        setState(() => _fieldState = OtpFieldState.idle);
      } else {
        setState(() {}); // rebuild to reflect new digit count
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _shakeCtrl.dispose();
    _ctrl.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  String get _digits => _ctrl.text;

  void _onVerify(BuildContext context) {
    if (_digits.length < _length) return;
    _focusNode.unfocus();
    context.read<AuthCubit>().verifyResetCode(widget.email, _digits);
  }

  void _onResend(BuildContext context) {
    setState(() {
      _ctrl.clear();
      _fieldState = OtpFieldState.idle;
    });
    context.read<AuthCubit>().sendResetCode(widget.email);
    _focusNode.requestFocus();
  }

  /// Truncate long email: ahmed...@gmail.com
  String _truncateEmail(String email) {
    final atIndex = email.indexOf('@');
    if (atIndex <= 5) return email;
    return '${email.substring(0, 5)}...${email.substring(atIndex)}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (_) => getIt<AuthCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        resizeToAvoidBottomInset: true,
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: _handleState,
          builder: (context, state) {
            final isLoading = state is AuthLoading;

            return Directionality(
              textDirection: TextDirection.rtl,
              child: SafeArea(
                child: Column(
                  children: [
                    // ── Scrollable content ───────────────────────────
                    Expanded(
                      child: SingleChildScrollView(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 16.h),

                            // ── Back button ──────────────────────────
                            Align(
                              alignment: Alignment.centerLeft,
                              child: AuthBackButton(onTap: () => context.pop()),
                            ),

                            SizedBox(height: 24.h),

                            // ── Illustration with glow ───────────────
                            Center(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Soft teal glow behind image
                                  Container(
                                    width: 180.w,
                                    height: 180.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: RadialGradient(
                                        colors: [
                                          AppColors.greenPrimary.withValues(
                                            alpha: 0.12,
                                          ),
                                          AppColors.white.withValues(
                                            alpha: 0.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Image.asset(
                                    AppAssets.message,
                                    width: 150.w,
                                    height: 150.w,
                                    fit: BoxFit.contain,
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 28.h),

                            // ── Title ────────────────────────────────
                            Text(
                              AppStrings.checkEmail,
                              textAlign: TextAlign.center,
                              style: AppText.ibmHeading22(
                                color: AppColors.dark,
                              ),
                            ),

                            SizedBox(height: 12.h),

                            // ── Subtitle with teal email ─────────────
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: AppText.ibmDescription14(
                                  color: AppColors.secondaryText,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'تم إرسال رابط إعادة تعيين إلى ',
                                  ),
                                  TextSpan(
                                    text: _truncateEmail(widget.email),
                                    style: AppText.ibmLink13(
                                      color: AppColors.greenPrimary,
                                    ),
                                  ),
                                  const TextSpan(text: '\n'),
                                  TextSpan(
                                    text:
                                        'أدخل الرمز المكون من 4 أرقام لتأكيد البريد الإلكتروني',
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 36.h),

                            // ── 4-digit OTP circles ──────────────────
                            OtpInputRow(
                              digits: _digits,
                              length: _length,
                              fieldState: _fieldState,
                              shakeAnimation: _shakeAnim,
                              onTap: () => _focusNode.requestFocus(),
                            ),

                            SizedBox(height: 20.h),

                            // ── Inline error ─────────────────────────
                            if (_fieldState == OtpFieldState.error)
                              Padding(
                                padding: EdgeInsets.only(bottom: 8.h),
                                child: Text(
                                  'الرمز غير صحيح، يرجى المحاولة مرة أخرى',
                                  textAlign: TextAlign.center,
                                  style: AppText.ibmError12(),
                                ),
                              ),

                            SizedBox(height: 12.h),

                            // ── Resend row ───────────────────────────
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${AppStrings.resendCodePromptAlt} ',
                                  style: AppText.ibmDescription14(
                                    color: AppColors.secondaryText,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: isLoading
                                      ? null
                                      : () => _onResend(context),
                                  child: Text(
                                    AppStrings.resendCodeLink,
                                    style:
                                        AppText.ibmLink13(
                                          color: isLoading
                                              ? AppColors.placeholder
                                              : AppColors.greenPrimary,
                                        ).copyWith(
                                          decoration: TextDecoration.underline,
                                          decorationColor:
                                              AppColors.greenPrimary,
                                        ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 32.h),
                          ],
                        ),
                      ),
                    ),

                    // ── Confirm button pinned at bottom ──────────────
                    Padding(
                      padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
                      child: OtpConfirmButton(
                        label: AppStrings.confirm,
                        isLoading: isLoading,
                        isSuccess: _fieldState == OtpFieldState.success,
                        onPressed: _digits.length == _length
                            ? () => _onVerify(context)
                            : () {},
                        isEnabled: _digits.length == _length,
                      ),
                    ),

                    // ── Hidden keyboard input ────────────────────────
                    SizedBox(
                      width: 1,
                      height: 1,
                      child: Opacity(
                        opacity: 0,
                        child: TextField(
                          controller: _ctrl,
                          focusNode: _focusNode,
                          keyboardType: TextInputType.number,
                          maxLength: _length,
                          showCursor: false,
                          enableInteractiveSelection: false,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            counterText: '',
                          ),
                          style: const TextStyle(
                            color: Colors.transparent,
                            fontSize: 0,
                          ),
                          cursorColor: Colors.transparent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _handleState(BuildContext context, AuthState state) {
    if (state is ResetCodeVerified) {
      setState(() => _fieldState = OtpFieldState.success);
      final router = GoRouter.of(context);
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          router.go(
            AppRouter.setNewPassword,
            extra: {'email': widget.email, 'code': _digits},
          );
        }
      });
    } else if (state is ResetCodeError) {
      setState(() => _fieldState = OtpFieldState.error);
      _shakeCtrl.forward(from: 0.0);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              state.message,
              style: AppText.ibmDescription14(color: AppColors.white),
            ),
            backgroundColor: AppColors.errorRed,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
    } else if (state is AuthError) {
      setState(() => _fieldState = OtpFieldState.error);
      _shakeCtrl.forward(from: 0.0);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              state.message,
              style: AppText.ibmDescription14(color: AppColors.white),
            ),
            backgroundColor: AppColors.errorRed,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
    } else if (state is ResetCodeSent) {
      // Resend success feedback
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              'تم إعادة إرسال الرمز بنجاح',
              style: AppText.ibmDescription14(color: AppColors.white),
            ),
            backgroundColor: AppColors.greenPrimary,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
    }
  }
}
