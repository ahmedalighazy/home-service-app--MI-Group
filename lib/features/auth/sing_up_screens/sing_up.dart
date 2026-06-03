import 'package:flutter/material.dart';
import 'otp_screen.dart';

class SingUp extends StatelessWidget {
  const SingUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 60),
                // كلمة الترحيب
                const Text(
                  'أهلاً بعودتك',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // حقل إدخال رقم الهاتف المصمم
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      // كود الدولة والعلم (جهة اليمين بسبب محاذاة RTL)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          children: [
                            const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                            const SizedBox(width: 4),
                            const Text(
                              '+974',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 8),
                            const Text('🇶🇦', style: TextStyle(fontSize: 18)), // علم قطر كمثال
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                        child: VerticalDivider(color: Color(0xFFE2E8F0), width: 1),
                      ),
                      // حقل كتابة رقم الهاتف
                      const Expanded(
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          textAlign: TextAlign.left, // الأرقام دائماً تُكتب يسار-يمين LTR
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 16),
                            hintText: '5123 4567',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

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
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'أرسل الكود',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 24),

                // خط الفاصل (أو باستخدام)
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'أو باستخدام',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                  ],
                ),
                const SizedBox(height: 24),

                // أزرار التواصل الاجتماعي
                _buildSocialButton(
                  icon: Icons.g_mobiledata,
                  text: 'تسجيل عبر Google',
                  onTap: () {},
                ),
                const SizedBox(height: 12),
                _buildSocialButton(
                  icon: Icons.apple,
                  text: 'تسجيل عبر Apple',
                  onTap: () {},
                ),
                const SizedBox(height: 24),

                // المتابعة كضيف
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'المتابعة كضيف',
                    style: TextStyle(
                      color: Color(0xFF0F7F90),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // تسجيل الدخول
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('لديك حساب بالفعل؟ ', style: TextStyle(color: Colors.grey)),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'تسجيل الدخول',
                        style: TextStyle(
                          color: Color(0xFF0F7F90),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),

                // نص الشروط والأحكام في الأسفل
                const Text(
                  'بتسجيل الدخول، أنت توافق على الشروط والأحكام وسياسة الخصوصية',
                  style: TextStyle(color: Colors.grey, fontSize: 10),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.grey.shade200),
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28, color: Colors.black87),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

