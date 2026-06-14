import 'package:flutter/material.dart';
import 'package:home_service_app/features/auth/presentation/screens/check_your_email/widgets/check_your_email_widgets.dart';
import '../../../../profile/presentation/widgets/custom_buttom.dart';
import 'logic/check_your_email_logic.dart';


class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  late VerificationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VerificationController();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.withOpacity(0.2)),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_forward, color: Colors.black87),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
                const Spacer(flex: 1),


                Center(
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: Icon(
                          Icons.mail_outline_rounded,
                          size: 100,
                          color: const Color(0xFF1B85A6).withOpacity(0.8),
                        ),
                      ),
                      Positioned(
                        right: 15,
                        top: 15,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: const Color(0xFF1B85A6),
                          child: Transform.rotate(
                            angle: -0.5,
                            child: const Icon(Icons.send_rounded, size: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                const Text(
                  "تحقق من بريدك الالكتروني",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(fontSize: 14, color: Colors.grey, height: 1.5),
                      children: [
                        TextSpan(text: "تم إرسال رابط إعادة تعيين إلى "),
                        TextSpan(
                          text: "ahmed...@gmail.com",
                          style: TextStyle(color: Color(0xFF1B85A6), fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: "\nأدخل الرمز المكون من 4 أرقام المذكور في البريد الإلكتروني"),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) {
                    return OtpCircleField(
                      controller: _controller.controllers[index],
                      focusNode: _controller.focusNodes[index],
                      onChanged: (value) => _controller.handleOtpChange(value, index),
                    );
                  }),
                ),
                const SizedBox(height: 32),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "لم تتلقي الكود بعد ؟ ",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    GestureDetector(
                      onTap: _controller.resendCode,
                      child: const Text(
                        "أعد ارسال الكود",
                        style: TextStyle(
                          color: Color(0xFF1B85A6),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(flex: 2),


                CustomButton(
                  backgroundColor: const Color(0xFF1B85A6),
                  textColor: Colors.white,
                  text: "تأكيد",
                  onPressed: _controller.verifyCode,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}