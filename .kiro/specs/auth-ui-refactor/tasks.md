# Implementation Plan: Auth UI Refactor

## Overview

Refactor the Auth presentation layer by extracting all non-UI logic into dedicated Logic Classes under `lib/features/auth/logic/`, trimming `AuthCubit` to ≤ 100 lines, converting screens to `StatelessWidget` where possible, and decomposing every reusable UI fragment into its own `StatelessWidget` class. The data layer (`lib/features/auth/data/`) is not touched.

## Tasks

- [ ] Task 1: Create `FormValidator` logic class
  - [ ] 1.1 Create `lib/features/auth/logic/form_validator.dart` with a non-instantiable `FormValidator` class
    - Implement `static String? validateEmail(String? value)` — returns `null` iff value matches `^[^\s@]+@[^\s@]+\.[^\s@]+$`
    - Implement `static String? validatePassword(String? value)` — returns `null` iff non-empty and length ≥ 6
    - Implement `static String? validateName(String? value)` — returns `null` iff trimmed value is non-empty
    - Implement `static String? validateConfirmPassword(String? value, String password)` — returns `null` iff both non-empty and equal
    - Implement `static String? validateNonEmpty(String? value, String fieldName)` — convenience null-guard
    - No Flutter imports; pure Dart only
    - _Requirement: 3.1, 8.5_
  - [ ]\* 1.2 Write property-based tests for `FormValidator`
    - **Property 1: FormValidator email accepts only well-formed addresses** — `Glados(any.string).test(...)` asserting `validateEmail(s) == null` iff `RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(s.trim())`
    - **Validates: Requirements 2.6, 3.1, 13.3, 16.1, 17.1**
    - **Property 2: FormValidator password gate** — `Glados(any.string).test(...)` asserting `validatePassword(s) == null` iff `s.isNotEmpty && s.length >= 6`
    - **Validates: Requirements 2.6, 3.1, 13.3**
    - **Property 3: FormValidator confirm-password match** — `Glados2(any.string, any.string).test(...)` asserting `validateConfirmPassword(confirm, password) == null` iff both non-empty and equal
    - **Validates: Requirements 2.7, 3.1, 13.3, 15.1**
    - File: `test/features/auth/logic/form_validator_test.dart`
    - _Requirement: 3.1_

- [ ] 9. Checkpoint — Logic Layer complete
  - Ensure all tests pass, ask the user if questions arise.

- [ ] 10. Refactor SignInScreen
  - [ ] 10.1 Convert `sign_in_screen.dart` to `StatelessWidget`
    - Remove `hasError` / `rememberMe` local state from the screen class
    - `hasError` moves to `ValidationErrorState`; `rememberMe` moves to `RememberMeCheckbox`
    - _Requirements: 6.4, 16.2_
  - [ ] 10.2 Delegate login logic to `AuthLogic.onLogin()`
    - Remove `_onLogin()` method from screen; call `AuthLogic.onLogin()` from `LoginButton`
    - Remove all SnackBar construction from screen
    - _Requirements: 2.5, 5.1, 16.1, 16.3_
  - [ ] 10.3 Decompose UI into named `StatelessWidget` classes
    - Create/update: `SignInBody`, `SignInHeader`, `EmailInputField`, `PasswordInputField`,
      `RememberMeSection`, `RememberMeCheckbox`, `SocialSignInButtons`, `LoginButton`, `FooterLink`
    - Each widget placed in `sign_in/widgets/`; use `const` constructors throughout
    - _Requirements: 5.2, 7.1, 7.3, 10.1, 10.3, 11.1_
  - [ ] 10.4 Verify `SignInBlocListener` handles `ValidationErrorState`
    - `listenWhen` must include `ValidationErrorState`
    - `SignInScreen` line count ≤ 100 lines
    - _Requirements: 19.1, 19.2, 16.1_
  - [ ]\* 10.5 Write unit tests for SignInScreen
    - Test: `ValidationErrorState` renders field error decoration
    - Test: `LoginSuccessState` triggers navigation (mock `GoRouter`)
    - _Requirements: 9.2, 16.1_

- [ ] Task 2: Create `AuthTimer` logic class
  - [ ] 2.1 Create `lib/features/auth/logic/auth_timer.dart`
    - Define `AuthTimerState` value object with `int secondsLeft` and `bool canResend`
    - Implement `AuthTimer` class with `final int totalSeconds` (default 59)
    - Expose `Stream<AuthTimerState> get stream` via a `StreamController.broadcast()`
    - Implement `void start()` — cancels existing timer, resets state, starts `Timer.periodic`
    - Implement `void dispose()` — cancels timer and closes stream controller
    - Expose `int get secondsLeft` and `bool get canResend` synchronous getters
    - `dart:async` import only; no Flutter imports
    - _Requirement: 3.1, 8.2_
  - [ ]\* 2.2 Write property-based test for `AuthTimer`
    - **Property 6: AuthTimer countdown completeness** — for any positive integer `N ≤ 300`, after `N` ticks the stream emits `AuthTimerState(secondsLeft: 0, canResend: true)`; no earlier tick has `canResend == true`
    - **Validates: Requirements 2.3, 3.1, 8.2, 12.1, 14.2**
    - File: `test/features/auth/logic/auth_timer_test.dart`
    - _Requirement: 3.1_

- [ ] Task 3: Create `PasswordVisibilityController` logic class
  - [ ] 3.1 Create `lib/features/auth/logic/password_visibility_controller.dart`
    - Implement `PasswordVisibilityController` with two `ValueNotifier<bool>` fields: `passwordNotifier` and `confirmNotifier`
    - Constructor parameters: `bool initialPassword = true`, `bool initialConfirm = true`
    - Implement `bool get isPasswordObscured`, `bool get isConfirmObscured`
    - Implement `void togglePassword()` and `void toggleConfirm()`
    - Implement `void dispose()` that disposes both notifiers
    - Import `package:flutter/foundation.dart` only; no widget imports
    - _Requirement: 3.1, 8.6_
  - [ ]\* 3.2 Write property-based test for `PasswordVisibilityController`
    - **Property 4: PasswordVisibilityController toggle is a strict involution** — toggling twice returns to original value; one toggle equals `!original`; `passwordNotifier` and `confirmNotifier` are independent
    - **Validates: Requirements 4.4, 6.2, 8.6, 15.2**
    - File: `test/features/auth/logic/password_visibility_controller_test.dart`
    - _Requirement: 3.1_

- [ ] 11. Refactor SignUpScreen
  - [ ] 11.1 Convert `sign_up_screen.dart` to `StatelessWidget`
    - Remove `hasError` / `errorMessage` local state; move into `ValidationErrorState`
    - _Requirements: 6.4, 17.2_
  - [ ] 11.2 Delegate send-code logic to `AuthLogic.onSendCode()`
    - Remove `_onSendCode()` from screen; call `AuthLogic.onSendCode()` from submit button
    - Remove inline email validation from screen
    - _Requirements: 2.6, 17.1_
  - [ ] 11.3 Decompose UI into named `StatelessWidget` classes
    - Create/update: `SignUpBody`, `PhoneInputField`, `GuestModeButton`
    - Place in `sign_up/widgets/`; use `const` constructors
    - _Requirements: 5.2, 7.1, 7.3, 10.3, 11.1_
  - [ ] 11.4 Verify `SignUpBlocListener` handles `ValidationErrorState`
    - `SignUpScreen` line count ≤ 100 lines
    - _Requirements: 19.1, 19.2, 17.2_
  - [ ]\* 11.5 Write unit tests for SignUpScreen
    - Test: empty email triggers `ValidationErrorState` without calling `cubit.sendSmsCode()`
    - Test: `OtpSentState` triggers navigation to OTP screen
    - _Requirements: 9.2, 17.1_

- [ ] 12. Refactor OtpScreen
  - [ ] 12.1 Extract timer logic to `AuthTimer` in `initState`/`dispose`
    - Instantiate `AuthTimer` in `_OtpScreenState.initState()`; call `dispose()` in `dispose()`
    - Remove any direct `Timer` usage from screen
    - _Requirements: 2.3, 12.1_
  - [ ] 12.2 Extract animation logic to `AuthAnimation` in `initState`/`dispose`
    - Instantiate `AuthAnimation` with `vsync: this`; call `init()` then forward on create
    - Remove direct `AnimationController` from screen
    - _Requirements: 2.4, 12.2_
  - [ ] 12.3 Extract OTP field management to `OtpController`
    - Instantiate `OtpController(length: 6)` in `initState`; call `dispose()` in `dispose()`
    - Remove all `TextEditingController` / `FocusNode` declarations from screen
    - _Requirements: 12.3_
  - [ ] 12.4 Add `OtpBlocListener` widget
    - Create `otp/widgets/otp_bloc_listener.dart`
    - `listenWhen` includes `OtpVerifiedState`, `OtpErrorState`, `AuthErrorState`, `OtpSentState`
    - On `OtpVerifiedState`: navigate to `CompleteProfileScreen` after 500 ms delay + `mounted` guard
    - On `OtpErrorState`: call `authAnimation.shake()` + show SnackBar
    - _Requirements: 12.4, 12.5, 19.1, 19.2, 19.4_
  - [ ] 12.5 Decompose OTP screen UI
    - Create `OtpTimerDisplay` widget (shows `0:SS` countdown with `AnimatedSwitcher`)
    - Create `OtpResendRow` widget (resend link + prompt text)
    - Wire `OtpInputRow` to `OtpController`
    - `OtpScreen` line count ≤ 100 lines
    - _Requirements: 7.1, 7.3, 12.6, 11.1_
  - [ ]\* 12.6 Write unit tests for OtpScreen
    - Test: `OtpErrorState` triggers shake animation
    - Test: `OtpVerifiedState` triggers navigation to `CompleteProfileScreen`
    - _Requirements: 9.2, 12.4, 12.5_
