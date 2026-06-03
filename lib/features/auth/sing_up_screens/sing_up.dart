import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'otp_screen/otp_screen.dart';
import '../presentation/widgets/auth_back_button.dart';
import '../presentation/widgets/auth_social_button.dart';

class SingUp extends StatelessWidget {
  const SingUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 16.h),
                  
                  // ── Back button ──────────────────────────
                  Align(
                    alignment: Alignment.centerRight,
                    child: AuthBackButton(
                      onTap: () => Navigator.pop(context),
                    ),
                  ),

                  SizedBox(height: 32.h),
                  
                  // كلمة الترحيب
                  Text(
                    'أهلاً بعودتك',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E293B),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32.h),

                  // حقل إدخال رقم الهاتف المصمم
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        // كود الدولة والعلم (جهة اليمين بسبب محاذاة RTL)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Row(
                            children: [
                              Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 20.sp),
                              SizedBox(width: 4.w),
                              Text(
                                '+974',
                                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 8.w),
                              Text('🇶🇦', style: TextStyle(fontSize: 18.sp)), // علم قطر كمثال
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                          child: const VerticalDivider(color: Color(0xFFE2E8F0), width: 1),
                        ),
                        // حقل كتابة رقم الهاتف
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.phone,
                            textAlign: TextAlign.left, // الأرقام دائماً تُكتب يسار-يمين LTR
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                              hintText: '5123 4567',
                              hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const OtpScreen(phoneNumber: '+974 5123 4567'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0E5C6C),
                      foregroundColor: Colors.cyan,
                      minimumSize: Size(double.infinity, 50.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'أرسل الكود',
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // خط الفاصل (أو باستخدام)
                  Row(
                    children: [
                      Expanded(child: Divider(color: Colors.grey.shade300)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          'أو باستخدام',
                          style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.grey.shade300)),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  // أزرار التواصل الاجتماعي
                  AuthSocialButton(
                    icon: Icons.g_mobiledata,
                    text: 'تسجيل عبر Google',
                    onTap: () {},
                  ),
                  SizedBox(height: 12.h),
                  AuthSocialButton(
                    icon: Icons.apple,
                    text: 'تسجيل عبر Apple',
                    onTap: () {},
                  ),
                  SizedBox(height: 24.h),

                  // المتابعة كضيف
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'المتابعة كضيف',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF0F7F90),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // تسجيل الدخول
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('لديك حساب بالفعل؟ ', style: TextStyle(color: Colors.grey, fontSize: 13.sp)),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'تسجيل الدخول',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: const Color(0xFF0F7F90),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40.h),

                  // نص الشروط والأحكام في الأسفل
                  Text(
                    'بتسجيل الدخول، أنت توافق على الشروط والأحكام وسياسة الخصوصية',
                    style: TextStyle(color: Colors.grey, fontSize: 10.sp),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
