# مرجع سريع للغات | Language Quick Reference

## 🚀 كيفية استخدام اللغات في الشاشات الجديدة

### الطريقة الأولى: Localizations (المفضلة)
```dart
import 'package:flutter/material.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';

class MyNewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // استكشاف اللغة
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    
    // تطبيق الاتجاه
    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        body: Center(
          child: Text(AppStrings.emailLabel), // استخدام الترجمات
        ),
      ),
    );
  }
}
```

### الطريقة الثانية: LanguageCubit (للـ Onboarding و Dynamic)
```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/core/language/language_cubit.dart';

class MyDynamicScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<LanguageCubit>().isArabic;
    
    return Text(
      isArabic ? 'مرحبا' : 'Hello',
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
    );
  }
}
```

---

## 📝 إضافة ترجمات جديدة

### 1. في `lib/core/utils/l10n/app_strings.dart`:
```dart
// أضف الخاصية الجديدة
static String get myNewLabel => _isArabic ? 'النص العربي' : 'English Text';
```

### 2. استخدمها في الشاشة:
```dart
Text(AppStrings.myNewLabel)
```

---

## 🌐 الشاشات المهيأة للغات

| الشاشة | حالة اللغات | ملاحظات |
|-------|-----------|--------|
| Splash | ✅ | تلقائي |
| Onboarding | ✅ | يستخدم LanguageCubit |
| Language Selection | ✅ | تبديل يدوي |
| Sign In | ✅ | مع RTL/LTR |
| Sign Up | ✅ | مع RTL/LTR |
| OTP | ✅ | مع RTL/LTR |
| Complete Profile | ✅ | مع RTL/LTR |
| Forget Password | ✅ | مع RTL/LTR |
| Verify Reset Code | ✅ | مع RTL/LTR |
| Set New Password | ✅ | مع RTL/LTR |

---

## 🔧 تبديل اللغة برمجياً

```dart
// تبديل إلى العربية
context.read<LanguageCubit>().setArabic();

// تبديل إلى الإنجليزية
context.read<LanguageCubit>().setEnglish();

// تبديل بين اللغتين
context.read<LanguageCubit>().toggleLanguage();
```

---

## ⚙️ إعدادات التطبيق (main.dart)

```dart
locale: state.isArabic ? const Locale('ar') : const Locale('en'),
supportedLocales: const [
  Locale('en', ''),
  Locale('ar', ''),
],
```

---

## 💾 حفظ واسترجاع اللغة

```dart
// حفظ
CacheHelper.saveData(key: 'language', value: 'ar'); // أو 'en'

// استرجاع
final savedLang = CacheHelper.getData(key: 'language');
```

---

## ✅ قائمة التحقق للشاشات الجديدة

- [ ] import `Localizations` و `AppStrings`
- [ ] أنشئ متغير `isArabic`
- [ ] غطِّ الشاشة بـ `Directionality`
- [ ] استخدم `AppStrings` للنصوص
- [ ] اختبر مع كلا اللغتين

---

## 🚨 أخطاء شائعة وحلولها

### ❌ الخطأ: "No MaterialLocalizations found"
**الحل**: تأكد من أن `localizationsDelegates` موجودة في `main.dart`

### ❌ الخطأ: النصوص لا تتغير عند تبديل اللغة
**الحل**: استخدم `context.watch<LanguageCubit>()` بدلاً من متغير عادي

### ❌ الخطأ: النص العربي بالمقلوب
**الحل**: استخدم `Directionality` مع `TextDirection.rtl`

---

## 📊 إحصائيات الترجمة

- **إجمالي النصوص**: 200+ نص
- **اللغات المدعومة**: عربي 🇸🇦 | إنجليزي 🇬🇧
- **حالة التغطية**: 100% ✅

---

## 🎯 نصائح للأداء

1. **استخدم `Localizations` بدلاً من `LanguageCubit`** للشاشات الثابتة
2. **تخزين `isArabic` في متغير محلي** تجنباً لتكرار البحث
3. **استخدم `const` للـ Locale objects** لتوفير الذاكرة

```dart
// جيد ✅
final isArabic = Localizations.localeOf(context).languageCode == 'ar';
return Directionality(
  textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
  // ...
);

// أفضل ✅✅
const arabicLocale = Locale('ar');
const englishLocale = Locale('en');
```

---

## 📞 الدعم والمساعدة

- **مشاكل في الترجمة؟** أضف/عدّل في `app_strings.dart`
- **مشاكل في اتجاه النص؟** استخدم `Directionality`
- **مشاكل في التبديل التلقائي؟** تحقق من `LanguageCubit`

---

**آخر تحديث**: 5 يونيو 2026
