# Router Setup Guide - BlocProvider في الـ Router

## المشكلة

### ❌ الطريقة القديمة (داخل الشاشة):
```dart
class SignInScreen extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AuthCubitV2>(  // ❌ مكرر في كل شاشة
        create: (context) => context.read<AuthCubitV2>(),
        child: BlocListener(...),
      ),
    );
  }
}
```

**المشاكل:**
- ❌ كود مكرر في كل شاشة
- ❌ صعب الـ maintenance
- ❌ عدم تركيز الـ logic

### ✅ الطريقة الجديدة (في الـ Router):
```dart
class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/sign_in',
        builder: (context, state) {
          return BlocProvider<AuthCubitV2>.value(  // ✅ في الـ Router
            value: GetIt.instance<AuthCubitV2>(),
            child: const SignInScreen(),
          );
        },
      ),
    ],
  );
}
```

**الفوائد:**
- ✅ كود مركزي في مكان واحد
- ✅ سهل الـ maintenance
- ✅ أقل code duplication
- ✅ تحكم أفضل على الـ providers

---

## الإعداد الكامل

### 1. **main.dart**

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/routing/app_router_best_practice.dart';
import 'features/auth/presentation/providers/auth_providers.dart';

void main() {
  // 1. Setup DI
  setupAuthProviders();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Home Service App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      // 2. استخدام GoRouter
      routerConfig: AppRouterBestPractice.router,
    );
  }
}
```

### 2. **app_router_best_practice.dart**

```dart
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../features/auth/presentation/cubits/auth_cubit_v2.dart';

class AppRouterBestPractice {
  static final _getIt = GetIt.instance;

  static final GoRouter router = GoRouter(
    initialLocation: '/sign_in',
    routes: [
      // Sign In
      GoRoute(
        path: '/sign_in',
        name: 'sign_in',
        builder: (context, state) {
          return BlocProvider<AuthCubitV2>.value(
            value: _getIt<AuthCubitV2>(),
            child: const SignInScreen(),
          );
        },
      ),

      // Sign Up
      GoRoute(
        path: '/sign_up',
        name: 'sign_up',
        builder: (context, state) {
          return BlocProvider<AuthCubitV2>.value(
            value: _getIt<AuthCubitV2>(),
            child: const SignUpScreen(),
          );
        },
      ),

      // OTP
      GoRoute(
        path: '/otp',
        name: 'otp',
        builder: (context, state) {
          final phoneNumber = state.extra as String? ?? '';
          return BlocProvider<AuthCubitV2>.value(
            value: _getIt<AuthCubitV2>(),
            child: OtpScreen(phoneNumber: phoneNumber),
          );
        },
      ),

      // Complete Profile
      GoRoute(
        path: '/complete_profile',
        name: 'complete_profile',
        builder: (context, state) {
          final phoneNumber = state.extra as String? ?? '';
          return BlocProvider<AuthCubitV2>.value(
            value: _getIt<AuthCubitV2>(),
            child: CompleteProfileScreen(phoneNumber: phoneNumber),
          );
        },
      ),

      // Forgot Password
      GoRoute(
        path: '/forgot_password',
        name: 'forgot_password',
        builder: (context, state) {
          return BlocProvider<AuthCubitV2>.value(
            value: _getIt<AuthCubitV2>(),
            child: const ForgotPasswordScreen(),
          );
        },
      ),

      // Verify Reset Code
      GoRoute(
        path: '/verify_reset_code',
        name: 'verify_reset_code',
        builder: (context, state) {
          final email = state.extra as String? ?? '';
          return BlocProvider<AuthCubitV2>.value(
            value: _getIt<AuthCubitV2>(),
            child: VerifyResetCodeScreen(email: email),
          );
        },
      ),

      // Set New Password
      GoRoute(
        path: '/set_new_password',
        name: 'set_new_password',
        builder: (context, state) {
          final email = state.extra as String? ?? '';
          return BlocProvider<AuthCubitV2>.value(
            value: _getIt<AuthCubitV2>(),
            child: SetNewPasswordScreen(email: email),
          );
        },
      ),

      // Password Changed
      GoRoute(
        path: '/password_changed',
        name: 'password_changed',
        builder: (context, state) {
          return BlocProvider<AuthCubitV2>.value(
            value: _getIt<AuthCubitV2>(),
            child: const PasswordChangedSuccessfullyScreen(),
          );
        },
      ),
    ],
  );
}
```

### 3. **الآن الـ Screens بسيطة جداً**

**قبل:**
```dart
class SignInScreen extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AuthCubitV2>(  // ❌ مكرر
        create: (context) => context.read<AuthCubitV2>(),
        child: BlocListener(...),
      ),
    );
  }
}
```

**بعد:**
```dart
class SignInScreen extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubitV2, AuthState>(  // ✅ مباشرة
        listener: (context, state) { ... },
        child: BlocBuilder<AuthCubitV2, AuthState>(
          builder: (context, state) { ... },
        ),
      ),
    );
  }
}
```

---

## Navigation من الـ Screens

### داخل الـ Screen listener:

```dart
BlocListener<AuthCubitV2, AuthState>(
  listener: (context, state) {
    if (state is AuthSuccessState && state.action == 'sign_in') {
      _showSuccess('تم تسجيل الدخول بنجاح');
      
      // Navigate using GoRouter
      context.go('/home');  // بدل Navigator.push
    }
  },
)
```

### من أي مكان في الـ App:

```dart
import 'package:go_router/go_router.dart';

// Simple navigation
context.go('/sign_in');

// With parameters
context.go('/otp', extra: '+974512345678');

// Replace current route
context.replace('/home');

// Named navigation
context.goNamed('sign_in');
```

---

## متى تستخدم BlocProvider.value vs create

### ✅ BlocProvider.value (الأفضل في الـ Router)
```dart
BlocProvider<AuthCubitV2>.value(
  value: GetIt.instance<AuthCubitV2>(),  // استخدام Cubit موجود
  child: SignInScreen(),
)
```

**الفوائد:**
- ✅ Cubit موحد في جميع الـ Screens
- ✅ State محفوظ عند التنقل
- ✅ أداء أفضل
- ✅ No memory leak

### ❌ BlocProvider.create (تجنبها في الـ Router)
```dart
BlocProvider<AuthCubitV2>(
  create: (context) => AuthCubitV2(...),  // ❌ Cubit جديد
  child: SignInScreen(),
)
```

**المشاكل:**
- ❌ Cubit جديد في كل شاشة
- ❌ State يتم فقده
- ❌ Memory issues

---

## مثال متكامل للـ Navigation

### الـ Flow:
```
SignInScreen 
  → Success 
  → go('/sign_up')
  → SignUpScreen
  → Success
  → go('/otp', extra: phoneNumber)
  → OtpScreen
  → Success
  → go('/complete_profile', extra: phoneNumber)
  → CompleteProfileScreen
  → Success
  → go('/home')
```

### الكود:

```dart
// SignInScreen
BlocListener<AuthCubitV2, AuthState>(
  listener: (context, state) {
    if (state is AuthSuccessState && state.action == 'sign_in') {
      context.go('/home');
    }
  },
)

// SignUpScreen
BlocListener<AuthCubitV2, AuthState>(
  listener: (context, state) {
    if (state is OtpSentState) {
      context.go('/otp', extra: state.phoneNumber);
    }
  },
)

// OtpScreen
BlocListener<AuthCubitV2, AuthState>(
  listener: (context, state) {
    if (state is AuthSuccessState && state.action == 'otp_verified') {
      final phoneNumber = state.phoneNumber ?? '';
      context.go('/complete_profile', extra: phoneNumber);
    }
  },
)
```

---

## الملفات المطلوبة

### 1. **pubspec.yaml** - أضف Dependencies:
```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^8.0.0
  go_router: ^10.0.0
  get_it: ^7.0.0
```

### 2. **Main Structure:**
```
lib/
├── main.dart                           # Entry point
├── core/
│   └── routing/
│       ├── app_router.dart             # Basic Router
│       ├── app_router_best_practice.dart  # Best Practice
│       └── ROUTER_SETUP_GUIDE.md
└── features/auth/
    └── presentation/screens/
        ├── sign_in_screen/
        ├── otp_screen/
        └── ... (other screens)
```

---

## Advantages

| Feature | Old Way | New Way |
|---------|---------|---------|
| **Code Duplication** | High | Low ✅ |
| **Maintenance** | Hard | Easy ✅ |
| **State Management** | Complex | Simple ✅ |
| **Navigation** | Navigator | GoRouter ✅ |
| **Performance** | Medium | Good ✅ |
| **Memory** | Risk | Safe ✅ |
| **Centralization** | Scattered | Centralized ✅ |

---

## Summary

✅ **BlocProvider** في الـ Router
✅ **BlocProvider.value** مع GetIt
✅ **GoRouter** للـ Navigation
✅ **Screens بسيطة** بدون Provider Setup
✅ **كود مركزي** وسهل الـ Maintenance

---

## خطوات التطبيق

1. [ ] أضف go_router و get_it لـ pubspec.yaml
2. [ ] أنشئ app_router.dart مع GoRouter
3. [ ] أضف BlocProvider.value لكل Route
4. [ ] استخدم AppRouter في main.dart
5. [ ] استخدم context.go() للـ Navigation
6. [ ] اختبر جميع الـ Flows

---

**مرجع:**
- [GoRouter Documentation](https://pub.dev/packages/go_router)
- [Flutter BLoC Documentation](https://bloclibrary.dev)
- [GetIt Documentation](https://pub.dev/packages/get_it)
