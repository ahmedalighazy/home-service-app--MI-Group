import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/core/di/injection.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/features/auth/logic/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/logic/states/auth_state.dart';
import 'package:home_service_app/features/auth/presentation/widgets/common/auth_back_button.dart';
import 'package:home_service_app/features/auth/presentation/widgets/common/auth_gradient_button.dart';
import 'package:home_service_app/features/auth/presentation/widgets/otp/otp_circles_row.dart';

class VerifyResetCodeScreen extends StatefulWidget {
  final String email;
  const VerifyResetCodeScreen({super.key, required this.email});

  @override
  State<VerifyResetCodeScreen> createState() => _VerifyResetCodeScreenState();
}

class _VerifyResetCodeScreenState extends State<VerifyResetCodeScreen>
    with SingleTickerProviderStateMixin {
  static const int _length = 6;

  final TextEditingController _ctrl = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool _hasError = false;
  bool _isSuccess = false;

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
      TweenSequenceItem(tween: Tween(begin: 0, end: -8), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -8, end: 8), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8, end: -8), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -8, end: 8), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8, end: 0), weight: 1),
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
      if (_hasError) setState(() => _hasError = false);
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (_) => getIt<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ResetCodeVerified) {
            setState(() {
              _isSuccess = true;
            });
            final navigator = Navigator.of(context);
            Future.delayed(const Duration(milliseconds: 400), () {
              if (mounted) {
                navigator.pushReplacementNamed(
                  AppRoutes.setNewPassword,
                  arguments: {
                    'email': widget.email,
                    'code': _digits,
                  },
                );
              }
            });
          } else if (state is AuthError) {
            setState(() {
              _hasError = true;
            });
            _shakeCtrl.forward(from: 0.0);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.errorRed,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;
          final isArabic = Localizations.localeOf(context).languageCode == 'ar';

          return Scaffold(
            backgroundColor: AppColors.white,
            resizeToAvoidBottomInset: true,
            body: Directionality(
              textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
              child: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        reverse: true,
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 16.h),

                            // ── Back button ────────────────────────────
                            Align(
                              alignment: isArabic
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: AuthBackButton(
                                onTap: () => Navigator.pop(context),
                              ),
                            ),

                            SizedBox(height: 40.h),

                            // ── Title ──────────────────────────────────
                            Text(
                              isArabic ? 'تحقق من بريدك' : 'Verify Email',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.ibmPlexSansArabic(
                                color: AppColors.dark,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 10.h),

                            Text(
                              AppStrings.enterVerificationCode,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.ibmPlexSansArabic(
                                color: AppColors.secondaryText,
                                fontSize: 13.sp,
                                height: 1.5,
                              ),
                            ),

                            SizedBox(height: 4.h),

                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: Text(
                                widget.email,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.ibmPlexSansArabic(
                                  color: AppColors.greenPrimary,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            SizedBox(height: 44.h),

                            // ── OTP circles ────────────────────────────
                            OtpCirclesRow(
                              digits: _digits,
                              length: _length,
                              hasError: _hasError,
                              isSuccess: _isSuccess,
                              shakeAnimation: _shakeAnim,
                              onTap: () => _focusNode.requestFocus(),
                            ),

                            SizedBox(height: 32.h),

                            if (_hasError)
                              Padding(
                                padding: EdgeInsets.only(bottom: 12.h),
                                child: Text(
                                  isArabic
                                      ? 'الرمز غير صحيح، يرجى المحاولة مرة أخرى'
                                      : 'Incorrect code, please try again',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.ibmPlexSansArabic(
                                    color: AppColors.errorRed,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),

                            // ── Confirm button ─────────────────────────
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: _digits.length == _length
                                  ? AuthGradientButton(
                                      key: const ValueKey('btn'),
                                      label: isArabic ? 'تأكيد' : 'Confirm',
                                      isLoading: isLoading,
                                      isSuccess: _isSuccess,
                                      onPressed: () => _onVerify(context),
                                    )
                                  : SizedBox(
                                      height: 54.h,
                                      key: const ValueKey('empty'),
                                    ),
                            ),

                            SizedBox(height: 16.h),
                          ],
                        ),
                      ),
                    ),

                    // ── Hidden keyboard capture ────────────────────────
                    SizedBox(
                      height: 0,
                      child: TextField(
                        controller: _ctrl,
                        focusNode: _focusNode,
                        keyboardType: TextInputType.number,
                        maxLength: _length,
                        showCursor: false,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          counterText: '',
                        ),
                        style: const TextStyle(
                            color: Colors.transparent, fontSize: 1),
                        cursorColor: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
