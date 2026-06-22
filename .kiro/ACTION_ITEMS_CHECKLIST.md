# ✅ Action Items Checklist - فصل UI و Logic

**Status:** مستند حي - يُحدّث بعد إكمال كل مهمة

---

## 🎯 المرحلة الأولى: الأساسيات (Priority: HIGH)

### 1. إنشاء Validation Classes
- [ ] `lib/core/validation/auth_validation.dart` - Email & Password validation
  - Methods: `isValidEmail()`, `isValidPassword()`, `isFormValid()`
  - Error messages for each field
  
- [ ] `lib/core/validation/phone_validation.dart` - Qatar phone validation
  - Methods: `isValidQatarPhone()`, `formatPhoneNumber()`
  - Constants: `qatarPhoneLength = 8`, `countryCode = '+974'`

### 2. إنشاء Widgets منفصلة
- [ ] `lib/features/auth/presentation/widgets/phone_input_field.dart`
  - Reusable phone input with country flag
  - Props: `controller`, `errorText`, `onChanged`, `countryCode`, `countryFlag`
  
- [ ] `lib/core/widgets/error_dialog.dart`
  - Centralized error display
  - Props: `message`, `title`, `onRetry`
  
- [ ] `lib/core/widgets/success_snackbar.dart` (Optional)
  - Consistent success messaging

### 3. نقل Models من Presentation إلى Domain
- [ ] Create `lib/features/auth/domain/models/` folder
- [ ] Move `SignInRequest` من `sign_in_helper.dart`
- [ ] Move `SignInResponse` من `sign_in_helper.dart`
- [ ] Move `UserSignInData` من `sign_in_helper.dart`

### 4. نقل Exceptions إلى Core
- [ ] Create `lib/core/error/auth_exceptions.dart`
- [ ] Move `SignInException` من `sign_in_helper.dart`
- [ ] Move `InvalidCredentialsException`, `UserNotFoundException`, etc.
- [ ] Ensure consistent exception handling

---

## 🎯 المرحلة الثانية: Cubits للـ UI State (Priority: HIGH)

### 5. إنشاء SignInUiCubit
- [ ] `lib/features/auth/logic/cubits/sign_in_ui_cubit.dart`
  - State: `SignInUiState` with `isPasswordVisible`, `isFormValid`, `emailError`, `passwordError`
  - Methods: `togglePasswordVisibility()`, `updateFormValidity()`, `setRememberMe()`

### 6. إنشاء SignUpUiCubit
- [ ] `lib/features/auth/logic/cubits/sign_up_ui_cubit.dart`
  - State: `SignUpUiState` with `isPhoneValid`, `phoneError`
  - Methods: `updatePhoneValidity()`

### 7. إنشاء SplashCubit
- [ ] `lib/features/splash/logic/splash_cubit.dart`
  - Inject: `CacheHelper`
  - Methods: `checkFirstTime()`
  - States: `SplashInitial`, `SplashNavigateToOnboarding`, `SplashNavigateToSignUp`

### 8. إنشاء OnboardingCubit
- [ ] `lib/features/onboarding/logic/onboarding_cubit.dart`
  - Inject: `CacheHelper`
  - Methods: `nextPage()`, `skipToEnd()`, `completeOnboarding()`
  - States: `OnboardingInitial`, `OnboardingPageChanged`, `OnboardingCompleted`

---

## 🎯 المرحلة الثالثة: Refactoring Screens (Priority: MEDIUM)

### 9. تنظيف SignIn Screen
- [ ] Remove `_isValidEmail()` method
- [ ] Remove `_isFormValid()` method
- [ ] Remove `_showErrorSnackBar()` method
- [ ] Remove `_showSuccessMessage()` method
- [ ] Add `SignInUiCubit` integration
- [ ] Add `_updateFormValidity()` listener on TextControllers
- [ ] Use `AuthValidation` for email validation
- [ ] Update build() to use BlocBuilder for UI state
- [ ] Test: التحقق من أن الـ Screen فقط UI

### 10. تنظيف SignUp Screen
- [ ] Remove `_isPhoneValid()` method
- [ ] Replace `_buildPhoneField()` with `PhoneInputField` widget
- [ ] Add `SignUpUiCubit` integration
- [ ] Remove error handling logic
- [ ] Use `PhoneValidation` class
- [ ] Update build() to use BlocBuilder for UI state
- [ ] Test: التحقق من أن الـ Screen فقط UI

### 11. تنظيف Splash Screen
- [ ] Remove `_navigateFromSplash()` method
- [ ] Add `SplashCubit` integration
- [ ] Add `BlocListener` for navigation
- [ ] Keep animation in UI
- [ ] Call `splashCubit.checkFirstTime()` in `initState`
- [ ] Test: Navigation works correctly

### 12. تنظيف Onboarding Screen
- [ ] Remove `_finishOnboarding()` method
- [ ] Add `OnboardingCubit` integration
- [ ] Replace direct navigation with `OnboardingCubit.completeOnboarding()`
- [ ] Update page navigation to use Cubit methods
- [ ] Test: Page navigation and completion work

---

## 🎯 المرحلة الرابعة: تنظيف الملفات القديمة (Priority: LOW)

### 13. تنظيف SignInHelper
- [ ] Option 1: حذف الملف تماماً (recommended)
- [ ] Option 2: الاحتفاظ به للتوثيق فقط مع `@Deprecated` marker
- [ ] Update imports في أي ملف يستخدمه

### 14. تنظيف Imports
- [ ] تحديث `lib/core/di/injection.dart`
  - Add `SignInUiCubit` registration
  - Add `SignUpUiCubit` registration
  - Add `SplashCubit` registration
  - Add `OnboardingCubit` registration

### 15. توثيق التغييرات
- [ ] Update `ARCHITECTURE.md` if exists
- [ ] Add docs for new Cubits
- [ ] Document validation classes usage

---

## 📝 ملفات التحقق من الصحة (Verification)

### قائمة التحقق من كل Refactoring:

```
شاشة يتم تنظيفها: _____________________

✅ Checklist:
- [ ] لا توجد دوال validation في الـ Screen
- [ ] لا توجد معالجة أخطاء معقدة في الـ Screen
- [ ] استخدام BlocListener/BlocBuilder بشكل صحيح
- [ ] استخدام Cubit للـ UI state
- [ ] استخدام Cubit للـ Business logic
- [ ] Widgets منفصلة ومقابلة
- [ ] لا توجد TextEditingControllers في properties غير ضرورية
- [ ] dispose() مطبق بشكل صحيح
- [ ] Build method واضح ومنظم
- [ ] لا توجد TODOs معلقة
```

---

## 🧪 Testing Checklist

### قبل Merge:

- [ ] **Unit Tests للـ Validation**
  ```dart
  test('AuthValidation.isValidEmail', () {
    expect(AuthValidation.isValidEmail('test@example.com'), true);
    expect(AuthValidation.isValidEmail('invalid'), false);
  });
  ```

- [ ] **Widget Tests للـ PhoneInputField**
  ```dart
  testWidgets('PhoneInputField displays error', (tester) async {
    // Test error display
  });
  ```

- [ ] **BLoC Tests للـ Cubits**
  ```dart
  blocTest<SignInUiCubit, SignInUiState>(
    'togglePasswordVisibility changes isPasswordVisible',
    build: () => SignInUiCubit(),
    act: (cubit) => cubit.togglePasswordVisibility(),
    expect: () => [
      isA<SignInUiState>()
          .having((s) => s.isPasswordVisible, 'isPasswordVisible', true),
    ],
  );
  ```

- [ ] **Manual Testing**
  - [ ] Run on Android device/emulator
  - [ ] Run on iOS device/emulator
  - [ ] Test all user flows
  - [ ] Test error scenarios

---

## 📊 Progress Tracking

### Summary Stats:

| Phase | Tasks | Completed | Status |
|-------|-------|-----------|--------|
| Phase 1 | 4 items | 0/4 | ⏳ Not Started |
| Phase 2 | 4 items | 0/4 | ⏳ Not Started |
| Phase 3 | 4 items | 0/4 | ⏳ Not Started |
| Phase 4 | 3 items | 0/3 | ⏳ Not Started |
| **Total** | **15 items** | **0/15** | **0%** |

---

## 🎬 Getting Started

### اختر أحد الخيارات:

**Option A: البداية السريعة (1-2 days)**
```
1. Create validation classes (30 min)
2. Create PhoneInputField widget (30 min)
3. Refactor SignIn screen (1 hour)
4. Refactor SignUp screen (1 hour)
```

**Option B: الطريق الآمن (3-4 days)**
```
1. Create all validation classes
2. Create all UI widgets
3. Create all Cubits with tests
4. Refactor screens one by one
5. Add integration tests
6. Review & merge
```

**Option C: التدرج البطيء (Ongoing)**
```
- Refactor one screen per day
- Add tests incrementally
- Review with team
- Document changes
```

---

## 🔗 الملفات المرتبطة

تم إنشاء التقارير التالية:
1. `.kiro/SEPARATION_AUDIT_REPORT_AR.md` - تقرير التدقيق الشامل
2. `.kiro/REFACTORING_EXAMPLES_AR.md` - أمثلة عملية مفصلة
3. `.kiro/ACTION_ITEMS_CHECKLIST.md` - هذا الملف (خطة العمل)

---

## 📞 ملاحظات عامة

- **كل مهمة يجب أن تكون**:
  - ✅ مستقلة وقابلة للاختبار
  - ✅ لها PR منفصل (recommended)
  - ✅ موثقة بشكل واضح
  - ✅ مراجعة من الـ team

- **قبل الاندماج (Merge)**:
  - ✅ تمرير جميع التحقق من الصيانة (lints)
  - ✅ تمرير جميع الاختبارات
  - ✅ لا عطل في البناء
  - ✅ موافقة من Code Reviewer

---

**آخر تحديث:** 8 يونيو 2026  
**الحالة:** وثيقة حية - تُحدث عند الحاجة  
**المالك:** Development Team
