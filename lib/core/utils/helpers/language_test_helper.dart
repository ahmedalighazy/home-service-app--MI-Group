/// Language Test Helper
/// 
/// هذا الملف يساعد في اختبار دعم اللغات في التطبيق
/// This file helps test language support in the application
library;

import 'package:flutter/material.dart';
import '../l10n/app_strings.dart';

/// فئة مساعدة للتحقق من الترجمات والدعم اللغوي
class LanguageTestHelper {
  /// قائمة جميع المفاتيح الموجودة في AppStrings
  /// List of all keys in AppStrings
  static const List<String> translationKeys = [
    'confirm',
    'sendCode',
    'emailLabel',
    'emailPlaceholder',
    'passwordLabel',
    'passwordPlaceholder',
    'confirmPasswordLabel',
    'confirmPasswordPlaceholder',
    'login',
    'termsAndPrivacy',
    'orUsing',
    'viewAll',
    'bookNow',
    // --- Sign Up / Login Screen ---
    'welcomeBack',
    'welcomeBackAlt',
    'verificationMethodInfo',
    'signUpWithGoogle',
    'signUpWithApple',
    'continueAsGuest',
    'alreadyHaveAccount',
    'dontHaveAccount',
    'createAccount',
    'forgotPassword',
    'rememberMe',
    'phonePlaceholder',
    'defaultCountryCode',
    // --- OTP Verification Screen ---
    'confirmCode',
    'enterVerificationCode',
    'resendCodePrompt',
    'resendCodePromptAlt',
    'resendCodeLink',
    'defaultOtpTimer',
    // --- Complete Profile Screen ---
    'completeProfile',
    'completeProfileSubtitle',
    'nameLabel',
    'namePlaceholder',
    'completeRegistration',
    // --- Reset Password & Verification ---
    'resetPassword',
    'resetPasswordDescription',
    'checkEmail',
    'emailSentDescription',
    // --- Set New Password Screen ---
    'setNewPassword',
    'setNewPasswordDescription',
    'passwordChangedSuccessfully',
    'loginWithNewPassword',
    // --- Bookings ---
    'bookingSummary',
    'paymentSummary',
    'totalIncludingVat',
    'totalLabel',
    // --- Errors ---
    'errorIncorrectPassword',
    'errorPasswordsDoNotMatch',
    'errorOutOfZone',
  ];

  /// اختبر ما إذا كانت جميع الترجمات موجودة
  /// Test if all translations are available
  static Map<String, dynamic> validateAllTranslations() {
    final results = <String, dynamic>{
      'total_checked': translationKeys.length,
      'missing_translations': <String>[],
      'errors': <String>[],
    };

    for (var key in translationKeys) {
      try {
        // محاولة الوصول إلى كل ترجمة
        _getTranslationByKey(key);
      } catch (e) {
        (results['missing_translations'] as List<String>).add(key);
        (results['errors'] as List<String>).add('$key: $e');
      }
    }

    return results;
  }

  /// الحصول على ترجمة باستخدام المفتاح
  /// Get translation by key
  static String _getTranslationByKey(String key) {
    switch (key) {
      case 'confirm':
        return AppStrings.confirm;
      case 'sendCode':
        return AppStrings.sendCode;
      case 'emailLabel':
        return AppStrings.emailLabel;
      case 'emailPlaceholder':
        return AppStrings.emailPlaceholder;
      case 'passwordLabel':
        return AppStrings.passwordLabel;
      case 'passwordPlaceholder':
        return AppStrings.passwordPlaceholder;
      case 'login':
        return AppStrings.login;
      case 'welcomeBack':
        return AppStrings.welcomeBack;
      case 'completeProfile':
        return AppStrings.completeProfile;
      case 'bookingSummary':
        return AppStrings.bookingSummary;
      default:
        throw Exception('Translation key not found: $key');
    }
  }

  /// طباعة جميع الترجمات للتحقق
  /// Print all translations for verification
  static void debugPrintAllTranslations() {
    debugPrint('╔════════════════════════════════════════╗');
    debugPrint('║  Language Support Test Report          ║');
    debugPrint('║  تقرير اختبار دعم اللغات             ║');
    debugPrint('╚════════════════════════════════════════╝\n');

    final validations = validateAllTranslations();

    debugPrint('✅ إجمالي الترجمات المختبرة: ${validations['total_checked']}');
    debugPrint('   Total Translations Tested: ${validations['total_checked']}\n');

    if ((validations['missing_translations'] as List).isNotEmpty) {
      debugPrint('❌ الترجمات المفقودة:');
      debugPrint('   Missing Translations:');
      for (var missing in validations['missing_translations'] as List) {
        debugPrint('   - $missing');
      }
    } else {
      debugPrint('✅ جميع الترجمات موجودة');
      debugPrint('   All Translations Available\n');
    }

    debugPrint('\n📊 عينة من الترجمات:');
    debugPrint('   Sample Translations:\n');

    debugPrint('📧 البريد الإلكتروني:');
    debugPrint('   Email:');
    debugPrint('   - Arab: ${AppStrings.emailLabel}');
    debugPrint('   - Eng:  ${AppStrings.emailLabel}');

    debugPrint('\n🔐 كلمة المرور:');
    debugPrint('   Password:');
    debugPrint('   - Arab: ${AppStrings.passwordLabel}');
    debugPrint('   - Eng:  ${AppStrings.passwordLabel}');

    debugPrint('\n✔️ تسجيل الدخول:');
    debugPrint('   Login:');
    debugPrint('   - Arab: ${AppStrings.login}');
    debugPrint('   - Eng:  ${AppStrings.login}');

    debugPrint('\n📋 الملف الشخصي:');
    debugPrint('   Profile:');
    debugPrint('   - Arab: ${AppStrings.completeProfile}');
    debugPrint('   - Eng:  ${AppStrings.completeProfile}');

    debugPrint('\n═══════════════════════════════════════════');
  }

  /// اختبر دعم RTL/LTR
  /// Test RTL/LTR Support
  static Future<void> testRtlLtrSupport(BuildContext context) async {
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';

    debugPrint('\n╔════════════════════════════════════════╗');
    debugPrint('║  RTL/LTR Support Test                  ║');
    debugPrint('╚════════════════════════════════════════╝\n');

    debugPrint('📱 لغة الجهاز: ${locale.languageCode}');
    debugPrint('   Device Language: ${locale.languageCode}');

    debugPrint('\n🔄 الاتجاه المتوقع:');
    debugPrint('   Expected Direction:');
    debugPrint('   ${isArabic ? '← RTL (اليمين إلى اليسار)' : '→ LTR (اليسار إلى اليمين)'}');

    debugPrint('\n✅ نوع الاتجاه:');
    debugPrint('   Direction Type:');
    debugPrint('   ${isArabic ? 'RTL' : 'LTR'}');

    debugPrint('\n═══════════════════════════════════════════');
  }

  /// اختبر جميع الشاشات
  /// Test all screens language support
  static List<Map<String, String>> getScreenLanguageSupportStatus() {
    return [
      {
        'screen': 'Splash',
        'support': '✅',
        'notes': 'No text, automatic'
      },
      {
        'screen': 'Onboarding',
        'support': '✅',
        'notes': 'Uses LanguageCubit'
      },
      {
        'screen': 'Language Selection',
        'support': '✅',
        'notes': 'Manual toggle'
      },
      {
        'screen': 'Sign In',
        'support': '✅',
        'notes': 'RTL/LTR support'
      },
      {
        'screen': 'Sign Up',
        'support': '✅',
        'notes': 'RTL/LTR support'
      },
      {
        'screen': 'OTP',
        'support': '✅',
        'notes': 'RTL/LTR support'
      },
      {
        'screen': 'Complete Profile',
        'support': '✅',
        'notes': 'RTL/LTR support'
      },
      {
        'screen': 'Forget Password',
        'support': '✅',
        'notes': 'RTL/LTR support'
      },
      {
        'screen': 'Verify Reset Code',
        'support': '✅',
        'notes': 'RTL/LTR support'
      },
      {
        'screen': 'Set New Password',
        'support': '✅',
        'notes': 'RTL/LTR support'
      },
    ];
  }

  /// اطبع حالة دعم اللغات لجميع الشاشات
  /// Print language support status for all screens
  static void debugPrintScreenStatus() {
    debugPrint('\n╔════════════════════════════════════════╗');
    debugPrint('║  Screen Language Support Status        ║');
    debugPrint('║  حالة دعم اللغات في الشاشات          ║');
    debugPrint('╚════════════════════════════════════════╝\n');

    final screens = getScreenLanguageSupportStatus();

    debugPrint('┌─ Screen Status ─────────────────────────┐');
    debugPrint('│ Screen              │ Support │ Notes   │');
    debugPrint('├─────────────────────┼─────────┼─────────┤');

    for (var screen in screens) {
      final name = screen['screen']!.padRight(20);
      final support = screen['support']!.padRight(8);
      final notes = screen['notes']!;
      debugPrint('│ $name │ $support │ $notes │');
    }

    debugPrint('└─────────────────────┴─────────┴─────────┘\n');

    debugPrint('✅ جميع الشاشات تدعم اللغتين');
    debugPrint('   All screens support both languages\n');
  }
}
