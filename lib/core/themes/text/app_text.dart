import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../colors/app_colors.dart';

class AppText {
  // --- Inter Font Styles ---
  static TextStyle regularText({
    required Color color,
    required double fontSize,
  }) {
    return GoogleFonts.inter(
      color: color,
      fontSize: fontSize.sp,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle mediumText({
    required Color color,
    required double fontSize,
  }) {
    return GoogleFonts.inter(
      color: color,
      fontSize: fontSize.sp,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle semiBoldText({
    required Color color,
    required double fontSize,
  }) {
    return GoogleFonts.inter(
      color: color,
      fontSize: fontSize.sp,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle boldText({required Color color, required double fontSize}) {
    return GoogleFonts.inter(
      color: color,
      fontSize: fontSize.sp,
      fontWeight: FontWeight.w700,
    );
  }

  // --- Roboto Font Styles ---
  static TextStyle regularTextRoboto({
    required Color color,
    required double fontSize,
  }) {
    return GoogleFonts.roboto(
      color: color,
      fontSize: fontSize.sp,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle boldTextRoboto({
    required Color color,
    required double fontSize,
  }) {
    return GoogleFonts.roboto(
      color: color,
      fontSize: fontSize.sp,
      fontWeight: FontWeight.bold,
    );
  }

  // --- IBM Plex Sans Arabic Font Styles (Arabic General-Purpose) ---

  static TextStyle regularIbm({
    required Color color,
    required double fontSize,
  }) {
    return GoogleFonts.ibmPlexSansArabic(
      color: color,
      fontSize: fontSize.sp,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle mediumIbm({required Color color, required double fontSize}) {
    return GoogleFonts.ibmPlexSansArabic(
      color: color,
      fontSize: fontSize.sp,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle semiBoldIbm({
    required Color color,
    required double fontSize,
  }) {
    return GoogleFonts.ibmPlexSansArabic(
      color: color,
      fontSize: fontSize.sp,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle boldIbm({required Color color, required double fontSize}) {
    return GoogleFonts.ibmPlexSansArabic(
      color: color,
      fontSize: fontSize.sp,
      fontWeight: FontWeight.w700,
    );
  }

  // --- Semantic IBM Plex Sans Arabic UI Styles matching the designed screens with Arabic & English translations ---

  /// Headline style for screen main titles
  ///
  /// **Arabic UI Examples:**
  /// - `أهلاً بعودتك` / `مرحباً بعودتك` ➔ **English:** `Welcome back`
  /// - `تأكيد الرمز` ➔ **English:** `Confirm code`
  /// - `أكمل ملفك الشخصي` ➔ **English:** `Complete your profile`
  /// - `إعادة تعيين كلمة المرور` ➔ **English:** `Reset password`
  /// - `تحقق من بريدك الإلكتروني` ➔ **English:** `Check your email`
  /// - `تعيين كلمة مرور جديدة` ➔ **English:** `Set a new password`
  /// - `تم تغيير كلمة المرور بنجاح` ➔ **English:** `Password changed successfully`
  /// - `حدد موقعك` ➔ **English:** `Set your location`
  /// - `اختر عنوانك` ➔ **English:** `Choose your address`
  /// - `لم يتم العثور على نتائج` ➔ **English:** `No results found`
  /// - `الاشعارات` ➔ **English:** `Notifications`
  /// - `مكافحة الحشرات` / `تنظيف الأثاث` ➔ **English:** `Pest Control` / `Furniture Cleaning`
  /// - `الاضافات` / `التاريخ والوقت` / `العنوان` / `الدفع` ➔ **English:** `Add-ons` / `Date and Time` / `Address` / `Payment`
  static TextStyle ibmHeading22({Color color = AppColors.dark}) {
    return GoogleFonts.ibmPlexSansArabic(
      color: color,
      fontSize: 22.sp,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle ibmHeading20({Color color = AppColors.headingText}) {
    return GoogleFonts.ibmPlexSansArabic(
      color: color,
      fontSize: 20.sp,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle ibmHeading16({Color color = AppColors.headingText}) {
    return GoogleFonts.ibmPlexSansArabic(
      color: color,
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle ibmHeading14({Color color = AppColors.headingText}) {
    return GoogleFonts.ibmPlexSansArabic(
      color: color,
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
    );
  }

  /// Subheading or description style
  ///
  /// **Arabic UI Examples:**
  /// - `سنتصل بك أو سنرسل لك رمز التحقق لإكمال تسجيل الدخول` ➔ **English:** `We will call you or send you a verification code to complete sign in`
  /// - `أدخل رمز التحقق المكون من 6 أرقام المرسل إلى` ➔ **English:** `Enter the 6-digit verification code sent to`
  /// - `أضف بعض المعلومات لتخصيص تجربتك داخل التطبيق` ➔ **English:** `Add some information to customize your experience inside the app`
  /// - `من فضلك أدخل بريدك الإلكتروني لإعادة تعيين كلمة السر` ➔ **English:** `Please enter your email to reset your password`
  /// - `تم إرسال رابط إعادة تعيين إلى ahmed...@gmail.com أدخل الرمز المتكون من 4 أرقام لتأكيد البريد الإلكتروني` ➔ **English:** `A reset link has been sent to ahmed...@gmail.com. Enter the 4-digit code to confirm email`
  /// - `أنشئ كلمة مرور جديدة، وتأكد من أنها مختلفة عن كلمة المرور السابقة .` ➔ **English:** `Create a new password, and make sure it is different from the previous password.`
  /// - `يمكنك الآن تسجيل الدخول بكلمة المرور الجديدة` ➔ **English:** `You can now sign in with the new password`
  /// - `نحتاج إلى موقعك لعرض الخدمات المتاحة بالقرب منك` ➔ **English:** `We need your location to show available services near you`
  /// - `عذراً، لم نتمكن من العثور على أي خدمات تطابق بحثك...` ➔ **English:** `Sorry, we couldn't find any services matching your search...`
  /// - `لتعديل عنوان، اذهب إلى حسابي -> العناوين .` ➔ **English:** `To edit an address, go to My Account -> Addresses.`
  /// - `لا توجد تنبيهات جديدة` ➔ **English:** `No new notifications`
  /// - `نأمل أن تكون قد استمتعت بخدمة تنظيف السجاد، رأيك يهمنا، يرجى تقييم الفريق.` ➔ **English:** `We hope you enjoyed the carpet cleaning service. Your opinion matters, please rate the team.`
  /// - `تنظيف سطوح الكنبة بالمكنسة ...` ➔ **English:** `Vacuuming sofa surfaces...`
  /// - `يمكنك إلغاء الحجز أو تعديله مجاناً قبل 5 ساعة...` ➔ **English:** `You can cancel or modify the booking for free before 5 hours...`
  static TextStyle ibmDescription14({Color color = AppColors.secondaryText}) {
    return GoogleFonts.ibmPlexSansArabic(
      color: color,
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      height: 1.5,
    );
  }

  static TextStyle ibmDescription12({Color color = AppColors.secondaryText}) {
    return GoogleFonts.ibmPlexSansArabic(
      color: color,
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      height: 1.5,
    );
  }

  static TextStyle ibmDescription10({Color color = AppColors.secondaryText}) {
    return GoogleFonts.ibmPlexSansArabic(
      color: color,
      fontSize: 10.sp,
      fontWeight: FontWeight.w500,
      height: 1.5,
    );
  }

  /// Field labels style above inputs or Section Titles
  ///
  /// **Arabic UI Examples:**
  /// - `الاسم` ➔ **English:** `Name`
  /// - `البريد الإلكتروني` ➔ **English:** `Email`
  /// - `كلمة المرور` ➔ **English:** `Password`
  /// - `تأكيد كلمة المرور` ➔ **English:** `Confirm password`
  /// - `اللؤلؤة - الدوحة` ➔ **English:** `The Pearl - Doha`
  /// - `الأكثر طلباً` ➔ **English:** `Most Requested`
  /// - `عمليات البحث الأخيرة` ➔ **English:** `Recent Searches`
  /// - `خدمات شائعة` ➔ **English:** `Popular Services`
  /// - `ربما تبحث عن` ➔ **English:** `You might be looking for`
  /// - `اسم الشارع/الرقم` ➔ **English:** `Street Name/Number`
  /// - `جديد` / `اليوم` / `سابقا` ➔ **English:** `New` / `Today` / `Earlier`
  /// - `اكتملت الخدمة` ➔ **English:** `Service Completed`
  /// - `تشمل الخدمة:` / `ملاحظات قبل الحجز:` ➔ **English:** `Service Includes:` / `Notes before booking:`
  /// - `اختر اليوم` / `اختر وقت` ➔ **English:** `Choose Day` / `Choose Time`
  /// - `طريقة الدفع` / `كود الخصم` ➔ **English:** `Payment Method` / `Discount Code`
  static TextStyle ibmFieldLabel14({Color color = AppColors.dark}) {
    return GoogleFonts.ibmPlexSansArabic(
      color: color,
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
    );
  }

  /// Field input text or hint placeholder style
  ///
  /// **Arabic UI Examples:**
  /// - `أدخل اسمك بالكامل` ➔ **English:** `Enter your full name`
  /// - `أدخل البريد الإلكتروني` ➔ **English:** `Enter your email`
  /// - `أدخل كلمة المرور` ➔ **English:** `Enter your password`
  /// - `أعد إدخال كلمة المرور` ➔ **English:** `Re-enter your password`
  /// - `ابحث عن منطقة أو عنوان...` ➔ **English:** `Search for an area or address...`
  /// - `ابحث عن خدمة أو مشكلة...` ➔ **English:** `Search for a service or problem...`
  /// - `ادخل كود الخصم` ➔ **English:** `Enter discount code`
  /// - `مثال: اتصل امام المسجد..` ➔ **English:** `Example: Call in front of the mosque..`
  static TextStyle ibmPlaceholder14({Color color = AppColors.placeholder}) {
    return GoogleFonts.ibmPlexSansArabic(
      color: color,
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
    );
  }

  /// Button text style
  ///
  /// **Arabic UI Examples:**
  /// - `أرسل الكود` ➔ **English:** `Send code`
  /// - `تأكيد` ➔ **English:** `Confirm`
  /// - `إكمال التسجيل` ➔ **English:** `Complete registration`
  /// - `تسجيل الدخول` ➔ **English:** `Sign in`
  /// - `تحديد الموقع الحالي` ➔ **English:** `Set current location`
  /// - `تأكيد الموقع` ➔ **English:** `Confirm location`
  /// - `تصفح الخدمات` ➔ **English:** `Browse Services`
  /// - `جرب كلمات أخرى` ➔ **English:** `Try other words`
  /// - `التالي` ➔ **English:** `Next`
  /// - `اطلب معاينة` ➔ **English:** `Request inspection`
  static TextStyle ibmButton16({Color color = AppColors.white}) {
    return GoogleFonts.ibmPlexSansArabic(
      color: color,
      fontSize: 16.sp,
      fontWeight: FontWeight.bold,
    );
  }

  /// Actionable/Link text style
  ///
  /// **Arabic UI Examples:**
  /// - `إعادة إرسال الكود` ➔ **English:** `Resend code`
  /// - `تسجيل الدخول` ➔ **English:** `Sign in`
  /// - `المتابعة كضيف` ➔ **English:** `Continue as guest`
  /// - `تسجيل عبر Google` ➔ **English:** `Sign in with Google`
  /// - `تسجيل عبر Apple` ➔ **English:** `Sign in with Apple`
  /// - `نسيت كلمة المرور؟` ➔ **English:** `Forgot password?`
  /// - `ليس لديك حساب ؟ إنشاء حساب` ➔ **English:** `Don't have an account? Create an account`
  /// - `تذكرني` ➔ **English:** `Remember me`
  /// - `اختيار الموقع يدويا` ➔ **English:** `Choose location manually`
  /// - `عرض الكل` ➔ **English:** `View All`
  /// - `مسح الكل` ➔ **English:** `Clear All`
  /// - `+ إضافة عنوان جديد` ➔ **English:** `Add a new address`
  /// - `عرض تفاصيل الخدمة` ➔ **English:** `View service details`
  static TextStyle ibmLink13({Color color = AppColors.greenPrimary}) {
    return GoogleFonts.ibmPlexSansArabic(
      color: color,
      fontSize: 13.sp,
      fontWeight: FontWeight.bold,
    );
  }

  /// Small caption text style
  ///
  /// **Arabic UI Examples:**
  /// - `بتسجيل الدخول أنت توافق على الشروط والأحكام وسياسة الخصوصية` ➔ **English:** `By signing in, you agree to the Terms & Conditions and Privacy Policy`
  /// - `أو باستخدام` ➔ **English:** `Or using`
  /// - `منذ 1 د` / `منذ 10 س` ➔ **English:** `1 min ago` / `10 hrs ago`
  /// - `جميع المدفوعات مشفرة لضمان أعلى مستويات الأمان والخصوصية.` ➔ **English:** `All payments are encrypted to ensure the highest levels of security and privacy.`
  /// - `الخطوة 2 من 5` ➔ **English:** `Step 2 of 5`
  static TextStyle ibmCaption11({Color color = AppColors.gray}) {
    return GoogleFonts.ibmPlexSansArabic(
      color: color,
      fontSize: 11.sp,
      fontWeight: FontWeight.w400,
    );
  }

  /// Field error messages text style
  ///
  /// **Arabic UI Examples:**
  /// - `كلمة مرور غير صحيحة` ➔ **English:** `Incorrect password`
  /// - `كلمتا المرور غير متطابقتين` ➔ **English:** `The two passwords do not match`
  /// - `عذراً لا نقدم خدمة في هذه المنطقة` ➔ **English:** `Sorry, we do not provide service in this area`
  static TextStyle ibmError12({Color color = AppColors.errorRed}) {
    return GoogleFonts.ibmPlexSansArabic(
      color: color,
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
    );
  }

  static const ibmPlexSansArabic16SemiBold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    fontFamily: 'IBM Plex Sans Arabic',
    color: AppColors.secondary,
  );
}
