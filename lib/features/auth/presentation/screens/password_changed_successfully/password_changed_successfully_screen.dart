import 'package:flutter/material.dart';
import 'package:home_service_app/core/routes/app_routes.dart';

class PasswordChangedSuccessfullyScreen extends StatelessWidget {
  const PasswordChangedSuccessfullyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF727A89), // لون الخلفية الرمادي المزرق
      body: Directionality(
        textDirection: TextDirection.rtl, // تحديد اتجاه النصوص إلى العربية
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // النص العلوي الباهت خارج البطاقة
                Text(
                  'نجاح تغيير الباسورد',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withValues(alpha: 0.4),
                  ),
                ),
                const SizedBox(height: 20),

                // البطاقة البيضاء الرئيسية
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32), // حواف دائرية كبيرة للبطاقة
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // حاوية الأيقونة الدائرية الخضراء
                      Container(
                        width: 90,
                        height: 90,
                        decoration: const BoxDecoration(
                          color: Color(0xFFEAFAF1), // خلفية خضراء فاتحة جداً
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check_circle_outline_rounded,
                          color: Color(0xFF1A924E), // لون علامة الصح الخضراء
                          size: 50,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // العنوان الرئيسي
                      const Text(
                        'تم تغيير كلمة المرور بنجاح',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2B2F3E),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // النص الفرعي
                      const Text(
                        'يمكنك الآن تسجيل الدخول بكلمة المرور الجديدة',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF6A7180),
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // زر تسجيل الدخول بالتدرج اللوني
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF189CB7), // اللون الفاتح على اليسار
                              Color(0xFF033C48), // اللون الغامق على اليمين
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(50), // حواف دائرية كاملة للزر
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF033C48).withValues(alpha: 0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              AppRoutes.login,
                              (route) => false,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: const Text(
                            'تسجيل الدخول',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
