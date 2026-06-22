# Unified Success State Guide

## Overview

تم تحسين الـ state management باستخدام **State واحدة للـ Success** بدل فصل كل عملية في state منفصلة.

## الفرق

### ❌ قديم (Old Pattern)
```dart
SignInSuccessState(userId, email, token)
OtpVerifiedState(phoneNumber)
ProfileCompletedState(userId, email, name)
PasswordResetSuccessState()
GoogleSignInSuccessState(userId, email)
AppleSignInSuccessState(userId, email)
```

### ✅ جديد (New Pattern)
```dart
AuthSuccessState(
  action: 'sign_in',
  data: {'userId': '123', 'email': 'user@example.com', 'token': 'xxx'}
)
```

---

## فوائد الـ Unified Success State

### 1. **تقليل الـ States**
- من 8 success states → **state واحدة فقط**
- أسهل في الـ maintenance
- أقل complexity

### 2. **مرونة أكثر**
```dart
// يمكن إضافة بيانات جديدة بسهولة
AuthSuccessState(
  action: 'sign_in',
  data: {
    'userId': '123',
    'email': 'user@example.com',
    'token': 'xxx',
    'customData': 'anything', // ✅ يمكن إضافة أي بيانات
  },
)
```

### 3. **Consistency**
- جميع الـ success operations تستخدم **state واحدة**
- pattern موحد في كل الـ Screens
- أسهل للفهم والمتابعة

---

## كيفية الاستخدام

### في الـ Cubit:
```dart
// Sign In Success
emit(AuthSuccessState(
  action: 'sign_in',
  data: {
    'userId': 'user_123',
    'email': email,
    'token': token.accessToken,
  },
));

// OTP Verified
emit(AuthSuccessState(
  action: 'otp_verified',
  data: {
    'phoneNumber': phoneNumber,
  },
));

// Profile Completed
emit(AuthSuccessState(
  action: 'profile_completed',
  data: {
    'userId': user.id,
    'email': user.email,
    'name': user.name,
  },
));

// Password Reset
emit(AuthSuccessState(
  action: 'password_reset',
  data: {
    'email': email,
  },
));

// Social Sign In
emit(AuthSuccessState(
  action: 'social_sign_in',
  data: {
    'userId': 'user_123',
    'email': 'user@gmail.com',
    'provider': 'google',
  },
));
```

### في الـ Screen:
```dart
BlocListener<AuthCubitV2, AuthState>(
  listenWhen: (previous, current) =>
      current is AuthSuccessState ||
      current is AuthErrorState,
  listener: (context, state) {
    if (state is AuthSuccessState) {
      // تحقق من نوع الـ action
      if (state.action == 'sign_in') {
        _showSuccess('تم تسجيل الدخول بنجاح');
        // Navigate to home
      } else if (state.action == 'otp_verified') {
        _showSuccess('تم التحقق من الرمز');
        // Navigate to profile
      } else if (state.action == 'profile_completed') {
        _showSuccess('تم إكمال الملف الشخصي');
        // Navigate to home
      }
    } else if (state is AuthErrorState) {
      _showError(state.message);
    }
  },
)
```

---

## Available Actions

| Action | Purpose | Data |
|--------|---------|------|
| `sign_in` | Sign in with email/password | userId, email, token |
| `sign_up` | Phone number OTP sent | phoneNumber |
| `otp_verified` | OTP code verified | phoneNumber |
| `profile_completed` | User profile completed | userId, email, name |
| `password_reset` | Password changed | email |
| `reset_code_verified` | Password reset code verified | email |
| `social_sign_in` | Social login success | userId, email, provider |

---

## Accessing Data from AuthSuccessState

### Direct property access:
```dart
if (state is AuthSuccessState) {
  final userId = state.userId;      // ✅ Helper getter
  final email = state.email;        // ✅ Helper getter
  final token = state.token;        // ✅ Helper getter
  final phoneNumber = state.phoneNumber; // ✅ Helper getter
  final name = state.name;          // ✅ Helper getter
}
```

### Or access raw data map:
```dart
if (state is AuthSuccessState) {
  final customData = state.data['customData'];  // Any custom data
  final provider = state.data['provider'];      // For social login
}
```

---

## Error States (Unchanged)

Error handling بقي كما هو:

```dart
if (state is AuthErrorState) {
  _showError(state.message);
}

// Specific errors still exist
if (state is OtpInvalidCodeState) { ... }
if (state is OtpExpiredState) { ... }
if (state is ResetCodeInvalidState) { ... }
if (state is ResetCodeExpiredState) { ... }
```

---

## Navigation Pattern

```dart
BlocListener<AuthCubitV2, AuthState>(
  listener: (context, state) {
    if (state is AuthSuccessState) {
      switch (state.action) {
        case 'sign_in':
          Navigator.pushReplacementNamed(context, '/home');
        case 'otp_verified':
          Navigator.pushReplacementNamed(context, '/complete_profile');
        case 'profile_completed':
          Navigator.pushReplacementNamed(context, '/home');
        case 'password_reset':
          Navigator.pushReplacementNamed(context, '/password_changed');
        case 'social_sign_in':
          Navigator.pushReplacementNamed(context, '/home');
        default:
          break;
      }
    }
  },
)
```

---

## Summary

✅ **State واحدة** للـ Success بدل multiple states
✅ **مرنة** - تدعم أي بيانات عبر Map
✅ **منظمة** - تستخدم action field للتمييز
✅ **Helper getters** - للوصول السريع للبيانات الشائعة
✅ **أسهل في الـ maintenance** - تقليل الـ complexity

---

## Migration Checklist

إذا كان عندك كود قديم، هذا الـ checklist يساعدك:

- [x] استبدل `SignInSuccessState` بـ `AuthSuccessState` مع `action: 'sign_in'`
- [x] استبدل `OtpVerifiedState` بـ `AuthSuccessState` مع `action: 'otp_verified'`
- [x] استبدل `ProfileCompletedState` بـ `AuthSuccessState` مع `action: 'profile_completed'`
- [x] استبدل `PasswordResetSuccessState` بـ `AuthSuccessState` مع `action: 'password_reset'`
- [x] استبدل `ResetCodeVerifiedState` بـ `AuthSuccessState` مع `action: 'reset_code_verified'`
- [x] استبدل `GoogleSignInSuccessState` بـ `AuthSuccessState` مع `action: 'social_sign_in'`
- [x] استبدل `AppleSignInSuccessState` بـ `AuthSuccessState` مع `action: 'social_sign_in'`
- [x] حدّث جميع الـ Listeners في الـ Screens
- [x] اختبر جميع الـ flows
