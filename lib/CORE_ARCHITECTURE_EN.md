# Core Architecture - English Version

## 📊 Architecture Overview

The `core` folder contains all shared foundational components used throughout the application. It follows Clean Architecture pattern with clear separation of concerns.

---

## 📁 Directory Structure

```
lib/core/
├── di/                      # Dependency Injection
│   ├── injection.dart
│   └── injection.config.dart
├── routes/                  # Navigation & Routing
│   └── app_routes.dart
├── themes/                  # Design System
│   ├── colors/
│   │   └── app_colors.dart
│   ├── image/
│   │   └── app_assets.dart
│   ├── text/
│   │   └── app_text.dart
│   └── theming/
│       └── app_theme.dart
├── utils/                   # Utility Functions
│   ├── helpers/
│   │   ├── cache_helper.dart
│   │   └── platform_utils.dart
│   └── l10n/
│       └── app_strings.dart
├── widgets/                 # Reusable Widgets
│   └── language_toggle.dart
└── CORE_ARCHITECTURE_EN.md  # This file
```

---

## 🔌 Dependency Injection (DI)

### File: `lib/core/di/injection.dart`

**Purpose:** Register and provide all application dependencies

**Benefits:**
- ✅ Loose Coupling
- ✅ Easy Testing
- ✅ Centralized Management
- ✅ Object Reuse

### Manual Registration

```dart
// In injection.dart
final getIt = GetIt.instance;

void configureDependencies() {
  // Register Cubits
  getIt.registerSingleton<AuthCubit>(AuthCubit());
  getIt.registerSingleton<SettingsCubit>(SettingsCubit());
  getIt.registerSingleton<ChatCubit>(ChatCubit());
  
  // Register Repositories
  getIt.registerSingleton<UserRepository>(UserRepositoryImpl());
  
  // Register Use Cases
  getIt.registerSingleton<LoginUseCase>(LoginUseCase(getIt()));
}
```

### Automatic Registration with Injectable

```dart
// Use @injectable with Cubit
@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
}

// Then run:
// flutter pub run build_runner build

// Automatically creates injection.config.dart
```

### Usage

```dart
// In Widget
BlocProvider<AuthCubit>(
  create: (_) => getIt<AuthCubit>(),
  child: const MyWidget(),
)

// Or directly
final authCubit = getIt<AuthCubit>();
authCubit.loginWithEmail('user@email.com', 'password');
```

---

## 🗺️ Navigation & Routing

### File: `lib/core/routes/app_routes.dart`

**Purpose:** Centralized route management

### Route Definitions

```dart
abstract class AppRouter {
  // Define routes as constants
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String completeProfile = '/complete-profile';
  static const String home = '/home';
  static const String forgetPassword = '/forget-password';
  static const String checkYourEmail = '/check-your-email';
  static const String setNewPass = '/set-new-pass';
  
  // Define Router
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: signIn,
        builder: (context, state) => const SingIn(),
      ),
      // ... more routes
    ],
  );
}
```

### Navigation Commands

```dart
// Navigate to screen
context.go(AppRouter.home);

// Push with back option
context.push(AppRouter.forgetPassword);

// Pop to previous
context.pop();

// Navigate with parameters
context.pushNamed(
  'complete-profile',
  queryParameters: {'phone': '966501234567'},
);
```

---

## 🎨 Design System

### 1. Colors: `lib/core/themes/colors/app_colors.dart`

```dart
class AppColors {
  // Primary Colors
  static const Color greenPrimary = Color(0xFF2ECC71);
  static const Color white = Color(0xFFFFFFFF);
  static const Color dark = Color(0xFF1A1A1A);
  
  // Status Colors
  static const Color errorRed = Color(0xFFE74C3C);
  static const Color successGreen = Color(0xFF27AE60);
  static const Color warningYellow = Color(0xFFF39C12);
  
  // Neutral Colors
  static const Color gray = Color(0xFF95A5A6);
  static const Color secondaryText = Color(0xFF7F8C8D);
  static const Color borderInputs = Color(0xFFBDC3C7);
  static const Color light = Color(0xFFF5F5F5);
  
  // Other Colors
  static const Color primaryBlack = Color(0xFF000000);
  static const Color darkGrey = Color(0xFF333333);
  static const Color softWhite = Color(0xFFFAFAFA);
  static const Color primaryYellow = Color(0xFFFFC107);
  static const Color primaryGrey = Color(0xFF9E9E9E);
}
```

### 2. Text Styles: `lib/core/themes/text/app_text.dart`

```dart
class AppText {
  // Headings
  static TextStyle ibmHeading22({Color color = AppColors.dark}) {
    return GoogleFonts.ibmPlexSans(
      fontSize: 22.sp,
      fontWeight: FontWeight.w700,
      color: color,
    );
  }
  
  // Descriptions
  static TextStyle ibmDescription14({Color color = AppColors.dark}) {
    return GoogleFonts.ibmPlexSans(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: color,
    );
  }
  
  // Links
  static TextStyle ibmLink13({Color color = AppColors.greenPrimary}) {
    return GoogleFonts.ibmPlexSans(
      fontSize: 13.sp,
      fontWeight: FontWeight.w500,
      color: color,
      decoration: TextDecoration.underline,
    );
  }
  
  // Captions
  static TextStyle ibmCaption11({Color color = AppColors.gray}) {
    return GoogleFonts.ibmPlexSans(
      fontSize: 11.sp,
      fontWeight: FontWeight.w400,
      color: color,
    );
  }
}
```

### 3. Assets: `lib/core/themes/image/app_assets.dart`

```dart
class AppAssets {
  // Logos
  static const String logo = 'assets/images/logo.png';
  
  // Onboarding
  static const String onboarding1 = 'assets/images/onboarding_1.png';
  static const String onboarding2 = 'assets/images/onboarding_2.png';
  
  // Social Icons
  static const String iconGoogle = 'assets/icons/google.svg';
  static const String iconApple = 'assets/icons/apple.svg';
  
  // Backgrounds
  static const String topographicBg = 'assets/images/topographic_bg.png';
}
```

### 4. Theme: `lib/core/themes/theming/app_theme.dart`

```dart
class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.white,
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      elevation: 0,
      centerTitle: true,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.greenPrimary,
    ),
  );
  
  static final ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primaryBlack,
    scaffoldBackgroundColor: AppColors.primaryBlack,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryBlack,
      elevation: 0,
    ),
  );
}
```

---

## 🛠️ Utilities

### 1. Cache Helper: `lib/core/utils/helpers/cache_helper.dart`

**Purpose:** Manage local storage and caching

```dart
// Save data
await CacheHelper.saveData(key: 'onBoarding', value: true);
await CacheHelper.saveData(key: 'token', value: 'abc123xyz');

// Read data
final onBoarding = CacheHelper.getData(key: 'onBoarding');
final token = CacheHelper.getData(key: 'token');

// Remove data
await CacheHelper.removeData(key: 'token');

// Clear all
await CacheHelper.clear();
```

### 2. Localization Strings: `lib/core/utils/l10n/app_strings.dart`

```dart
class AppStrings {
  // Authentication
  static const String welcomeBackAlt = 'Welcome back';
  static const String login = 'Login';
  static const String createAccount = 'Create Account';
  static const String emailLabel = 'Email Address';
  static const String emailPlaceholder = 'Enter your email';
  static const String passwordLabel = 'Password';
  static const String passwordPlaceholder = 'Enter password';
  
  // Form Validation
  static const String errorPasswordsDoNotMatch = 'Passwords do not match';
  static const String errorIncorrectPassword = 'Incorrect password';
  
  // Onboarding
  static const String completeProfile = 'Complete Profile';
  static const String completeProfileSubtitle = 'Complete your information';
  
  // Settings
  static const String notificationsEnabled = 'Notifications Enabled';
  
  // Generic
  static const String termsAndPrivacy = 'By agreeing, you accept Terms of Service';
}
```

### 3. Language Toggle Widget: `lib/core/widgets/language_toggle.dart`

```dart
class LanguageToggle extends StatelessWidget {
  const LanguageToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            // Switch to Arabic
            // Locale('ar')
          },
          child: const Text('العربية'),
        ),
        SizedBox(width: 8.w),
        const Text('|'),
        SizedBox(width: 8.w),
        GestureDetector(
          onTap: () {
            // Switch to English
            // Locale('en')
          },
          child: const Text('English'),
        ),
      ],
    );
  }
}
```

---

## 🌍 Localization Support

### Implementation

In `main.dart`:

```dart
MaterialApp.router(
  // ... other settings
  locale: const Locale('ar'),  // Arabic
  supportedLocales: const [
    Locale('en', ''),
    Locale('ar', ''),
  ],
  localizationsDelegates: const [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  localeResolutionCallback: (locale, supportedLocales) {
    return supportedLocales.contains(locale)
        ? locale
        : supportedLocales.first;
  },
)
```

### RTL Support

In Widgets:

```dart
Directionality(
  textDirection: TextDirection.rtl,  // Right to left
  child: Scaffold(...),
)
```

---

## 📐 Screen Responsiveness

### ScreenUtil Usage

In `main.dart`:

```dart
ScreenUtilInit(
  designSize: const Size(375, 812),  // Reference screen size
  minTextAdapt: true,
  splitScreenMode: true,
  builder: (context, child) => MaterialApp(...),
)
```

### Application

```dart
// Responsive width
width: 100.w   // 100 responsive units

// Responsive height
height: 50.h   // 50 responsive units

// Responsive font
fontSize: 16.sp  // 16 responsive points

// Half screen
height: 0.5.sh

// Quarter screen
width: 0.25.sw
```

---

## 🏗️ Complete Layer Architecture

```
┌─────────────────────────────────────────┐
│  Presentation Layer (UI)                │
│  • Screens (StatelessWidget)            │
│  • Widgets (Reusable Components)        │
│  • Pages (Organized Views)              │
│  └─ Uses BlocBuilder/Consumer           │
└────────────┬────────────────────────────┘
             │
        Dependency Injection
             │
             ↓
┌─────────────────────────────────────────┐
│  Business Logic Layer (State Management)│
│  • Cubits (State Emitters)              │
│  • Bloc (State Managers)                │
│  └─ Event and state handling            │
└────────────┬────────────────────────────┘
             │
        Dependency Injection
             │
             ↓
┌─────────────────────────────────────────┐
│  Domain Layer (Business Rules)          │
│  • Use Cases (Business Logic)           │
│  • Repositories (Abstractions)          │
│  • Entities (Core Objects)              │
└────────────┬────────────────────────────┘
             │
        Dependency Injection
             │
             ↓
┌─────────────────────────────────────────┐
│  Data Layer (Implementation)            │
│  • Repository Implementations           │
│  • Data Sources (APIs, Local DB)        │
│  • Models (Data Objects)                │
└─────────────────────────────────────────┘
```

---

## 💾 Core Files Summary

| File | Responsibility |
|------|-----------------|
| `injection.dart` | Register dependencies |
| `app_routes.dart` | Define routes |
| `app_colors.dart` | Define colors |
| `app_text.dart` | Define text styles |
| `app_assets.dart` | Define asset paths |
| `app_theme.dart` | Define themes |
| `cache_helper.dart` | Manage local storage |
| `app_strings.dart` | Translated strings |

---

## ✅ Core Checklist

- [ ] All constants in AppStrings
- [ ] All colors from AppColors
- [ ] All text styles from AppText
- [ ] All routes from AppRouter
- [ ] All assets from AppAssets
- [ ] Cubits registered in DI
- [ ] Repositories registered in DI
- [ ] Use Cases registered in DI
- [ ] RTL Support in Widgets
- [ ] ScreenUtil for Responsiveness
- [ ] CacheHelper for Storage

---

**Last Updated:** 2024
**Version:** 1.0
