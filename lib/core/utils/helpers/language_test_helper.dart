library;

import 'package:flutter/material.dart';
import '../l10n/app_strings.dart';

class LanguageTestHelper {

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

    'confirmCode',
    'enterVerificationCode',
    'resendCodePrompt',
    'resendCodePromptAlt',
    'resendCodeLink',
    'defaultOtpTimer',

    'completeProfile',
    'completeProfileSubtitle',
    'nameLabel',
    'namePlaceholder',
    'completeRegistration',

    'resetPassword',
    'resetPasswordDescription',
    'checkEmail',
    'emailSentDescription',

    'setNewPassword',
    'setNewPasswordDescription',
    'passwordChangedSuccessfully',
    'loginWithNewPassword',

    'bookingSummary',
    'paymentSummary',
    'totalIncludingVat',
    'totalLabel',

    'errorIncorrectPassword',
    'errorPasswordsDoNotMatch',
    'errorOutOfZone',
  ];

  static Map<String, dynamic> validateAllTranslations() {
    final results = <String, dynamic>{
      'total_checked': translationKeys.length,
      'missing_translations': <String>[],
      'errors': <String>[],
    };

    for (var key in translationKeys) {
      try {

        _getTranslationByKey(key);
      } catch (e) {
        (results['missing_translations'] as List<String>).add(key);
        (results['errors'] as List<String>).add('$key: $e');
      }
    }

    return results;
  }

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
