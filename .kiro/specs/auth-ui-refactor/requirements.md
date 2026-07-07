# Requirements Document

## Introduction

This document defines the requirements for refactoring the Auth UI layer of a Flutter home-service app. The refactoring targets the presentation layer only — Sign In, Sign Up, OTP, Forgot Password, Verify Reset Code, Set New Password, Password Changed, and Complete Profile screens — without altering any business logic, design, or data layer. The goal is to enforce strict separation of concerns, eliminate all logic from UI classes, cap every class at 100 lines, and decompose every reusable UI fragment into its own `StatelessWidget` class.

The data layer (`lib/features/auth/data/`) is untouched throughout this refactoring.

---

## Glossary

- **AuthCubit**: The single Cubit responsible for all auth-related state emissions. UI widgets read state from it but never write to it except by calling its public methods.
- **ForgetPasswordCubit**: The Cubit responsible for the Forgot Password sub-flow state.
- **AuthState**: The sealed class hierarchy of states emitted by `AuthCubit`.
- **Logic Class**: A plain Dart class placed under `lib/features/auth/logic/` that encapsulates a single non-UI responsibility (timers, animations, validation, etc.).
- **AuthLogic**: Logic class that coordinates sign-in, sign-up, and social auth method calls.
- **AuthTimer**: Logic class that encapsulates OTP countdown timer setup and lifecycle.
- **AuthAnimation**: Logic class that encapsulates `AnimationController` setup, lifecycle, and animation objects.
- **PasswordVisibilityController**: Logic class that encapsulates the obscure-text toggle state for password fields.
- **OtpController**: Logic class that encapsulates `TextEditingController` and `FocusNode` management for OTP input fields.
- **FormValidator**: Logic class that contains all form validation functions.
- **LoadingController**: Logic class that provides helpers for reading loading state from `AuthCubit` without mixing it into UI.
- **Screen Widget**: A top-level `StatelessWidget` (or minimal `StatefulWidget`) that owns `BlocProvider` or `BlocConsumer`/`BlocBuilder` and composes child widgets.
- **Presentation Layer**: All code under `lib/features/auth/presentation/`.
- **Logic Layer**: All code under `lib/features/auth/logic/`.
- **Pure UI Widget**: A `StatelessWidget` that contains only layout, styling, and presentation — zero business logic, zero validation logic, zero timers, zero animation controllers, zero API calls, and zero direct state mutations.
- **Widget Method**: A method on a widget class that returns a `Widget` (e.g., `Widget _buildButton(){}`). These are forbidden.

---

## Requirements

### Requirement 1: File Size Constraint

**User Story:** As a developer, I want every Dart class to be at most 100 lines, so that files remain readable and focused on a single concern.

#### Acceptance Criteria

1. THE Refactored_Codebase SHALL contain no Dart class whose line count exceeds 100 lines.
2. WHEN a class would exceed 100 lines, THE Developer SHALL split it into multiple focused classes, each placed in its own file.
3. THE `AuthCubit` class (currently 200+ lines) SHALL be refactored so that its line count does not exceed 100 lines by delegating to Logic Classes.

---

### Requirement 2: Pure UI Constraint

**User Story:** As a developer, I want all UI classes to contain only presentation code, so that the screens have a single, predictable responsibility.

#### Acceptance Criteria

1. THE Screen_Widget SHALL contain no business logic, no validation logic, no timers, no `AnimationController` instantiation, no API calls, and no direct state mutation.
2. THE Screen_Widget SHALL read state exclusively from `AuthCubit` or `ForgetPasswordCubit` via `BlocBuilder`, `BlocConsumer`, or `BlocListener`.
3. WHEN a screen previously contained a `Timer`, THE Screen_Widget SHALL delegate all timer management to `AuthTimer` or a dedicated Logic Class, and SHALL only observe timer state exposed through the Cubit.
4. WHEN a screen previously contained an `AnimationController`, THE Screen_Widget SHALL delegate all animation controller setup and lifecycle to `AuthAnimation`, and SHALL only receive the resulting `Animation` objects.
5. THE Screen_Widget SHALL NOT contain `_showSnackBar()` or any other widget method that returns a `Widget`. Side effects such as SnackBars SHALL be triggered inside a dedicated `BlocListener` widget class.
6. THE Screen_Widget SHALL NOT perform form validation directly. All validation logic SHALL be delegated to `FormValidator` or the existing validators under `presentation/validators/`.
7. THE `SetNewPasswordScreen` SHALL NOT contain `TextEditingController` listeners or `setState` calls for password-match logic. This logic SHALL be managed through `PasswordVisibilityController` and state emitted by the Cubit or a dedicated Logic Class.

---

### Requirement 3: Logic Layer

**User Story:** As a developer, I want all non-UI logic extracted into dedicated Logic Classes under `lib/features/auth/logic/`, so that each class has a single responsibility and is independently testable.

#### Acceptance Criteria

1. THE Logic_Layer SHALL contain the following classes, each in its own file:
   - `AuthLogic` — coordinates sign-in, sign-up, and social auth calls to `AuthCubit`.
   - `AuthTimer` — manages OTP countdown timer state and lifecycle.
   - `AuthAnimation` — manages `AnimationController` creation, configuration, and disposal lifecycle.
   - `PasswordVisibilityController` — manages the obscure-text toggle boolean state for password fields.
   - `OtpController` — manages `TextEditingController` list and `FocusNode` list for OTP digit fields, and exposes auto-focus-advance logic.
   - `FormValidator` — contains all field validation functions (email, password, name, confirm-password match).
2. THE Logic_Classes SHALL NOT import any Flutter widget library (`package:flutter/material.dart` or `package:flutter/widgets.dart`), except `AuthAnimation` which requires `package:flutter/animation.dart` and `TickerProvider`.
3. THE Logic_Classes SHALL be instantiated or injected inside `AuthCubit` or screen-level `StatefulWidget` as appropriate, and SHALL NOT be instantiated directly inside `StatelessWidget` `build` methods.
4. THE `AuthCubit` SHALL use Logic Classes for any coordination logic it previously inlined, reducing its own line count to ≤ 100 lines.

---

### Requirement 4: Cubit Is the Only State Manager

**User Story:** As a developer, I want the Cubit to be the sole class responsible for managing and emitting state, so that state flows in a single predictable direction.

#### Acceptance Criteria

1. THE `AuthCubit` SHALL be the only class that calls `emit()`.
2. THE UI_Widgets SHALL communicate with Logic Classes only indirectly — by calling `AuthCubit` methods, which in turn may delegate to Logic Classes.
3. THE UI_Widgets SHALL NOT hold references to Logic Class instances and call them directly for state-changing operations.
4. WHEN `PasswordVisibilityController` toggle state is needed in the UI, THE `AuthCubit` SHALL expose the toggle state as part of an `AuthState` or a complementary value stream, so the UI reads it from the Cubit.
5. THE `ForgetPasswordCubit` SHALL remain responsible for the Forgot Password email validation and send-code initiation state.

---

### Requirement 5: No Widget Methods

**User Story:** As a developer, I want every reusable UI piece to be a `StatelessWidget` class rather than a method, so that Flutter can optimize widget tree reconciliation correctly.

#### Acceptance Criteria

1. THE Refactored_Codebase SHALL contain no method with the signature `Widget <methodName>(...)` inside any widget class.
2. WHEN a widget method exists in the current code, THE Developer SHALL replace it with a `StatelessWidget` subclass placed in the appropriate widgets file or a dedicated file.
3. THE `_showSnackBar()` method pattern found across multiple screens SHALL be replaced with a dedicated `BlocListener`-based `StatelessWidget` placed in the screen's `widgets/` subfolder.

---

### Requirement 6: Stateless First

**User Story:** As a developer, I want every screen to be a `StatelessWidget` unless Flutter absolutely requires `StatefulWidget`, so that unnecessary rebuilds are avoided and state ownership is clear.

#### Acceptance Criteria

1. THE Screen_Widgets SHALL use `StatelessWidget` unless the screen requires `TickerProvider` (for animations driven by `AuthAnimation`) or lifecycle integration with a Logic Class that requires `initState`/`dispose`.
2. WHERE a `StatefulWidget` is required for a screen, THE `StatefulWidget` SHALL contain no logic beyond delegating to Logic Classes in `initState` and `dispose`, and SHALL NOT hold any business state in its own fields.
3. THE `ForgetScreen` (Forgot Password) SHALL be refactored to a `StatelessWidget` because it currently uses `StatefulWidget` only to hold a `TextEditingController` that belongs in `AuthCubit` or `OtpController`.
4. THE `SignInScreen` and `SignUpScreen` SHALL be refactored to `StatelessWidget` because their `hasError` / `errorMessage` state SHALL be moved into `AuthCubit` state.

---

### Requirement 7: Widget Decomposition

**User Story:** As a developer, I want every distinct UI section on a screen to be its own named `StatelessWidget`, so that widgets are reusable, testable, and self-descriptive.

#### Acceptance Criteria

1. THE Refactored_Codebase SHALL use descriptive class names for every widget (e.g., `LoginPage`, `LoginForm`, `EmailField`, `PasswordField`, `OtpInputRow`, `SignUpHeader`).
2. WHEN a UI fragment is used in more than one screen, THE Fragment SHALL be extracted to `lib/features/auth/presentation/widgets/` as a shared widget.
3. WHEN a UI fragment is specific to a single screen, THE Fragment SHALL be placed in the screen's own `widgets/` subfolder.
4. THE Complete Profile screen SHALL have its animation-wrapping widget decomposed so that `FadeTransition` and `SlideTransition` are encapsulated inside a dedicated widget class that receives the `Animation` objects as constructor parameters.

---

### Requirement 8: Single Responsibility Principle

**User Story:** As a developer, I want every class to have exactly one reason to change, so that modifications in one area do not inadvertently break another.

#### Acceptance Criteria

1. THE `AuthCubit` SHALL be responsible only for managing and emitting `AuthState`. It SHALL NOT contain layout, styling, SnackBar, or navigation logic.
2. THE `AuthTimer` SHALL be responsible only for countdown timer lifecycle. It SHALL NOT contain OTP field management or animation logic.
3. THE `AuthAnimation` SHALL be responsible only for `AnimationController` and `Animation` object creation. It SHALL NOT contain timer or validation logic.
4. THE `OtpController` SHALL be responsible only for managing OTP text controllers, focus nodes, and auto-advance focus logic. It SHALL NOT contain validation or timer logic.
5. THE `FormValidator` SHALL be responsible only for returning validation error strings for form fields. It SHALL NOT emit state or modify controllers.
6. THE `PasswordVisibilityController` SHALL be responsible only for toggling the obscure-text boolean. It SHALL NOT contain any other logic.

---

### Requirement 9: No Design or Functionality Changes

**User Story:** As a product stakeholder, I want the refactoring to produce zero visible changes to the app's UI and zero changes to business functionality, so that users experience no regression.

#### Acceptance Criteria

1. THE Refactored_Screens SHALL produce identical visual output (colors, fonts, padding, spacing, icons, animations) to the original screens.
2. THE Refactored_Screens SHALL preserve all existing navigation flows between screens.
3. THE Refactored_Screens SHALL preserve all existing API call triggers (e.g., login on button press, OTP send on email submit).
4. THE Refactored_Screens SHALL preserve all existing error and success feedback mechanisms (SnackBars, loading indicators).
5. THE Data_Layer (`lib/features/auth/data/`) SHALL NOT be modified in any way.

---

### Requirement 10: Naming Conventions

**User Story:** As a developer, I want all new classes and files to follow consistent, meaningful naming conventions aligned with the existing project style, so that the codebase is easy to navigate.

#### Acceptance Criteria

1. THE Screen_Classes SHALL be named using the `<FeatureName>Screen` or `<FeatureName>Page` pattern (e.g., `SignInScreen`, `OtpScreen`, `CompleteProfileScreen`).
2. THE Logic_Classes SHALL be named descriptively with a noun reflecting their single responsibility (e.g., `AuthTimer`, `FormValidator`, `OtpController`).
3. THE Widget_Classes SHALL be named with the screen or feature prefix and a descriptive suffix (e.g., `SignInEmailField`, `OtpInputRow`, `CompleteProfileForm`).
4. THE Dart files SHALL use `snake_case` naming that mirrors the class name (e.g., `auth_timer.dart`, `form_validator.dart`, `sign_in_email_field.dart`).
5. THE Logic_Layer files SHALL be placed exactly at `lib/features/auth/logic/<file_name>.dart`.

---

### Requirement 11: Performance — `const` Constructors

**User Story:** As a developer, I want `const` constructors used wherever possible, so that Flutter can skip unnecessary widget rebuilds.

#### Acceptance Criteria

1. THE `StatelessWidget` subclasses SHALL declare a `const` constructor when all their fields are compile-time constants or when they have no fields.
2. THE Widget instantiation sites SHALL use the `const` keyword whenever the widget has a `const` constructor and its arguments are compile-time constants.
3. THE Refactored_Codebase SHALL not introduce unnecessary `StatefulWidget` rebuilds caused by placing mutable state in widget fields.

---

### Requirement 12: OTP Screen Logic Extraction

**User Story:** As a developer, I want the `OtpScreen` completely stripped of its timer, animation, and focus management, so that the screen file contains only layout code.

#### Acceptance Criteria

1. THE `OtpScreen` SHALL delegate countdown timer logic to `AuthTimer`.
2. THE `OtpScreen` SHALL delegate shake `AnimationController` and `Animation` setup to `AuthAnimation`.
3. THE `OtpScreen` SHALL delegate `TextEditingController` and `FocusNode` management to `OtpController`.
4. WHEN the OTP verification succeeds, THE `OtpScreen` SHALL react to `OtpVerifiedState` from `AuthCubit` and navigate to `CompleteProfileScreen`.
5. WHEN the OTP verification fails, THE `OtpScreen` SHALL react to `OtpErrorState` from `AuthCubit` and trigger the shake animation via an exposed animation object.
6. THE `OtpScreen` line count SHALL NOT exceed 100 lines.

---

### Requirement 13: Complete Profile Screen Logic Extraction

**User Story:** As a developer, I want the `CompleteProfileScreen` stripped of its `AnimationController`, password toggle methods, and inline validators, so that the screen file contains only layout code.

#### Acceptance Criteria

1. THE `CompleteProfileScreen` SHALL delegate `AnimationController`, `_fadeAnim`, and `_slideAnim` management to `AuthAnimation`.
2. THE `CompleteProfileScreen` SHALL delegate `_obscurePass` and `_obscureConfirm` toggle state to `PasswordVisibilityController`.
3. THE inline validators in `AuthFormField` validator callbacks SHALL be moved to `FormValidator` methods and referenced by name.
4. WHEN the registration succeeds, THE `CompleteProfileScreen` SHALL react to `RegisterSuccessState` from `AuthCubit` and navigate to the home screen.
5. THE `CompleteProfileScreen` line count SHALL NOT exceed 100 lines.

---

### Requirement 14: Check Your Email Screen Logic Extraction

**User Story:** As a developer, I want the `VerificationScreen` (Check Your Email) stripped of its six-controller OTP management, timer, and focus management, so that the screen contains only layout code.

#### Acceptance Criteria

1. THE `VerificationScreen` SHALL delegate six-controller OTP management and focus-advance logic to `OtpController`.
2. THE `VerificationScreen` SHALL delegate countdown timer logic to `AuthTimer`.
3. THE `VerificationScreen` SHALL NOT contain direct `setState` calls for OTP completion checking. Completion state SHALL be derived from `OtpController`-exposed state and surfaced via Cubit or a `ValueNotifier`.
4. WHEN the reset code is verified, THE `VerificationScreen` SHALL react to `ResetCodeVerifiedState` from `AuthCubit` and navigate to `SetNewPasswordScreen`.
5. THE `VerificationScreen` line count SHALL NOT exceed 100 lines.

---

### Requirement 15: Set New Password Screen Logic Extraction

**User Story:** As a developer, I want the `SetNewPasswordScreen` stripped of its `TextEditingController` listeners, `setState` calls for password-match logic, and `_showSnackBar` method, so that the screen contains only layout code.

#### Acceptance Criteria

1. THE `SetNewPasswordScreen` SHALL delegate password-match state (`_isEmpty`, `_isError`, `_isSuccess`, `_getBorderColor`) to a Logic Class or expose it through Cubit state.
2. THE `SetNewPasswordScreen` SHALL delegate obscure-text toggle to `PasswordVisibilityController`.
3. THE `_showSnackBar()` method SHALL be removed from the screen and replaced with a `BlocListener`-based widget in the screen's `widgets/` folder.
4. WHEN the password reset succeeds, THE `SetNewPasswordScreen` SHALL react to `PasswordResetSuccessState` from `AuthCubit` and navigate to the Password Changed screen.
5. THE `SetNewPasswordScreen` line count SHALL NOT exceed 100 lines.

---

### Requirement 16: Sign In Screen Logic Extraction

**User Story:** As a developer, I want the `SignInScreen` stripped of its inline validation guard and SnackBar construction, so that the screen contains only layout code.

#### Acceptance Criteria

1. THE `SignInScreen` SHALL NOT contain inline field-empty checks or SnackBar construction inside `_onLogin()`. These SHALL be delegated to `FormValidator` and a `BlocListener` widget respectively.
2. THE `SignInScreen` SHALL be refactored to `StatelessWidget` with `hasError` state moved into `AuthCubit` state or `AuthLogic`.
3. THE `_onLogin()` logic SHALL be moved to `AuthLogic.onLogin()`, which calls `AuthCubit.login()` after validation.
4. THE `SignInScreen` line count SHALL NOT exceed 100 lines.

---

### Requirement 17: Sign Up Screen Logic Extraction

**User Story:** As a developer, I want the `SignUpScreen` stripped of its inline email validation logic and `hasError` state, so that the screen contains only layout code.

#### Acceptance Criteria

1. THE `SignUpScreen` SHALL NOT contain inline email validation in `_onSendCode()`. Validation SHALL be delegated to `FormValidator.validateEmail()`.
2. THE `SignUpScreen` SHALL be refactored to `StatelessWidget` with `hasError` / `errorMessage` state moved into `AuthCubit` state or a dedicated `AuthState` subclass.
3. THE `SignUpScreen` line count SHALL NOT exceed 100 lines.

---

### Requirement 18: Forgot Password Screen Refactoring

**User Story:** As a developer, I want the `ForgetScreen` converted to a `StatelessWidget` that holds no `TextEditingController` internally, so that the screen is a pure UI composition.

#### Acceptance Criteria

1. THE `ForgetScreen` SHALL be converted to a `StatelessWidget`.
2. THE `_emailController` SHALL be removed from the screen and managed instead inside `ForgetPasswordCubit` or `OtpController`.
3. THE `ForgetScreen` line count SHALL NOT exceed 100 lines.

---

### Requirement 19: BlocListener Isolation

**User Story:** As a developer, I want all Bloc side-effect handling (SnackBars, navigation, dialogs) isolated in dedicated `BlocListener` `StatelessWidget` classes, so that the screen's build method is free of side-effect logic.

#### Acceptance Criteria

1. EVERY screen that currently contains `BlocConsumer` or inline `listener` callbacks with SnackBar/navigation side effects SHALL have those side effects extracted into a dedicated `<ScreenName>BlocListener` `StatelessWidget`.
2. THE `<ScreenName>BlocListener` widgets SHALL use `listenWhen` to filter only relevant states.
3. THE `<ScreenName>BlocListener` widgets SHALL have `const SizedBox.shrink()` as their child when they produce no UI.
4. THE `<ScreenName>BlocListener` widgets SHALL be placed at the bottom of the screen's widget tree inside a `Stack` or `Column`, following the existing project pattern from `SignInBlocListener` and `SignUpBlocListener`.
