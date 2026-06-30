# Design Document — Auth UI Refactor

## Overview

This document describes the technical design for refactoring the Auth presentation layer of the Flutter home-service app. The scope is strictly the `lib/features/auth/presentation/` directory plus a new `lib/features/auth/logic/` directory. No data layer, design tokens, colors, or navigation routes are changed.

The core problem is that every auth screen is a `StatefulWidget` that mixes timer management, animation controllers, OTP field state, password-match logic, form validators, and `_showSnackBar()` helpers directly into the screen file. This produces classes that are 150–250 lines, impossible to unit-test, and difficult to reason about.

The solution is a **two-layer split**:

1. **Logic Layer** (`lib/features/auth/logic/`) — plain Dart classes with zero widget imports (except `AuthAnimation` which needs `flutter/animation.dart`). Each class owns exactly one non-UI responsibility.
2. **Presentation Layer** (unchanged location) — screens become thin `StatelessWidget` or minimal `StatefulWidget` compositors; all side effects move into dedicated `BlocListener` `StatelessWidget` classes.

`AuthCubit` retains ownership of all `TextEditingController`s and `GlobalKey<FormState>`s (already the project convention) and shrinks to ≤ 100 lines by removing inline logic that belongs to Logic Classes.

---

## Architecture

```
lib/features/auth/
├── data/                          ← UNTOUCHED
│
├── logic/                         ← NEW — plain Dart, no widget imports
│   ├── auth_logic.dart            ← AuthLogic
│   ├── auth_timer.dart            ← AuthTimer
│   ├── auth_animation.dart        ← AuthAnimation
│   ├── password_visibility_controller.dart  ← PasswordVisibilityController
│   ├── otp_controller.dart        ← OtpController
│   └── form_validator.dart        ← FormValidator
│
└── presentation/
    ├── cubits/
    │   ├── auth_cubit.dart        ← trimmed to ≤100 lines; keeps controllers + formKeys
    │   ├── auth_state.dart        ← adds ValidationErrorState, PasswordVisibilityState
    │   └── forget_password_cubit.dart  ← unchanged
    │
    ├── screens/
    │   ├── sign_in/
    │   │   ├── sign_in_screen.dart          ← StatelessWidget
    │   │   └── widgets/
    │   │       ├── sign_in_body.dart
    │   │       ├── sign_in_header.dart
    │   │       ├── email_input_field.dart
    │   │       ├── password_input_field.dart
    │   │       ├── remember_me_section.dart
    │   │       ├── remember_me_checkbox.dart
    │   │       ├── social_sign_in_buttons.dart
    │   │       ├── login_button.dart
    │   │       ├── footer_link.dart
    │   │       └── sign_in_bloc_listener.dart   ← already exists, unchanged
    │   │
    │   ├── sign_up/
    │   │   ├── sign_up_screen.dart          ← StatelessWidget
    │   │   └── widgets/
    │   │       ├── sign_up_body.dart
    │   │       ├── phone_input_field.dart
    │   │       ├── guest_mode_button.dart
    │   │       └── sign_up_bloc_listener.dart   ← already exists, unchanged
    │   │
    │   ├── otp/
    │   │   ├── otp_screen.dart              ← StatefulWidget (TickerProvider)
    │   │   └── widgets/
    │   │       ├── otp_input_row.dart        ← already exists
    │   │       ├── otp_confirm_button.dart   ← already exists
    │   │       ├── otp_field_state.dart      ← already exists
    │   │       ├── otp_timer_display.dart    ← NEW
    │   │       ├── otp_resend_row.dart       ← NEW
    │   │       └── otp_bloc_listener.dart    ← NEW
    │   │
    │   ├── complete_profile/
    │   │   ├── complete_profile_screen.dart ← StatefulWidget (TickerProvider)
    │   │   └── widgets/
    │   │       ├── complete_profile_widget.dart  ← existing (ProfileAvatar, CompleteProfileHeader)
    │   │       ├── complete_profile_form.dart    ← NEW
    │   │       ├── animated_profile_wrapper.dart ← NEW
    │   │       └── complete_profile_bloc_listener.dart ← NEW
    │   │
    │   ├── check_your_email/
    │   │   ├── check_your_email_screen.dart ← StatefulWidget (OtpController lifecycle)
    │   │   └── widgets/
    │   │       ├── check_your_email_widgets.dart ← existing
    │   │       ├── check_email_otp_row.dart      ← NEW
    │   │       └── check_email_bloc_listener.dart ← NEW
    │   │
    │   ├── set_new_password/
    │   │   ├── set_new_password_screen.dart ← StatefulWidget (PasswordVisibilityController)
    │   │   └── widget/
    │   │       ├── set_new_widgets.dart     ← existing
    │   │       └── set_new_password_bloc_listener.dart ← NEW
    │   │
    │   ├── forget_password/
    │   │   ├── forget_password_screen.dart  ← StatelessWidget (refactored)
    │   │   └── widget/
    │   │       ├── forget_pass_widget.dart  ← existing
    │   │       └── forget_password_bloc_listener.dart ← existing, unchanged
    │   │
    │   ├── verify_reset_code/
    │   │   ├── verify_reset_code_screen.dart ← StatefulWidget (TickerProvider)
    │   │   └── widget/
    │   │       ├── verify_reset_code_widgets.dart ← existing
    │   │       └── verify_reset_code_bloc_listener.dart ← NEW
    │   │
    │   └── password_changed/
    │       ├── password_changed_screen.dart ← StatelessWidget (already is)
    │       └── widget/
    │           └── pass_widgets.dart        ← existing
    │
    ├── validators/                ← existing, kept for backward compat
    │   ├── otp_validator.dart
    │   ├── profile_validator.dart
    │   ├── sign_in_validator.dart
    │   └── sign_up_validator.dart
    │
    └── widgets/                   ← existing shared widgets, unchanged
        ├── auth_form_field.dart
        ├── auth_primary_button.dart
        ├── auth_social_button.dart
        ├── auth_back_button.dart
        ├── auth_footer_link.dart
        ├── auth_or_divider.dart
        ├── auth_text_field.dart
        ├── sign_up_app_bar.dart
        └── terms_and_privacy_text.dart
```

### Data Flow

```
Screen (StatelessWidget / thin StatefulWidget)
   │  reads state from
   ▼
AuthCubit / ForgetPasswordCubit
   │  delegates coordination to
   ▼
Logic Classes (AuthLogic, AuthTimer, AuthAnimation,
               PasswordVisibilityController, OtpController, FormValidator)
   │  pure return values / callbacks only
   ▼
AuthState emitted by Cubit → consumed by BlocListener widgets → side effects
```

---

## Components and Interfaces

### Logic Layer

#### `AuthLogic`

Coordinates sign-in, sign-up, and social auth cubit method calls after running `FormValidator` checks. Produces a `ValidationErrorState` when validation fails so the UI can read it from the Cubit.

```dart
// lib/features/auth/logic/auth_logic.dart
import 'package:flutter/foundation.dart'; // VoidCallback only — no widget imports

class AuthLogic {
  final AuthCubit _cubit;

  const AuthLogic(this._cubit);

  /// Validates email + password, then calls cubit.login.
  /// Emits ValidationErrorState if validation fails.
  void onLogin({required String email, required String password});

  /// Validates email, then calls cubit.sendSmsCode.
  void onSendCode({required String email});

  void onGoogleSignIn();
  void onAppleSignIn();
  void onGoogleSignUp();
  void onAppleSignUp();
  void onLoginAsGuest();
}
```

**Imports required:** none from `flutter/material.dart`. Uses only the cubit reference.

---

#### `AuthTimer`

Manages a countdown timer. Exposes remaining seconds and `canResend` via a `Stream<AuthTimerState>` so screens can subscribe without holding a `Timer` directly. The Logic Class owns the `Timer` and its lifecycle.

```dart
// lib/features/auth/logic/auth_timer.dart
import 'dart:async';

class AuthTimerState {
  final int secondsLeft;
  final bool canResend;
  const AuthTimerState({required this.secondsLeft, required this.canResend});
}

class AuthTimer {
  static const int defaultSeconds = 59;

  AuthTimer({this.totalSeconds = defaultSeconds});

  final int totalSeconds;

  /// Broadcasts timer ticks. Closes when timer completes or dispose() is called.
  Stream<AuthTimerState> get stream => _controller.stream;

  int get secondsLeft => _secondsLeft;
  bool get canResend => _canResend;

  /// Starts (or restarts) the countdown.
  void start();

  /// Cancels the active timer and closes the stream controller.
  void dispose();
}
```

**Imports required:** `dart:async` only. No Flutter imports.

---

#### `AuthAnimation`

Creates and manages an `AnimationController` and its child animations. Requires a `TickerProvider` (supplied by the owning `StatefulWidget` via `SingleTickerProviderStateMixin`). Exposes the finished `Animation<double>` objects for the screen to pass down to child widgets.

```dart
// lib/features/auth/logic/auth_animation.dart
import 'package:flutter/animation.dart';

/// Manages a single AnimationController and up to two derived animations.
/// Instantiate inside initState; call dispose() inside dispose().
class AuthAnimation {
  AuthAnimation({
    required TickerProvider vsync,
    required Duration duration,
    this.forwardOnCreate = false,
  });

  final TickerProvider vsync;
  final Duration duration;
  final bool forwardOnCreate;

  late final AnimationController controller;

  /// Fade animation (0→1 ease-out). Non-null after init().
  late final Animation<double> fadeAnimation;

  /// Slide animation (Offset(0, 0.08)→Offset.zero ease-out). Non-null after init().
  late final Animation<Offset> slideAnimation;

  /// Shake animation (TweenSequence horizontal offsets). Non-null after init().
  late final Animation<double> shakeAnimation;

  /// Must be called in StatefulWidget.initState() after construction.
  void init();

  /// Plays the shake sequence from 0.0.
  void shake();

  /// Must be called in StatefulWidget.dispose().
  void dispose();
}
```

**Imports required:** `package:flutter/animation.dart` only. No widget/material imports.

---

#### `PasswordVisibilityController`

Wraps two independent `ValueNotifier<bool>` instances for password and confirm-password obscure state. The screen (or Cubit) reads `passwordNotifier.value` and calls `togglePassword()`.

```dart
// lib/features/auth/logic/password_visibility_controller.dart

class PasswordVisibilityController {
  PasswordVisibilityController({
    bool initialPassword = true,
    bool initialConfirm = true,
  });

  final ValueNotifier<bool> passwordNotifier;    // true = obscured
  final ValueNotifier<bool> confirmNotifier;     // true = obscured

  bool get isPasswordObscured => passwordNotifier.value;
  bool get isConfirmObscured => confirmNotifier.value;

  void togglePassword();
  void toggleConfirm();

  void dispose();
}
```

**Imports required:** `package:flutter/foundation.dart` (`ValueNotifier`). No widget imports.

---

#### `OtpController`

Manages a fixed-length list of `TextEditingController`s and `FocusNode`s. Handles auto-advance-on-input and back-focus-on-delete. Exposes `otpCode` (joined text), `isComplete` (all slots filled), and a `completionStream`.

```dart
// lib/features/auth/logic/otp_controller.dart
import 'dart:async';
import 'package:flutter/services.dart'; // TextEditingController, FocusNode

class OtpController {
  OtpController({required this.length});

  final int length;

  late final List<TextEditingController> controllers;
  late final List<FocusNode> focusNodes;

  /// Returns the joined text of all controllers (no separator).
  String get otpCode;

  /// True when every slot contains exactly one character.
  bool get isComplete;

  /// Emits true whenever all slots become filled, false when any slot clears.
  Stream<bool> get completionStream;

  /// Call from the onChanged callback of each digit field.
  /// Advances or retreats focus automatically.
  void handleChange(String value, int index);

  /// Pre-fills all slots from a 6-character string (e.g. deep-link code).
  void prefill(String code);

  /// Clears all slots and moves focus to the first node.
  void clear();

  /// Must be called in StatefulWidget.dispose().
  void dispose();
}
```

**Imports required:** `dart:async`, `package:flutter/services.dart` (for `TextEditingController`, `FocusNode`). No material/widget imports.

---

#### `FormValidator`

Pure static validation methods. Returns `null` on success, a localised error string on failure. Unifies validation logic currently spread across four files in `presentation/validators/`.

```dart
// lib/features/auth/logic/form_validator.dart

class FormValidator {
  FormValidator._(); // non-instantiable

  /// Returns null if email matches RFC-5322-lite pattern, else error string.
  static String? validateEmail(String? value);

  /// Returns null if password is non-empty and length >= 6.
  static String? validatePassword(String? value);

  /// Returns null if name is non-empty (trimmed).
  static String? validateName(String? value);

  /// Returns null if [confirm] == [password] and both are non-empty.
  static String? validateConfirmPassword(String? value, String password);

  /// Returns null if both email/password are non-empty.
  /// Convenience guard used by AuthLogic before calling cubit.login().
  static String? validateNonEmpty(String? value, String fieldName);
}
```

**Imports required:** none. Pure Dart.

---

### AuthCubit Changes

**Kept (unchanged):**

- All `TextEditingController` fields (`emailCtrl`, `passwordCtrl`, `signUpEmailCtrl`, `nameCtrl`, `phoneCtrl`, `newPasswordCtrl`, `confirmPasswordCtrl`)
- All `GlobalKey<FormState>` fields
- `resetState()`
- All async methods (`login`, `sendSmsCode`, `verifyOtp`, `register`, `sendResetCode`, `verifyResetCode`, `resetPassword`, `signOut`, social sign-in/sign-up methods)
- `close()` override that disposes controllers

**Removed / delegated:**

- Inline validation guards inside `login()` — moved to `AuthLogic.onLogin()`
- Any future timer or animation code — delegated to Logic Classes
- Line count target: ≤ 100 lines (achieved by removing all inline logic already present only in screens, not in cubit; the cubit is already close to this target once `auth_state.dart` remains a `part` file)

**Estimated line count after refactor:** ~105 lines including comments → split `close()` to a `_disposeControllers()` private helper to reach ≤ 100.

---

### AuthState Additions

Two new state classes are added to `auth_state.dart`:

```dart
/// Emitted by AuthCubit (via AuthLogic) when client-side validation fails
/// before an API call is made. Carries per-field error messages.
final class ValidationErrorState extends AuthState {
  final String? emailError;
  final String? passwordError;
  final String? generalError;
  ValidationErrorState({this.emailError, this.passwordError, this.generalError});
}

/// Emitted whenever PasswordVisibilityController state changes so
/// StatelessWidget screens can read it from the Cubit.
final class PasswordVisibilityState extends AuthState {
  final bool isPasswordObscured;
  final bool isConfirmObscured;
  const PasswordVisibilityState({
    required this.isPasswordObscured,
    required this.isConfirmObscured,
  });
}
```

`ValidationErrorState` allows `SignInScreen` and `SignUpScreen` to become `StatelessWidget` — they read error messages from the Cubit state instead of holding `hasError`/`errorMessage` in local `setState`.

`PasswordVisibilityState` allows `SetNewPasswordScreen` and `CompleteProfileScreen` to read obscure-text state from the Cubit instead of local `bool` fields with `setState`.

---

## Data Models

No new data models are introduced. The existing `AuthState` sealed hierarchy is extended with two states (see above). Logic Classes use only primitive types and Flutter's built-in controller types as their public surface.

### OtpController internal model

```dart
// Conceptual — lives inside otp_controller.dart
class _OtpSlot {
  final TextEditingController controller;
  final FocusNode focusNode;
}
```

### AuthTimerState (value object)

```dart
class AuthTimerState {
  final int secondsLeft;
  final bool canResend;
  const AuthTimerState({required this.secondsLeft, required this.canResend});
}
```

---

## Screen-by-Screen Refactor Plan

### 1. Sign In Screen

| Attribute    | Before                                   | After                                                                                                                     |
| ------------ | ---------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| Widget type  | `StatefulWidget`                         | `StatelessWidget`                                                                                                         |
| Local state  | `hasError`, `rememberMe`                 | Removed; `hasError` via `ValidationErrorState`; `rememberMe` remains local in `SignInBody` or promoted to Cubit if needed |
| Inline logic | `_onLogin()` with empty-check + SnackBar | Delegated to `AuthLogic.onLogin()`                                                                                        |
| BlocListener | `SignInBlocListener` (exists)            | Unchanged                                                                                                                 |

`rememberMe` is purely UI preference state with no effect on Cubit state; it can remain in a child `StatefulWidget` (`RememberMeCheckbox`) rather than the screen.

---

### 2. Sign Up Screen

| Attribute    | Before                          | After                                      |
| ------------ | ------------------------------- | ------------------------------------------ |
| Widget type  | `StatefulWidget`                | `StatelessWidget`                          |
| Local state  | `hasError`, `errorMessage`      | Removed; moved into `ValidationErrorState` |
| Inline logic | `_onSendCode()` validates email | Delegated to `AuthLogic.onSendCode()`      |
| BlocListener | `SignUpBlocListener` (exists)   | Unchanged                                  |

---

### 3. OTP Screen (Registration)

| Attribute             | Before                                        | After                                                                                                                                                                         |
| --------------------- | --------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Widget type           | `StatefulWidget`                              | `StatefulWidget` (kept — needs `SingleTickerProviderStateMixin`)                                                                                                              |
| Extracted to          | `AuthTimer`, `AuthAnimation`, `OtpController` | Screen holds instances in `initState`/`dispose` only                                                                                                                          |
| Local state remaining | `_fieldState` (OtpFieldState enum)            | Kept; driven by `OtpBlocListener` calling back into screen via a `ValueNotifier<OtpFieldState>` stored in state, or via `setState` in the listener — see BlocListener section |
| BlocListener          | Inline `BlocConsumer` listener                | `OtpBlocListener` (new `StatelessWidget`)                                                                                                                                     |

---

### 4. Complete Profile Screen

| Attribute         | Before                                                          | After                                                                                                                                                                                           |
| ----------------- | --------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Widget type       | `StatefulWidget`                                                | `StatefulWidget` (kept — needs `TickerProvider`)                                                                                                                                                |
| Extracted to      | `AuthAnimation` (fade+slide), `PasswordVisibilityController`    | Screen `initState` creates `AuthAnimation`, calls `init()`, then forwards                                                                                                                       |
| Local controllers | `_nameCtrl`, `_identifierCtrl`, `_passCtrl`, `_confirmPassCtrl` | **Removed from screen** — replaced by `AuthCubit.nameCtrl`, `AuthCubit.newPasswordCtrl`, `AuthCubit.confirmPasswordCtrl` (already exist); `_identifierCtrl` maps to `AuthCubit.signUpEmailCtrl` |
| Inline validators | Anonymous lambdas in `AuthFormField.validator`                  | Replaced by `FormValidator.validateName`, `validateEmail`, `validatePassword`, `validateConfirmPassword`                                                                                        |
| BlocListener      | Inline `BlocConsumer` listener                                  | `CompleteProfileBlocListener` (new)                                                                                                                                                             |

---

### 5. Check Your Email Screen (VerificationScreen)

| Attribute          | Before                                               | After                                                             |
| ------------------ | ---------------------------------------------------- | ----------------------------------------------------------------- |
| Widget type        | `StatefulWidget`                                     | `StatefulWidget` (kept — OtpController lifecycle)                 |
| Extracted to       | `OtpController` (6 controllers + focus), `AuthTimer` | Screen creates both in `initState`                                |
| `_isButtonEnabled` | Local `setState`                                     | Replaced by `OtpController.isComplete` — read directly in `build` |
| `_showSnackBar`    | Inline method                                        | `CheckEmailBlocListener` widget                                   |
| BlocListener       | Inline `BlocListener`                                | `CheckEmailBlocListener` (new)                                    |

---

### 6. Set New Password Screen

| Attribute            | Before                                                                                           | After                                                                                                                                           |
| -------------------- | ------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| Widget type          | `StatefulWidget`                                                                                 | `StatefulWidget` (kept — `PasswordVisibilityController` lifecycle + listeners on `AuthCubit.newPasswordCtrl`)                                   |
| Extracted to         | `PasswordVisibilityController`                                                                   | Screen creates it in `initState`                                                                                                                |
| Password-match logic | `_password`, `_confirmPassword` strings + `_isEmpty`/`_isError`/`_isSuccess`/`_getBorderColor()` | Computed from `AuthCubit.newPasswordCtrl.text` / `AuthCubit.confirmPasswordCtrl.text` directly in `build` via static helpers in `FormValidator` |
| Controllers          | 2 local `TextEditingController`s                                                                 | Replaced by `AuthCubit.newPasswordCtrl` and `AuthCubit.confirmPasswordCtrl`                                                                     |
| `_showSnackBar`      | Inline method                                                                                    | `SetNewPasswordBlocListener` (new)                                                                                                              |

---

### 7. Forgot Password Screen

| Attribute          | Before                                           | After                                                                                                                            |
| ------------------ | ------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------- |
| Widget type        | Outer `StatelessWidget` + inner `StatefulWidget` | Single `StatelessWidget`                                                                                                         |
| `_emailController` | Owned by `_ForgetScreenContentState`             | Removed; `ForgetPasswordCubit` already stores the email string via `updateEmail()`; field reads from `ForgetPasswordCubit` state |
| BlocListener       | `ForgetPasswordBlocListener` (exists)            | Unchanged                                                                                                                        |

---

### 8. Verify Reset Code Screen

| Attribute                    | Before                                                               | After                                                        |
| ---------------------------- | -------------------------------------------------------------------- | ------------------------------------------------------------ |
| Widget type                  | `StatefulWidget`                                                     | `StatefulWidget` (kept — `TickerProvider` + `OtpController`) |
| Extracted to                 | `AuthAnimation` (shake), `OtpController` (single controller + focus) | Created in `initState`                                       |
| Inline SnackBar + navigation | In `BlocConsumer` listener                                           | `VerifyResetCodeBlocListener` (new)                          |

---

### 9. Password Changed Screen

Already a `StatelessWidget` using `PasswordChangedLogic`. No changes needed.

---

## Widget Decomposition Table

New named `StatelessWidget` classes to be created (existing widgets not repeated):

| Widget Class                  | File                                                            | Screen            | Description                                                                                               |
| ----------------------------- | --------------------------------------------------------------- | ----------------- | --------------------------------------------------------------------------------------------------------- |
| `OtpTimerDisplay`             | `otp/widgets/otp_timer_display.dart`                            | OTP               | Shows `0:SS` countdown text with `AnimatedSwitcher`                                                       |
| `OtpResendRow`                | `otp/widgets/otp_resend_row.dart`                               | OTP               | Resend link + prompt text row                                                                             |
| `OtpBlocListener`             | `otp/widgets/otp_bloc_listener.dart`                            | OTP               | Listens to `OtpVerifiedState`, `OtpErrorState`, `OtpSentState`                                            |
| `CompleteProfileForm`         | `complete_profile/widgets/complete_profile_form.dart`           | Complete Profile  | `Form` widget with 4 `AuthFormField`s wired to cubit controllers                                          |
| `AnimatedProfileWrapper`      | `complete_profile/widgets/animated_profile_wrapper.dart`        | Complete Profile  | Wraps `FadeTransition` + `SlideTransition`; accepts `Animation<double>` and `Animation<Offset>` as params |
| `CompleteProfileBlocListener` | `complete_profile/widgets/complete_profile_bloc_listener.dart`  | Complete Profile  | Listens to `RegisterSuccessState`, `AuthErrorState`                                                       |
| `CheckEmailOtpRow`            | `check_your_email/widgets/check_email_otp_row.dart`             | Check Your Email  | Row of 6 `OtpCircleField`s wired to `OtpController`                                                       |
| `CheckEmailBlocListener`      | `check_your_email/widgets/check_email_bloc_listener.dart`       | Check Your Email  | Listens to `ResetCodeVerifiedState`, `ResetCodeError`, `AuthErrorState`, `ResetCodeSentState`             |
| `SetNewPasswordBlocListener`  | `set_new_password/widget/set_new_password_bloc_listener.dart`   | Set New Password  | Listens to `PasswordResetSuccessState`, `PasswordResetErrorState`, `AuthErrorState`                       |
| `VerifyResetCodeBlocListener` | `verify_reset_code/widget/verify_reset_code_bloc_listener.dart` | Verify Reset Code | Listens to `ResetCodeVerifiedState`, `ResetCodeError`, `AuthErrorState`, `ResetCodeSentState`             |

---

## BlocListener Isolation

Every screen's side effects are handled by a dedicated `<ScreenName>BlocListener` `StatelessWidget` placed inside a `Stack` at the bottom of the widget tree, with `child: const SizedBox.shrink()`.

| BlocListener Class            | States Listened To                                                                                                              | Side Effects                                                                                                                                           |
| ----------------------------- | ------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `SignInBlocListener`          | `LoginSuccessState`, `RegisterSuccessState`, `GuestLoginSuccessState`, `AuthErrorState`, `ValidationErrorState`                 | Navigate to home on success; SnackBar on error; no-op for validation (field UI reacts to state directly)                                               |
| `SignUpBlocListener`          | `OtpSentState`, `RegisterSuccessState`, `GuestLoginSuccessState`, `LoginSuccessState`, `AuthErrorState`, `ValidationErrorState` | `push(AppRouter.otp)` on OTP sent; navigate to home on register/guest/login; SnackBar on error                                                         |
| `OtpBlocListener`             | `OtpVerifiedState`, `OtpErrorState`, `AuthErrorState`, `OtpSentState`                                                           | Navigate to `completeProfile` on verified (500 ms delay); trigger `AuthAnimation.shake()` + SnackBar on error; success SnackBar on resend              |
| `CompleteProfileBlocListener` | `RegisterSuccessState`, `AuthErrorState`                                                                                        | Navigate to home on success; SnackBar on error                                                                                                         |
| `CheckEmailBlocListener`      | `ResetCodeVerifiedState`, `ResetCodeError`, `AuthErrorState`, `ResetCodeSentState`                                              | Push `setNewPassword` on verified; SnackBar on error; success SnackBar on resend                                                                       |
| `SetNewPasswordBlocListener`  | `PasswordResetSuccessState`, `PasswordResetErrorState`, `AuthErrorState`                                                        | Navigate to `passwordChangedSuccessfully` on success; SnackBar on error                                                                                |
| `VerifyResetCodeBlocListener` | `ResetCodeVerifiedState`, `ResetCodeError`, `AuthErrorState`, `ResetCodeSentState`                                              | Push `setNewPassword` on verified (500 ms delay + field state update); trigger `AuthAnimation.shake()` + SnackBar on error; success SnackBar on resend |
| `ForgetPasswordBlocListener`  | `ForgetPasswordSendCodeRequested` (from `ForgetPasswordCubit`)                                                                  | Calls `AuthCubit.sendResetCode()`; navigates to `checkYourEmail` on `ResetCodeSentState`                                                               |

**`listenWhen` pattern** (applied to all):

```dart
listenWhen: (previous, current) =>
    current is TargetState1 || current is TargetState2,
```

---

## Correctness Properties

_A property is a characteristic or behavior that should hold true across all valid executions of a system — essentially, a formal statement about what the system should do. Properties serve as the bridge between human-readable specifications and machine-verifiable correctness guarantees._

PBT applies here because the Logic Classes are pure Dart with clear input/output behavior. `FormValidator`, `OtpController`, `PasswordVisibilityController`, `AuthTimer`, and `AuthLogic` are all functions of their inputs — no external services, no I/O, no Flutter rendering. The property-based testing library for Dart is [**dart_test** + **glados**](https://pub.dev/packages/glados) (`glados: ^0.6.0`).

---

### Property 1: FormValidator email accepts only well-formed addresses

**Validates: Requirements 2.6, 3.1, 13.3, 16.1, 17.1**

_For any_ string `s`, `FormValidator.validateEmail(s)` returns `null` if and only if `s` matches the RFC-5322-lite pattern `^[^\s@]+@[^\s@]+\.[^\s@]+$` with a non-empty local part, domain, and TLD; otherwise it returns a non-null error string.

### Property 2: FormValidator password gate

**Validates: Requirements 2.6, 3.1, 13.3**

_For any_ string `s`, `FormValidator.validatePassword(s)` returns `null` if and only if `s` is non-empty AND `s.length >= 6`; otherwise it returns a non-null error string.

### Property 3: FormValidator confirm-password match

**Validates: Requirements 2.7, 3.1, 13.3, 15.1**

_For any_ pair of strings `(password, confirm)`, `FormValidator.validateConfirmPassword(confirm, password)` returns `null` if and only if both are non-empty AND `confirm == password`; otherwise it returns a non-null error string.

### Property 4: PasswordVisibilityController toggle is a strict involution

**Validates: Requirements 4.4, 6.2, 8.6, 15.2**

_For any_ `PasswordVisibilityController`, calling `togglePassword()` twice in succession returns `isPasswordObscured` to its original value. Equivalently, after exactly one `togglePassword()` call the value equals `!original`. The same holds for `toggleConfirm()` independently.

### Property 5: OtpController.otpCode invariant

**Validates: Requirements 3.1, 8.4, 12.3, 14.1**

_For any_ sequence of character assignments to the controllers of an `OtpController`, `otpCode` equals the string produced by joining `controller.text` for each controller in order, and `isComplete` is `true` if and only if every controller holds exactly one non-empty character.

### Property 6: AuthTimer countdown completeness

**Validates: Requirements 2.3, 3.1, 8.2, 12.1, 14.2**

_For any_ positive integer `N ≤ 300`, after exactly `N` timer ticks emitted by `AuthTimer(totalSeconds: N)`, the stream emits a final `AuthTimerState` where `secondsLeft == 0` and `canResend == true`. No earlier tick has `canResend == true`.

### Property 7: AuthLogic login gate — empty fields prevent API call

**Validates: Requirements 2.6, 3.1, 4.1, 16.1, 16.3**

_For any_ `(email, password)` pair where `email.trim().isEmpty` OR `password.isEmpty`, calling `AuthLogic.onLogin(email: email, password: password)` SHALL cause the cubit to emit `ValidationErrorState` and SHALL NOT trigger `AuthCubit.login()`. When both are non-empty, `cubit.login()` is called exactly once with the trimmed values.

---

## Error Handling

| Scenario                                              | Source                                      | Handler                                                                                                                     |
| ----------------------------------------------------- | ------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| Network / server error on login, OTP, register, reset | `AuthRepo` returns `failure`                | `AuthCubit` emits `AuthErrorState`; screen's `BlocListener` shows SnackBar with `state.message`                             |
| OTP code incorrect                                    | `AuthRepo` returns `failure` on `verifyOtp` | `AuthCubit` emits `OtpErrorState`; `OtpBlocListener` triggers shake animation + error SnackBar                              |
| Reset code incorrect                                  | `AuthRepo` failure on `verifyResetCode`     | `AuthCubit` emits `ResetCodeError`; `VerifyResetCodeBlocListener` triggers shake + SnackBar                                 |
| Password reset failure                                | `AuthRepo` failure on `resetPassword`       | `AuthCubit` emits `PasswordResetErrorState`; `SetNewPasswordBlocListener` shows SnackBar                                    |
| Client-side validation failure                        | `FormValidator` returns non-null            | `AuthLogic` causes cubit to emit `ValidationErrorState`; `BlocBuilder` in screen updates field border/error text            |
| BuildContext used across async gap                    | `Future.delayed` in listeners               | Guard with `if (mounted)` check before navigation; always handled inside `BlocListener` where context is guaranteed mounted |

---

## Testing Strategy

### Unit Tests (example-based)

Each Logic Class is independently unit-testable with zero widget harness:

- `FormValidatorTest` — concrete examples: valid email, invalid email, short password, matching passwords, mismatched passwords.
- `PasswordVisibilityControllerTest` — start obscured, toggle once → not obscured, toggle twice → obscured again.
- `OtpControllerTest` — fill all slots → `isComplete == true`; clear → `isComplete == false`; `otpCode` matches concatenation.
- `AuthTimerTest` — mock `Timer.periodic`; verify stream events; verify `canResend` flips exactly once.
- `AuthLogicTest` — use a mock `AuthCubit`; verify `cubit.login()` is called / not called based on input.

### Property-Based Tests

Library: [`glados`](https://pub.dev/packages/glados)

Each test runs a minimum of **100 iterations**. Tag format: `// Feature: auth-ui-refactor, Property N: <property text>`

```dart
// Example sketch — form_validator_test.dart
import 'package:glados/glados.dart';

// Feature: auth-ui-refactor, Property 1: FormValidator email accepts only well-formed addresses
Glados(any.string).test('validateEmail returns null iff email is well-formed', (s) {
  final result = FormValidator.validateEmail(s);
  final isWellFormed = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(s.trim());
  if (isWellFormed) {
    expect(result, isNull);
  } else {
    expect(result, isNotNull);
  }
});
```

One property-based test per property (Properties 1–7). Each references its property number in a leading comment.

### Integration / Widget Tests

- `SignInScreen` widget test: given `AuthCubit` that emits `LoginSuccessState` → verify `GoRouter` navigated to home.
- `OtpScreen` widget test: given `OtpErrorState` → verify shake animation played (via `AnimationController.status`).
- `CompleteProfileScreen` widget test: given `RegisterSuccessState` → verify navigation to home.
- Visual regression (golden) tests per screen using `matchesGoldenFile` — run against original and refactored builds to assert pixel-identical output.

### Unit Testing Balance

Property tests handle wide input coverage; unit tests focus on:

- Specific concrete examples that demonstrate expected behavior
- Error-path scenarios (network failure, empty fields)
- Integration between Logic Classes and AuthCubit (mock-based)

---

## File Naming Table

Every new file path and its primary class:

| File Path                                                                                              | Primary Class                  | Type            |
| ------------------------------------------------------------------------------------------------------ | ------------------------------ | --------------- |
| `lib/features/auth/logic/auth_logic.dart`                                                              | `AuthLogic`                    | Logic Class     |
| `lib/features/auth/logic/auth_timer.dart`                                                              | `AuthTimer`, `AuthTimerState`  | Logic Class     |
| `lib/features/auth/logic/auth_animation.dart`                                                          | `AuthAnimation`                | Logic Class     |
| `lib/features/auth/logic/password_visibility_controller.dart`                                          | `PasswordVisibilityController` | Logic Class     |
| `lib/features/auth/logic/otp_controller.dart`                                                          | `OtpController`                | Logic Class     |
| `lib/features/auth/logic/form_validator.dart`                                                          | `FormValidator`                | Logic Class     |
| `lib/features/auth/presentation/screens/otp/widgets/otp_timer_display.dart`                            | `OtpTimerDisplay`              | StatelessWidget |
| `lib/features/auth/presentation/screens/otp/widgets/otp_resend_row.dart`                               | `OtpResendRow`                 | StatelessWidget |
| `lib/features/auth/presentation/screens/otp/widgets/otp_bloc_listener.dart`                            | `OtpBlocListener`              | StatelessWidget |
| `lib/features/auth/presentation/screens/complete_profile/widgets/complete_profile_form.dart`           | `CompleteProfileForm`          | StatelessWidget |
| `lib/features/auth/presentation/screens/complete_profile/widgets/animated_profile_wrapper.dart`        | `AnimatedProfileWrapper`       | StatelessWidget |
| `lib/features/auth/presentation/screens/complete_profile/widgets/complete_profile_bloc_listener.dart`  | `CompleteProfileBlocListener`  | StatelessWidget |
| `lib/features/auth/presentation/screens/check_your_email/widgets/check_email_otp_row.dart`             | `CheckEmailOtpRow`             | StatelessWidget |
| `lib/features/auth/presentation/screens/check_your_email/widgets/check_email_bloc_listener.dart`       | `CheckEmailBlocListener`       | StatelessWidget |
| `lib/features/auth/presentation/screens/set_new_password/widget/set_new_password_bloc_listener.dart`   | `SetNewPasswordBlocListener`   | StatelessWidget |
| `lib/features/auth/presentation/screens/verify_reset_code/widget/verify_reset_code_bloc_listener.dart` | `VerifyResetCodeBlocListener`  | StatelessWidget |

**Modified files** (no rename, content changes only):

| File Path                                                                                | Change Summary                                                                                     |
| ---------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------- |
| `lib/features/auth/presentation/cubits/auth_cubit.dart`                                  | Remove inline validation; add `AuthLogic` delegation; target ≤ 100 lines                           |
| `lib/features/auth/presentation/cubits/auth_state.dart`                                  | Add `ValidationErrorState`, `PasswordVisibilityState`                                              |
| `lib/features/auth/presentation/screens/sign_in/sign_in_screen.dart`                     | `StatefulWidget` → `StatelessWidget`                                                               |
| `lib/features/auth/presentation/screens/sign_up/sign_up_screen.dart`                     | `StatefulWidget` → `StatelessWidget`                                                               |
| `lib/features/auth/presentation/screens/otp/otp_screen.dart`                             | Extract timer, animation, controller; add `OtpBlocListener`                                        |
| `lib/features/auth/presentation/screens/complete_profile/complete_profile_screen.dart`   | Extract animation, visibility, validators; replace local controllers with cubit controllers        |
| `lib/features/auth/presentation/screens/check_your_email/check_your_email_screen.dart`   | Extract `OtpController`, `AuthTimer`; add `CheckEmailBlocListener`                                 |
| `lib/features/auth/presentation/screens/set_new_password/set_new_password_screen.dart`   | Extract controllers to cubit; add `PasswordVisibilityController`; add `SetNewPasswordBlocListener` |
| `lib/features/auth/presentation/screens/forget_password/forget_password_screen.dart`     | Flatten to single `StatelessWidget`; remove `_emailController`                                     |
| `lib/features/auth/presentation/screens/verify_reset_code/verify_reset_code_screen.dart` | Extract animation, controller; add `VerifyResetCodeBlocListener`                                   |

---

## Design Decisions

**Why keep `TextEditingController`s in `AuthCubit` rather than moving them to Logic Classes?**
The project already follows this convention (documented in `PROJECT_RULES.md` per the existing cubit). Moving them would require dependency injection into Logic Classes and a larger surface area change. The cubit's `close()` override already disposes them safely.

**Why does `CompleteProfileScreen` replace its local controllers with cubit controllers?**
The screen had `_nameCtrl`, `_identifierCtrl`, `_passCtrl`, and `_confirmPassCtrl` while the cubit already owns `nameCtrl`, `newPasswordCtrl`, and `confirmPasswordCtrl`. Using the cubit's controllers eliminates the duplication and removes the need for a `StatefulWidget` just to hold controllers — the screen only needs `StatefulWidget` for the `TickerProvider` required by `AuthAnimation`.

**Why introduce `ValidationErrorState` rather than using `AuthErrorState`?**
`AuthErrorState` is reserved for server/network failures. Client-side validation failures are a distinct concern that should not trigger the same UX response as server errors. `ValidationErrorState` carries per-field error messages, enabling inline field decoration rather than a SnackBar.

**Why keep `VerifyResetCodeScreen` and `OtpScreen` as `StatefulWidget`?**
Both need `SingleTickerProviderStateMixin` for the shake `AnimationController` in `AuthAnimation`. There is no way to supply a `TickerProvider` from a `StatelessWidget` without a custom `TickerProvider` mixin, which would add unnecessary complexity.

**Why not use `provider` or `riverpod` for Logic Classes?**
The project uses `flutter_bloc` exclusively. Logic Classes are plain Dart objects instantiated inside the cubit or the screen's `State` object — no additional DI framework needed.
