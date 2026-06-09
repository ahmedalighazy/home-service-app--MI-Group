# تقرير فحص فصل UI و Logic و Widgets

**التاريخ:** 8 يونيو 2026  
**الحالة:** يحتاج تحسينات في معظم الشاشات  
**الأولوية:** عالية

---

## 📊 ملخص التقييم

| الجانب | الحالة | النسبة |
|--------|--------|-------|
| **فصل الـ Screens عن Logic** | ⚠️ جزئي | 40% |
| **استخدام الـ Widgets بشكل صحيح** | ✅ جيد | 70% |
| **استخلاص Helper Functions** | ⚠️ ضعيف | 30% |
| **استخدام Cubits/BLoC** | ✅ جيد | 75% |
| **هيكل المشروع** | ✅ جيد | 80% |

---

## 🔍 المشاكل المكتشفة

### 1️⃣ **SignIn Screen** - `lib/features/auth/presentation/screens/sign in/sing_in_screen.dart`

#### المشاكل:
- ❌ **منطق التحقق من صحة الإيميل مختلط مع الـ UI**
  ```dart
  bool _isValidEmail(String email) {
    return email.contains('@') && email.contains('.');
  }
  ```
  يجب نقله إلى `AuthValidation` أو `SignInHelper`

- ❌ **منطق التحقق من صحة النموذج في الـ Screen**
  ```dart
  bool _isFormValid() {
    return _emailCtrl.text.trim().isNotEmpty &&
        _isValidEmail(_emailCtrl.text.trim()) &&
        _passwordCtrl.text.trim().length >= 4;
  }
  ```

- ❌ **معالجة الأخطاء (SnackBar) مباشرة في الـ Screen**
  ```dart
  void _showErrorSnackBar(String message) { ... }
  void _showSuccessMessage(String message) { ... }
  ```

- ✅ استخدام جيد للـ BlocConsumer و BlocProvider

#### الحل المطلوب:
```
✓ نقل عملية التحقق إلى AuthValidation
✓ نقل معالجة الأخطاء إلى widget منفصل
✓ استخدام state management لإدارة رؤية كلمة المرور
```

---

### 2️⃣ **SignUp Screen** - `lib/features/auth/presentation/screens/sign up/sing_up_screen.dart`

#### المشاكل:
- ❌ **منطق التحقق من رقم الهاتف مختلط مع الـ UI**
  ```dart
  bool _isPhoneValid() {
    final cleaned = _phoneCtrl.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleaned.length != 8) return false;
    return cleaned[0].compareTo('3') >= 0 && cleaned[0].compareTo('9') <= 0;
  }
  ```

- ❌ **بناء الـ Phone Field يحتوي على منطق معقد**
  ```dart
  Widget _buildPhoneField() { ... }
  ```
  يجب استخلاصه إلى widget منفصل `PhoneInputField`

- ❌ **معالجة الأخطاء مختلطة مع الـ UI**
  - عرض رسائل الخطأ مباشرة في الـ Screen

#### الحل المطلوب:
```
✓ نقل AuthPhoneValidation إلى validation folder
✓ استخلاص PhoneInputField widget
✓ إنشاء PhoneInputFormatter للتنسيق
✓ نقل معالجة الأخطاء إلى state management
```

---

### 3️⃣ **Splash Screen** - `lib/features/splash/presentation/screens/splash_screen.dart`

#### المشاكل:
- ⚠️ **يحتوي على منطق التنقل مختلط مع الـ UI**
  ```dart
  void _navigateFromSplash() async {
    final bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
    final route = (onBoarding != null && onBoarding) 
        ? AppRoutes.signUp 
        : AppRoutes.onboarding;
    Navigator.of(context).pushReplacementNamed(route);
  }
  ```

- ⚠️ **استخدام State مباشرة للـ Animation والـ Navigation**

#### التقييم:
- قد يكون مقبولاً للـ Splash Screen (حالة خاصة)
- ولكن يفضل نقل المنطق إلى `SplashCubit`

---

### 4️⃣ **Onboarding Screen** - `lib/features/onboarding/presentation/screens/onboarding_screen.dart`

#### المشاكل:
- ⚠️ **منطق الـ OnBoarding في الـ State**
  ```dart
  void _finishOnboarding() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) Navigator.of(context).pushReplacementNamed(AppRoutes.language);
    });
  }
  ```

- ✅ استخدام PageView + Animation بشكل صحيح

#### الحل المطلوب:
```
✓ إنشاء OnboardingCubit لإدارة حالة الـ Onboarding
✓ نقل منطق الحفظ والتنقل إلى الـ Cubit
✓ استخدام BlocListener لمراقبة النتائج
```

---

### 5️⃣ **Sign In Helper** - `lib/features/auth/presentation/widgets/sign_in_helper.dart`

#### المشاكل:
- ❌ **الملف يحتوي على data models مع helper functions**
  - `SignInRequest`, `SignInResponse` يجب نقلهما إلى `domain/models`
  - `SignInException` يجب نقلها إلى `core/error`

- ❌ **Helper class مشروط (Deprecated)**
  ```dart
  @Deprecated('Use AuthValidation class instead')
  ```
  يجب حذفه أو تنظيفه

- ⚠️ **TODOs غير محسومة**
  - Secure storage
  - API calls

---

## 📁 هيكل المشروع الحالي

```
lib/
├── features/
│   ├── auth/
│   │   ├── domain/        ✅ (entities فقط)
│   │   ├── logic/         ✅ (cubits/states)
│   │   └── presentation/
│   │       ├── screens/   ⚠️ (بها logic مختلط)
│   │       └── widgets/   ⚠️ (بها models)
│   └── ...
├── core/
│   ├── error/             ✅
│   ├── themes/            ✅
│   ├── routes/            ✅
│   ├── utils/
│   │   ├── validation/    ⚠️ (ناقص)
│   │   └── helpers/       ✅
│   └── services/          ⚠️ (ناقص)
```

---

## ✅ الـ Best Practices المطبقة بشكل صحيح

1. **استخدام BLoC/Cubit** ✅
   - State management منفصل عن UI
   - States منظمة بشكل واضح

2. **هيكل الـ Clean Architecture** ✅
   - فصل domain/data/presentation
   - استخدام usecase pattern (جزئياً)

3. **استخدام الـ Widgets** ✅
   - Reusable widgets للأزرار والـ Text Fields
   - widgets منفصلة للمكونات المختلفة

4. **Localization** ✅
   - استخدام AppStrings
   - دعم RTL و LTR

---

## 🎯 خطة الإصلاح المقترحة

### المرحلة 1: العاجل (Priority 1)
```
1. نقل validation logic من SignInScreen إلى AuthValidation
2. استخلاص PhoneInputField widget من SignUpScreen
3. حذف SignInHelper deprecated أو تنظيفه
4. نقل Models من widgets folder إلى domain/models
```

### المرحلة 2: المهم (Priority 2)
```
1. إنشاء SplashCubit لمنطق الـ Splash
2. إنشاء OnboardingCubit لمنطق الـ Onboarding
3. إنشاء ErrorHandler widget منفصل
4. نقل Exceptions إلى core/error
```

### المرحلة 3: التحسينات (Priority 3)
```
1. إنشاء validation classes منفصلة لكل feature
2. إضافة tests لـ validation logic
3. تطبيق Repository pattern كاملاً
4. توثيق Architecture بشكل مفصل
```

---

## 📋 Checklist للقيام بها

### يجب القيام به:
- [ ] إنشاء `lib/core/validation/auth_validation.dart`
- [ ] إنشاء `lib/features/auth/domain/models/` folder
- [ ] نقل `SignInRequest/Response` إلى domain/models
- [ ] استخلاص `PhoneInputField` widget
- [ ] إنشاء `SplashCubit` و `OnboardingCubit`
- [ ] حذف أو تنظيف `SignInHelper` deprecated
- [ ] إنشاء `ErrorHandlingWidget` منفصل
- [ ] نقل `SignInException` إلى core/error

### يجب فحصه:
- [ ] كل شاشة (Screen) لا تحتوي على business logic
- [ ] كل widget له مسؤولية واحدة فقط
- [ ] كل Cubit/BLoC يدير state منفصل
- [ ] لا توجد دوال validation في UI

---

## 🔗 الملفات المطلوب تعديلها

### Screens بحاجة لتنظيف:
1. `lib/features/auth/presentation/screens/sign in/sing_in_screen.dart`
2. `lib/features/auth/presentation/screens/sign up/sing_up_screen.dart`
3. `lib/features/splash/presentation/screens/splash_screen.dart`
4. `lib/features/onboarding/presentation/screens/onboarding_screen.dart`

### Widgets بحاجة إنشاء:
1. `lib/features/auth/presentation/widgets/phone_input_field.dart` (NEW)
2. `lib/core/widgets/error_handler.dart` (NEW)
3. `lib/core/widgets/success_message.dart` (NEW)

### Utils بحاجة إنشاء:
1. `lib/core/validation/auth_validation.dart` (NEW)
2. `lib/core/validation/phone_validation.dart` (NEW)

### Cubits بحاجة إنشاء:
1. `lib/features/splash/logic/splash_cubit.dart` (NEW)
2. `lib/features/onboarding/logic/onboarding_cubit.dart` (NEW)

---

## 🎓 نصائح المتابعة

1. **عند إضافة شاشة جديدة:**
   - الشاشة (Screen) = UI فقط
   - Cubit = Logic + State Management
   - Widgets = Reusable UI components
   - Models = في domain/models
   - Validation = في core/validation

2. **معايير الفصل:**
   ```
   ✅ GOOD: Screen بها build() فقط + BlocListener/BlocBuilder
   ❌ BAD: Screen بها منطق validation أو معالجة أخطاء
   ```

3. **اختبار الفصل:**
   - إذا كان يمكن اختبار دالة من دون UI → نقلها من Screen

---

## 📞 الخلاصة

**النقطة الرئيسية:** المشروع لديه هيكل جيد ولكن يحتاج **تنظيف الحدود بين طبقات الـ Architecture**.

**الهدف:** كل layer يجب أن يقوم بمسؤولية واحدة فقط:
- **Presentation Layer:** عرض البيانات فقط
- **Logic Layer (Cubit):** معالجة الأحداث وإدارة الحالة
- **Domain Layer:** Business rules و validation
- **Core Layer:** Utilities و themes و services

---

**صُنِع بواسطة:** Kiro Audit Tool  
**التقرير كامل وجاهز للاستخدام** ✅
