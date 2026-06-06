import 'dart:async';
import 'package:flutter/material.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';

class EmailVerificationScreen extends StatefulWidget {
  // مسارات الصور المخصصة كمتغيرات لتسهيل تعديلها
  final String envelopeImagePath; // مسار صورة المغلف/البريد الإلكتروني
  final String backArrowImagePath; // مسار أيقونة الرجوع الدائرية

  const EmailVerificationScreen({
    super.key,
    this.envelopeImagePath = 'assets/images/illustration-message.png', // المسار الافتراضي للصورة التوضيحية
    this.backArrowImagePath = 'assets/images/Frame 2147225973.png', // المسار الافتراضي لأيقونة الرجوع
  });

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  // إدارة حالة المؤقت لإعادة الإرسال
  Timer? _timer;
  int _startSeconds = 59;
  bool _canResend = false;

  // منطق تفعيل الزر وحالة الخطأ
  bool _isButtonActive = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _startTimer();

    // فتح لوحة المفاتيح تلقائياً فور دخول الشاشة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // بدء تشغيل مؤقت إعادة الإرسال
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

  // التحقق من طول النص المدخل لتفعيل زر التأكيد (4 أرقام فقط)
  void _onOtpChanged() {
    setState(() {
      _hasError = false;
      _isButtonActive = _otpController.text.length == 4;
    });
  }

  // التحقق من الكود المدخل ومحاكاة النتيجة
  void _verifyOtp() {
    if (_otpController.text.length == 4) {
      // Accept any 4-digit code
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppStrings.emailVerifiedSuccess),
          backgroundColor: const Color(0xFF0F6070),
        ),
      );
      // Navigate to Set New Password screen
      Future.delayed(const Duration(milliseconds: 500), () {
        if (!mounted) return;
        if (!context.mounted) return;
        Navigator.pushNamed(
          context,
          AppRoutes.setNewPassword,
          arguments: {'email': 'ahmed...@gmail.com', 'code': _otpController.text},
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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

              const SizedBox(height: 24),

              // صورة مغلف البريد الإلكتروني (Illustration كمسار)
              Center(
                child: Image.asset(
                  widget.envelopeImagePath,
                  height: 200,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    // بديل مرئي يحاكي مغلف البريد الإلكتروني في حال عدم توفر الصورة
                    return SizedBox(
                      height: 200,
                      width: 250,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(Icons.mail_outline, size: 100, color: const Color(0xFF1EA1B8).withValues(alpha: 0.8)),
                          Positioned(
                            top: 30,
                            right: 30,
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: const Color(0xFF1EA1B8),
                              child: Transform.rotate(
                                angle: -0.5,
                                child: const Icon(Icons.send, size: 16, color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // نصوص التحقق والعناوين الإرشادية
              const Text(
                'تحقق من بريدك الالكتروني',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D2D2D),
                ),
              ),
              const SizedBox(height: 12),

              // عرض نص البريد الإلكتروني بلون مخصص ومميز
              const Text(
                'تم إرسال رابط إعادة تعيين إلى',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
              const Text(
                'ahmed...@gmail.com',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF53B2C7),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'أدخل الرمز المكون من 4 أرقام المذكور في البريد الإلكتروني',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey, height: 1.4),
              ),

              const SizedBox(height: 32),

              // حقول الـ OTP الأربعة (UI) المربوطة بالحقل المخفي
              GestureDetector(
                onTap: () {
                  _focusNode.requestFocus();
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // حقل إدخال مخفي يجمع المدخلات بسلاسة
                    Opacity(
                      opacity: 0.01, // جعله شبه شفاف بدلاً من مخفي تماماً
                      child: SizedBox(
                        height: 60,
                        child: TextField(
                          controller: _otpController,
                          focusNode: _focusNode,
                          keyboardType: TextInputType.number,
                          maxLength: 4, // 4 أرقام فقط كما في التصميم الجديد
                          buildCounter: (context, {required currentLength, required isFocused, maxLength}) => null,
                          onChanged: (value) {
                            _onOtpChanged();
                          },
                          autofocus: true,
                        ),
                      ),
                    ),

                    // الدوائر الأربعة الظاهرة للمستخدم
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(4, (index) {
                        String char = '';
                        if (_otpController.text.length > index) {
                          char = _otpController.text[index];
                        }

                        // تحديد لون الحدود بناءً على حالة الإدخال أو التركيز النشط
                        Color borderColor = Colors.grey.shade100;
                        if (_hasError) {
                          borderColor = const Color(0xFFE57373); // أحمر في حالة الخطأ
                        } else if (_otpController.text.length == index && _focusNode.hasFocus) {
                          borderColor = const Color(0xFF53B2C7); // تحديد نشط
                        } else if (char.isNotEmpty) {
                          borderColor = const Color(0xFF53B2C7); // معبأ بالرقم
                        }

                        Color textColor = _hasError ? const Color(0xFFE57373) : const Color(0xFF53B2C7);

                        return Container(
                          width: 58,
                          height: 58,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: borderColor, width: 1.5),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.01),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                )
                              ]
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            char,
                            style: TextStyle(
                              fontSize: 20,
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

              const SizedBox(height: 32),

              // منطق إعادة الإرسال
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'لم تتلقي الكود بعد ؟ ',
                    style: TextStyle(fontSize: 13, color: Colors.grey),
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
                      'أعد ارسال الكود',
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

              // زر التأكيد السفلي النشط فقط عند تعبئة الـ 4 خانات
              ElevatedButton(
                onPressed: _isButtonActive ? _verifyOtp : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F6070),
                  disabledBackgroundColor: const Color(0xFFECEFF1),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  elevation: _isButtonActive ? 2 : 0,
                ),
                child: Text(
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
  }
}