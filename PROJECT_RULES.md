# PROJECT_RULES.md

This document defines the permanent development rules and standards for the **Home Service App** project. All developers and AI agents must adhere to these rules.

---

## 1. Project Overview

*   **Project Purpose**: A local home service marketplace app (Home, Cleaning, etc.).
*   **Main Architecture**: Feature-first approach with a shared `core` module.
*   **Tech Stack**: Flutter, Dart.
*   **Core Dependencies**:
    *   **State Management**: `flutter_bloc` (Cubit)
    *   **Dependency Injection**: `get_it`
    *   **Routing**: Native `onGenerateRoute` with centralized `AppRouter` in `lib/core/routes/app_routes.dart`.
    *   **Design System**: `flutter_screenutil` (responsive), `google_fonts` (IBM Plex Sans Arabic & Inter).
    *   **Icons/SVG**: `iconsax_flutter`, `flutter_svg`.

---

## 2. Folder Structure Rules

The project follows a modular, feature-based structure aimed at clean separation of concerns.

### Core Folder (`lib/core/`)
Contains shared logic and UI components used across the entire app.
*   `constants/`: App-wide constants (sizes, paths, keys).
*   `di/`: Dependency injection setup (`injection.dart`).
*   `error/`: Error handling and failure classes.
*   `extensions/`: Dart extensions (e.g., `Navigation` on `BuildContext`).
*   `network/`: API clients, interceptors, and network info.
*   `routes/`: Centralized routing configuration.
*   `themes/`: Design system (Colors, Typography, Theming).
*   `utils/`: Helpers, validators, and formatters (`helpers/`, `l10n/`).
*   `widgets/`: Reusable UI components (Buttons, Inputs, etc.).

### Features Folder (`lib/features/`)
Each feature must be self-contained. Standard structure:
```text
feature_name/
├── data/
│   ├── apis/          # API services
│   ├── models/        # Request/Response models
│   └── repositories/  # Data repositories
├── logic/
│   └── cubit/         # Feature-specific Cubits/BLoCs
└── presentation/
    ├── screens/       # Full screen widgets
    └── widgets/       # Feature-specific widgets
```

**Feature Specifics**:
- **Settings**: All help center and support-related screens (`faq`, `legal`, etc.) must be in `features/setting`.
- **Profile**: Account management, addresses, and payment methods must be in `features/profile`.

---

## 3. Naming Conventions

### General
*   **Files**: `snake_case.dart`.
*   **Classes**: `PascalCase`.
*   **Variables/Functions**: `camelCase`.

### Specific Components
*   **Widgets**: Ends with `Screen`, `Page`, `Widget`, `Card`, or `Content`.
*   **Cubits**: Ends with `Cubit` (e.g., `AuthCubit`).
*   **States**: Ends with `State`.
*   **Repositories**: Ends with `Repository`.
*   **Services/APIs**: Ends with `ApiService` or `Service`.
*   **Models**: Ends with `Model`, `Request`, or `Response`.
*   **Core Widgets**: Prefix with `Custom` (e.g., `CustomButton`).

---

## 4. Feature Creation Rules

Checklist for creating new features:

### Required Files
1.  **UI**: Screen in `presentation/screens/`.
2.  **Widgets**: Sub-components in `presentation/widgets/`.
3.  **Logic**: Cubit and State in `logic/cubit/`.
4.  **Data**: Repository and API service in `data/`.
5.  **Routes**: Update `lib/core/routes/app_routes.dart`.

### Required Integration
*   **DI**: Register in `lib/core/di/injection.dart`.
*   **Navigation**: Use `context.pushName(AppRouter.featureName)`.
*   **Theme**: Use `AppColors` and `AppText`.
*   **Responsiveness**: Always use `flutter_screenutil` extensions (`.h`, `.w`, `.sp`, `.r`).

---

## 5. UI Development Rules

*   **Responsive Units**:
    *   Heights: `10.h`
    *   Widths: `10.w`
    *   Font Sizes: `14.sp`
    *   Radius: `8.r`
*   **Spacing**: Use `verticalSpace(20)` or `SizedBox(height: 20.h)`. Prefer constants from `AppSizes`.
*   **Assets**: Centralize paths in `icons_path.dart` or similar. Use `SvgPicture.asset` for icons.

---

## 6. Theme Rules

*   **Colors**: NEVER hardcode hex values. Always use `AppColors`.
*   **Text Styles**: NEVER hardcode `TextStyle`. Use `AppText` static methods/getters.
    *   Example: `AppText.ibmHeading22()`.

---

## 7. Text & Localization Rules

*   **RTL**: Primary language is Arabic. Use `Directionality(textDirection: TextDirection.rtl)`.
*   **Strings**: Use constants from `AppStrings` classes.

---

## 8. State Management Rules

*   **Pattern**: `flutter_bloc` (Cubit).
*   **States**:
    *   `Initial`, `Loading`, `Success`, `Error`.
    *   Include meaningful error messages in `ErrorState`.
*   **UI**: Use `BlocBuilder` or `BlocConsumer`.

---

## 9. Networking Rules

*   **Implementation**: Use `Dio` (planned) or defined API layer.
*   **Serialization**: Models must handle JSON mapping.
*   **Error Handling**: Wrap API calls in try-catch and return custom `Failure` objects in Repositories.

---

## 10. Dependency Injection Rules

*   **System**: `get_it`.
*   **Patterns**:
    *   Lazy Singletons for Repositories and Services.
    *   Factory for Cubits.
*   **File**: All registrations must be in `lib/core/di/injection.dart`.

---

## 11. Reusable Widget Rules

*   **Placement**: `lib/core/widgets/`.
*   **Rule**: If a widget is shared by >1 feature, it becomes a `Custom` widget in core.

---

## 12. Asset Rules

*   **Icons**: SVGs in `assets/icons/`.
*   **Images**: PNG/JPG in `assets/images/`.
*   **Naming**: `snake_case`.

---

## 13. Code Quality Rules

*   **Const**: Use `const` where possible.
*   **Logic**: Zero business logic in UI.
*   **Size**: Keep build methods clean; extract complex widgets.

---

## 14. Pull Request Rules

*   **Branching**: gitflow-like (feature/, bugfix/).
*   **Commits**: Conventional commits (feat:, fix:, chore:, refactor:).
*   **Reviews**: Check for responsive scaling and theme adherence.

---

## 15. Feature Template

Example `bookings` feature:
```text
lib/features/bookings/
├── data/
│   ├── apis/bookings_api_service.dart
│   ├── models/booking_model.dart
│   └── repositories/bookings_repository.dart
├── logic/
│   └── cubit/bookings_cubit.dart
└── presentation/
    ├── screens/bookings_screen.dart
    └── widgets/booking_card.dart
```
