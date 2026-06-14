import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/routes/app_routes.dart';



class PasswordInputField extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final Color borderColor;
  final VoidCallback onObscurePressed;

  const PasswordInputField({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
    required this.obscureText,
    required this.borderColor,
    required this.onObscurePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: borderColor,
              width: 1.5,
            ),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              prefixIcon: IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: Colors.grey,
                ),
                onPressed: onObscurePressed,
              ),
            ),
          ),
        ),
      ],
    );
  }
}


class SetNewPasswordErrorText extends StatelessWidget {
  const SetNewPasswordErrorText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 8),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          "كلمتا المرور غير متطابقتين",
          style: TextStyle(
            color: Color(0xFFE05C5C),
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class SetNewPasswordButton extends StatelessWidget {
  final bool isSuccess;
  final bool isLoading;
  final VoidCallback? onPressed;

  const SetNewPasswordButton({
    super.key,
    required this.isSuccess,
    required this.isLoading,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: isSuccess && !isLoading ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSuccess ? const Color(0xFF0F687D) : const Color(0xFFE9F0F4),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: isLoading
            ? const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          ),
        )
            : Text(
          "تأكيد",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isSuccess ? Colors.white : const Color(0xFF98A9BC),
          ),
        ),
      ),
    );
  }
}


class SetNewPasswordSuccessDialog extends StatelessWidget {
  final BuildContext parentContext;

  const SetNewPasswordSuccessDialog({
    super.key,
    required this.parentContext,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8F5F0),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: const BoxDecoration(
                      color: Color(0xFF3B8766),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 42,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                "تم تغيير كلمة المرور بنجاح",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "يمكنك الآن تسجيل الدخول بكلمة المرور الجديدة",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (parentContext.mounted) {
                      GoRouter.of(parentContext).go(AppRouter.signIn);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F687D),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    "تسجيل الدخول",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}