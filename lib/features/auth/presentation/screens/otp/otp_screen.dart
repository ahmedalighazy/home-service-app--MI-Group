import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/core/di/injection.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/features/auth/logic/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/logic/states/auth_state.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late final AuthCubit _authCubit;
  String? _phoneNumber;

  // منطق المؤقت التنازلي
  Timer? _timer;
  int _startSeconds = 59;
  bool _canResend = false;

  // منطق حالات الشاشة (الخطأ والنجاح)
  bool _hasError = false;
  bool _isButtonActive = false;

  @override
  void initState() {
    super.initState();
    _authCubit = getIt<AuthCubit>();
    _startTimer();
    _otpController.addListener(_onOtpChanged);

    // فتح لوحة المفاتيح تلقائياً عند فتح الشاشة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
      // Get phone number from arguments
      _phoneNumber = ModalRoute.of(context)?.settings.arguments as String?;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // بدء تشغيل المؤقت
  void _startTimer() {
    _canResend = false;
    _startSeconds = 59;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_startSeconds == 0) {
        setState(() {
          _canResend = true;
          _timer?.cancel();
        });
      } else {
        setState(() {
          _startSeconds--;
        });
      }
    });
  }

  // تتبع التغيرات في المدخلات لتمكين زر التأكيد
  void _onOtpChanged() {
    setState(() {
      _hasError = false; // تصفير حالة الخطأ بمجرد البدء في الكتابة مجدداً
      _isButtonActive = _otpController.text.length == 6;
    });
  }

  // منطق التحقق من الرمز المدخل عند الضغط على زر "تأكيد"
  void _verifyOtp() {
    if (_otpController.text.length == 6) {
      _authCubit.verifyOtp(
        phoneNumber: _phoneNumber ?? '+974XXXXXXXX',
        otp: _otpController.text,
      );
    }
  }

  // تنسيق وقت المؤقت ليظهر بصيغة 0:59
  String _formatTime(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _authCubit,
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is OtpVerified) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(AppStrings.otpVerifiedSuccess),
                backgroundColor: const Color(0xFF0F6070),
              ),
            );
            // Navigate to Complete Profile screen
            Future.delayed(const Duration(milliseconds: 500), () {
              if (!context.mounted) return;
              Navigator.of(context).pushNamed(
                AppRoutes.completeProfile,
                arguments: _phoneNumber ?? '+974XXXXXXXX',
              );
            });
          } else if (state is AuthError) {
            setState(() {
              _hasError = true;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: const Color(0xFFE57373),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),

                    // زر الرجوع العلوي
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          'assets/images/Frame 2147225973.png',
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ),

                    const SizedBox(height: 48),

                    // نصوص التأكيد ورقم الهاتف
                    Text(
                      AppStrings.otpVerificationTitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D2D2D),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      AppStrings.otpVerificationSubtitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '+974XXXXXXXX',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF53B2C7),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // حقول الـ OTP الستة (UI) المربوطة بالحقل المخفي
                    GestureDetector(
                      onTap: () {
                        _focusNode.requestFocus(); // فتح الكيبورد عند الضغط على الحقول
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // حقل إدخال مخفي بالخلفية لجمع المدخلات بسلاسة
                          Opacity(
                            opacity: 0,
                            child: SizedBox(
                              height: 50,
                              child: TextField(
                                controller: _otpController,
                                focusNode: _focusNode,
                                keyboardType: TextInputType.number,
                                maxLength: 6,
                                buildCounter: (context, {required currentLength, required isFocused, maxLength}) => null,
                              ),
                            ),
                          ),

                          // الدوائر الستة الظاهرة أمام المستخدم
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(6, (index) {
                              String char = '';
                              if (_otpController.text.length > index) {
                                char = _otpController.text[index];
                              }

                              // تحديد لون الحدود بناءً على حالة الإدخال أو الخطأ
                              Color borderColor = Colors.grey.shade200;
                              if (_hasError) {
                                borderColor = const Color(0xFFE57373); // أحمر في حالة الخطأ
                              } else if (_otpController.text.length == index && _focusNode.hasFocus) {
                                borderColor = const Color(0xFF53B2C7); // لبني عند التحديد النشط
                              } else if (char.isNotEmpty) {
                                borderColor = const Color(0xFF53B2C7); // لبني عند وجود رقم
                              }

                              // تحديد لون النص الداخلي
                              Color textColor = _hasError ? const Color(0xFFE57373) : const Color(0xFF53B2C7);

                              return Container(
                                width: 46,
                                height: 46,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: borderColor, width: 1.5),
                                  color: Colors.white,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  char,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // المؤشر الزمني
                    Text(
                      _formatTime(_startSeconds),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // إعادة إرسال الكود
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.resendCodePromptAlt,
                          style: const TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                        TextButton(
                          onPressed: _canResend
                              ? () {
                            _startTimer();
                            setState(() {
                              _hasError = false;
                              _otpController.clear();
                            });
                          }
                              : null,
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            AppStrings.resendCodeLink,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: _canResend ? const Color(0xFF53B2C7) : Colors.grey.shade400,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 48),

                    // زر التأكيد
                    ElevatedButton(
                      onPressed: _isButtonActive && state is! AuthLoading ? _verifyOtp : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0F6070),
                        disabledBackgroundColor: const Color(0xFFECEFF1), // لون رمادي فاتح للزر غير النشط
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        elevation: _isButtonActive ? 2 : 0,
                      ),
                      child: state is AuthLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(
                              AppStrings.confirm,
                              style: TextStyle(
                                fontSize: 16,
                                color: _isButtonActive ? Colors.white : Colors.grey.shade400,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                    const SizedBox(height: 24),
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