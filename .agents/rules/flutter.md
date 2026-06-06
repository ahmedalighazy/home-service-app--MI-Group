---
trigger: always_on
---

# PROJECT_RULES.md

This document defines the permanent development rules and standards for the **Home Service App** project. All developers and AI agents must adhere to these rules.

---

## 1. Project Overview

*   **Project Purpose**: A local home service marketplace app (Home, Cleaning, etc.).
*   **Main Architecture**: Feature-first approach with a shared `core` module.
*   **Tech Stack**: Flutter, Dart.
*   **Core Dependencies**:
    *   **State Management**: `flutter_bloc`
    *   **Dependency Injection**: `get_it`
    *   **Routing**: Native `onGenerateRoute` with centralized `AppRouter`.
    *   **Design System**: `flutter_screenutil` (responsive), `google_fonts` (IBM Plex Sans Arabic & Inter).
    *   **Icons**: `iconsax_flutter`, `flutter_svg`.

---

## 2. Folder Structure Rules

The project follows a modular, feature-based structure aimed at clean separation of concerns.

### Core Folder (`lib/core/`)
Contains shared logic and UI components used across the entire app.
*   `constants/`: App-wide constants (sizes, paths, keys).
*   `di/`: Dependency injection setup (`get_it`).
*   `error/`: Error handling and failure classes.
*   `extensions/`: Dart extensions (e.g., `Navigation` on `BuildContext`).
*   `network/`: API clients, interceptors, and network info.
*   `routes/`: Centralized routing configuration.
*   `themes/`: Design system (Colors, Typography, Theming).
*   `utils/`: Helpers, validators, and formatters.
*   `widgets/`: Reusable UI components (Buttons, Inputs, etc.).

### Features Folder (`lib/features/`)
Each feature must be self-contained. The standard structure for a feature is:
```text
feature_name/
├── data/
│   ├── apis/          # API services
│   ├── models/        # Request/Response models
│   └── repositories/  # Data repositories
├── logic/
│   └── cubit/         # Feature-specific Cubits/BLoCs
└── presentation/
    ├── screens/       # Full screen widgets (use "screens" or "pages")
    └── widgets/       # Feature-specific widgets
```

---

## 3. Naming Conventions

### General
*   **Files**: `snake_case.dart` (e.g., `login_screen.dart`).
*   **Classes**: `PascalCase` (e.g., `LoginScreen`).
*   **Variables/Functions**: `camelCase` (e.g., `onTapLogin()`).

### Specific Components
*   **Widgets**: Ends with `Screen`, `Page`, `Widget`, `Card`, or `Content`.
*   **Cubits**: Ends with `Cubit` (e.g., `AuthCubit`).
*   **States**: Ends with `State` (e.g., `AuthState`).
*   **Repositories**: Ends with `Repository` (e.g., `AuthRepository`).
*   **Services/APIs**: Ends with `ApiService` or `Service`.
*   **Models**: Ends with `Model` or `Request`/`Response`.

---

## 4. Feature Creation Rules

When creating a new feature, follow this checklist:

### Required Files
1.  **UI**: Create at least one Screen in `presentation/screens/`.
2.  **Widgets**: Extract sub-components into `presentation/widgets/`.
3.  **Logic**: Create a Cubit and State class in `logic/cubit/`.
4.  **Data**: Create Repository and API service in `data/`.
5.  **Routes**: Add the new route to `lib/core/routes/app_routes.dart`.

### Required Integration
*   **DI**: Register the Cubit, Repository, and API in `lib/core/di/injection.dart`.
*   **Navigation**: Use `context.pushName(AppRouter.featureName)` via the `Navigation` extension.
*   **Theme**: Use `AppColors` and `AppText` for all styling.
*   **Responsiveness**: Use `.h`, `.w`, `.sp`, and `.r` from `ScreenUtil`.

---

## 5. UI Development Rules

*   **Responsiveness**: Always use `flutter_screenutil`.
    *   Heights: `10.h`
    *   Widths: `10.w`
    *   Font Sizes: `14.sp`
    *   Radius: `8.r`
*   **Spacing**: Use helpers from `lib/core/utils/helpers/spacing.dart`.
    *   `verticalSpace(20)` instead of `SizedBox(height: 20.h)`.
    *   `horizontalSpace(10)` instead of `SizedBox(width: 10.w)`.
*   **Layout**: Prefer `CustomScrollView` and `Sliver` widgets for complex scrolling screens.
*   **Standard Sizes**: Use `AppSizes` constants (e.g., `AppSizes.padding`, `AppSizes.radius`).

---

## 6. Theme Rules

*   **Colors**: Never hardcode colors. Use `AppColors`.
    *   `AppColors.primary`, `AppColors.dark`, `AppColors.white`.
*   **Typography**: Never hardcode `TextStyle`. Use `AppText` methods.
    *   `AppText.ibmHeading22()`, `AppText.ibmDescription14()`, `AppText.ibmButton16()`.
*   **Dark Mode**: Ensure widgets respect `Theme.of(context)` or use colors that adapt if planned. Current implementation uses `AppTheme.lightTheme` and `AppTheme.darkTheme`.

---

## 7. Text & Localization Rules

*   **RTL Support**: The app is primary Arabic (RTL). Ensure layouts handle RTL correctly.
*   **Directionality**: `main.dart` wraps the app in a `Directionality` widget based on the current language.
*   **Hardcoded Strings**: Avoid hardcoding Arabic strings in UI. (Future improvement: Use `intl` or a `strings` class).
*   **Font**: IBM Plex Sans Arabic is the primary font for Arabic content.

---

## 8. State Management Rules

*   **Pattern**: Use `flutter_bloc` (Cubit).
*   **State Class**: Use a single state class with `freezed` (if available) or multiple classes (Initial, Loading, Success, Error).
*   **Consistency**:
    *   `emit(LoadingState())` before async operations.
    *   `emit(ErrorState(message))` on failure.
    *   `emit(SuccessState(data))` on success.
*   **UI Binding**: Use `BlocBuilder`, `BlocListener`, or `BlocConsumer` in the presentation layer.

---

## 9. Networking Rules

*   **Implementation**: Planned to use `Dio` (though not yet fully implemented in `core/network`).
*   **Structure**:
    *   `models/`: JSON-serializable classes.
    *   `apis/`: Define endpoints and methods.
    *   `repositories/`: Call APIs and handle local caching/logic.
*   **Error Handling**: Use a standard `Failure` or `Exception` handling mechanism in the data layer.

---

## 10. Dependency Injection Rules

*   **System**: `get_it`.
*   **Registration**: Use `lib/core/di/injection.dart` for all registrations.
*   **Patterns**:
    *   `LazySingleton` for Repositories and API Services.
    *   `Factory` for Cubits (so they are fresh for each screen).

---

## 11. Reusable Widget Rules

*   **Location**: `lib/core/widgets/`.
*   **When to Create**: If a widget is used in more than two features, move it to `core/widgets`.
*   **Naming**: Prefix with `Custom` if it replaces a standard Flutter widget (e.g., `CustomButton`, `CustomTextField`).

---

## 12. Asset Rules

*   **Paths**: Centralize paths in `lib/core/constants/icons_path.dart` and `lib/core/constants/images_path.dart`.
*   **Format**: Prefer SVGs for icons. Use `flutter_svg`.
*   **Organization**:
    *   `assets/icons/`: All SVG icons.
    *   `assets/images/`: JPG/PNG images and illustrations.

---

## 13. Code Quality Rules

*   **Const**: Use `const` constructors whenever possible.
*   **Single Responsibility**: Keep widgets small. Extract large `build` methods into separate private methods or small widgets.
*   **Logic Separation**: ZERO business logic in the UI layer. All logic goes into Cubits.
*   **Cleanliness**: Remove unused imports and commented-out code. Use `analysis_options.yaml` rules.

---

## 14. Feature Template

To add a new feature (e.g., `bookings`):

1.  **Create Folders**:
    ```text
    lib/features/bookings/
    ├── data/
    │   ├── apis/
    │   ├── models/
    │   └── repositories/
    ├── logic/
    │   └── cubit/
    └── presentation/
        ├── screens/
        └── widgets/
    ```
2.  **Define Route**: In `app_routes.dart`:
    ```dart
    static const String bookings = '/bookings';
    // ... in onGenerateRoute ...
    case bookings:
      return fadeRoute(const BookingsScreen());
    ```
3.  **Register DI**: In `injection.dart`:
    ```dart
    getIt.registerFactory(() => BookingsCubit(getIt()));
    getIt.registerLazySingleton(() => BookingsRepository(getIt()));
    ```
4.  **Implement Screen**:
    ```dart
    class BookingsScreen extends StatelessWidget {
      const BookingsScreen({super.key});
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          body: Center(child: Text('Bookings', style: AppText.ibmHeading22())),
        );
      }
    }
    ```
