import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/features/auth/logic/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/logic/states/auth_state.dart';
import '../../../core/di/injection.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/themes/colors/app_colors.dart';
import '../../../core/themes/image/app_assets.dart';
import '../../../core/utils/l10n/app_strings.dart';
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
  static const int _length = 6;

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
      final capped =
          raw.length > _length ? raw.substring(0, _length) : raw;
      if (_ctrl.text != capped) {
        _ctrl.value = _ctrl.value.copyWith(
          text: capped,
          selection: TextSelection.collapsed(offset: capped.length),
        );
        return;
      }
      if (_fieldState == OtpFieldState.error) {
        setState(() => _fieldState = OtpFieldState.idle);
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (_) => getIt<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: _handleState,
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return Scaffold(
            backgroundColor: AppColors.white,
            resizeToAvoidBottomInset: true,
            body: Directionality(
              textDirection: TextDirection.rtl,
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

                            // ── Back button ──────────────────────────
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  width: 40.w,
                                  height: 40.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: AppColors.borderInputs),
                                    color: AppColors.white,
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 15.sp,
                                    color: AppColors.primaryText,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 40.h),

                            // ── Title ────────────────────────────────
                            Text(
                              AppStrings.checkEmail,
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

                            // ── Email display ────────────────────────
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

                            SizedBox(height: 32.h),

                            // ── Message illustration ─────────────────
                            Center(
                              child: Image.asset(
                                AppAssets.message,
                                width: 180.w,
                                height: 180.w,
                                fit: BoxFit.contain,
                              ),
                            ),

                            SizedBox(height: 32.h),

                            // ── OTP circles ──────────────────────────
                            OtpInputRow(
                              digits: _digits,
                              length: _length,
                              fieldState: _fieldState,
                              shakeAnimation: _shakeAnim,
                              onTap: () => _focusNode.requestFocus(),
                            ),

                            SizedBox(height: 32.h),

                            // ── Inline error message ─────────────────
                            if (_fieldState == OtpFieldState.error)
                              Padding(
                                padding: EdgeInsets.only(bottom: 12.h),
                                child: Text(
                                  'الرمز غير صحيح، يرجى المحاولة مرة أخرى',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.ibmPlexSansArabic(
                                    color: AppColors.errorRed,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),

                            // ── Confirm button ───────────────────────
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: _digits.length == _length
                                  ? OtpConfirmButton(
                                      key: const ValueKey('btn'),
                                      label: AppStrings.confirm,
                                      isLoading: isLoading,
                                      isSuccess:
                                          _fieldState == OtpFieldState.success,
                                      onPressed: () => _onVerify(context),
                                    )
                                  : SizedBox(
                                      height: 54.h,
                                      key: const ValueKey('empty')),
                            ),

                            SizedBox(height: 16.h),
                          ],
                        ),
                      ),
                    ),

                    // ── Hidden text input ────────────────────────────
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

  void _handleState(BuildContext context, AuthState state) {
    if (state is ResetCodeVerified) {
      setState(() => _fieldState = OtpFieldState.success);
      final navigator = Navigator.of(context);
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          navigator.pushReplacementNamed(
            AppRoutes.setNewPassword,
            arguments: {'email': widget.email, 'code': _digits},
          );
        }
      });
    } else if (state is AuthError) {
      setState(() => _fieldState = OtpFieldState.error);
      _shakeCtrl.forward(from: 0.0);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text(state.message),
          backgroundColor: AppColors.errorRed,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ));
    }
  }
}
