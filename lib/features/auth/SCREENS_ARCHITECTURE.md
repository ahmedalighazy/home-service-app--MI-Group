# Auth Feature - Screens Architecture

## Overview
All auth screens follow Clean Architecture principles with strict separation of concerns:
- **Logic Layer** (Validators & Services) - No UI dependencies
- **Presentation Layer** (Screens & Widgets) - UI only
- **State Management** - Cubit (AuthCubitV2) calling UseCases

---

## Screens Implementation Status

### ✅ Sign In Screen
**Path**: `lib/features/auth/presentation/screens/sign_in_screen/sign_in_screen.dart`

**Responsibilities**:
- Email input field
- Password input field (with visibility toggle)
- Sign in button
- Forgot password link
- Social sign-in buttons (Google, Apple)
- Sign up link

**Validation**: Uses `SignInValidator`
**State Management**: Listens to `AuthCubitV2.signIn()`
**Success**: Navigates to home
**Flows**:
- SignIn → SignInSuccessState → Home
- SignIn → SignInErrorState → Error snackbar
- SignIn → SignInInvalidCredentialsState → Error snackbar

---

### ✅ Sign Up Screen
**Path**: `lib/features/auth/presentation/screens/sign_up_screen/sign_up_screen.dart`

**Responsibilities**:
- Phone number input with Qatar country code (+974)
- Send code button
- Social sign-up buttons (Google, Apple)
- Sign in link

**Validation**: Uses `SignUpValidator` (Qatar phone validation)
**State Management**: Listens to `AuthCubitV2.sendOtp()`
**Success**: Navigates to OTP verification screen
**Flows**:
- SendOtp → OtpSentState → OtpScreen
- SendOtp → OtpErrorState → Error snackbar

---

### ✅ OTP Verification Screen
**Path**: `lib/features/auth/presentation/screens/otp_screen/otp_screen.dart`

**Responsibilities**:
- 6-digit OTP input field
- Verify button
- Resend code link (disabled until timer expires)
- Countdown timer (00:59 → 00:00)

**Validation**: Uses `OtpValidator` (6-digit number)
**State Management**: Listens to `AuthCubitV2.verifyOtp()`
**Timer Service**: `OtpTimerService` (60 seconds, no UI dependencies)
**Success**: Navigates to Complete Profile screen
**Flows**:
- VerifyOtp → OtpVerifiedState → CompleteProfileScreen
- VerifyOtp → OtpInvalidCodeState → Error snackbar
- VerifyOtp → OtpExpiredState → Error snackbar, enable resend
- ResendOtp → Reset timer, clear code

---

### ✅ Complete Profile Screen
**Path**: `lib/features/auth/presentation/screens/complete_profile_screen/complete_profile_screen.dart`

**Responsibilities**:
- Name input field
- Email input field
- Gender dropdown (Male/Female)
- Address input field (optional, multiline)
- Bio input field (optional, max 150 chars)
- Complete registration button

**Validation**: Uses `ProfileValidator`
**State Management**: Listens to `AuthCubitV2.completeProfile()`
**Success**: Navigates to home (profile complete)
**Flows**:
- CompleteProfile → ProfileCompletedState → Home
- CompleteProfile → ProfileCompletionErrorState → Error snackbar

---

### ✅ Forgot Password Screen
**Path**: `lib/features/auth/presentation/screens/forgot_password_screen/forgot_password_screen.dart`

**Responsibilities**:
- Email input field
- Send code button
- Back to sign in link

**Validation**: Uses `SignInValidator.isEmailValid()`
**State Management**: Listens to `AuthCubitV2.requestPasswordReset()`
**Success**: Navigates to Verify Reset Code screen
**Flows**:
- RequestPasswordReset → ResetCodeSentState → VerifyResetCodeScreen
- RequestPasswordReset → PasswordResetErrorState → Error snackbar

---

### ✅ Verify Reset Code Screen
**Path**: `lib/features/auth/presentation/screens/verify_reset_code_screen/verify_reset_code_screen.dart`

**Responsibilities**:
- 6-digit reset code input field
- Verify button
- Resend code link (disabled until timer expires)
- Countdown timer (00:59 → 00:00)

**Validation**: Uses `OtpValidator` (same as OTP, 6-digit number)
**State Management**: Listens to `AuthCubitV2.verifyResetCode()`
**Timer Service**: `OtpTimerService` (60 seconds)
**Success**: Navigates to Set New Password screen
**Flows**:
- VerifyResetCode → ResetCodeVerifiedState → SetNewPasswordScreen
- VerifyResetCode → ResetCodeInvalidState → Error snackbar
- VerifyResetCode → ResetCodeExpiredState → Error snackbar, enable resend
- ResendCode → Reset timer, clear code

---

### ✅ Set New Password Screen
**Path**: `lib/features/auth/presentation/screens/set_new_password_screen/set_new_password_screen.dart`

**Responsibilities**:
- New password input field (with visibility toggle)
- Confirm password input field (with visibility toggle)
- Update password button
- Validates passwords match

**Validation**: Uses `SignInValidator.validatePassword()`
**State Management**: Listens to `AuthCubitV2.resetPassword()`
**Success**: Navigates to Password Changed Successfully screen
**Flows**:
- ResetPassword → PasswordResetSuccessState → PasswordChangedSuccessfullyScreen
- ResetPassword → PasswordResetErrorState → Error snackbar
- Password mismatch → Error snackbar

---

### ✅ Password Changed Successfully Screen
**Path**: `lib/features/auth/presentation/screens/password_changed_successfully_screen/password_changed_successfully_screen.dart`

**Responsibilities**:
- Success icon (green checkmark)
- Success message
- "Continue to login" button

**Validation**: None (confirmation screen)
**State Management**: None (navigation only)
**Success**: Navigates back to Sign In screen
**Flows**:
- Continue → Sign In Screen

---

## Architecture Flow

```
┌─────────────────────────────────────────────────────────────┐
│                    PRESENTATION LAYER                       │
│                     (Screens & Widgets)                     │
└────────────────────────┬────────────────────────────────────┘
                         │
                         ↓ Calls Methods
┌─────────────────────────────────────────────────────────────┐
│                  STATE MANAGEMENT LAYER                      │
│                   (AuthCubitV2 - Cubit)                     │
└────────────────────────┬────────────────────────────────────┘
                         │
                         ↓ Calls UseCase
┌─────────────────────────────────────────────────────────────┐
│                     DOMAIN LAYER                            │
│              (UseCases - Business Logic)                    │
└────────────────────────┬────────────────────────────────────┘
                         │
                         ↓ Calls Repository
┌─────────────────────────────────────────────────────────────┐
│                      DATA LAYER                             │
│            (Repository & DataSources)                       │
└─────────────────────────────────────────────────────────────┘
                         │
                         ↓ API/Local Storage
┌─────────────────────────────────────────────────────────────┐
│                   EXTERNAL LAYER                            │
│             (API Server / SharedPreferences)                │
└─────────────────────────────────────────────────────────────┘
```

---

## Key Principles Applied

### ✅ Separation of Concerns
- **Validators**: Pure Dart functions, no Flutter dependencies
  - `SignInValidator`
  - `SignUpValidator`
  - `OtpValidator`
  - `ProfileValidator`
- **Services**: Business logic services, no UI dependencies
  - `OtpTimerService`
- **Screens**: Only UI code, delegate logic to Cubit/Validator
- **Cubit**: Only calls UseCases, never Repository directly

### ✅ Clean Architecture
- **Domain Layer**: UseCases contain business logic
- **Data Layer**: Models, DataSources, Repository implementation
- **Presentation Layer**: Screens use Cubit and Validators

### ✅ No Hardcoded Strings
- All text in `AuthStrings` class
- RTL-ready (Arabic text)

### ✅ Reusable Components
- `AuthTextFieldWidget` - Text field with optional features
- `AuthButtonWidget` - Button with loading state
- Common validators used across screens

### ✅ Error Handling
- Form validation before API calls
- Specific error states for different scenarios
- User-friendly error messages

### ✅ Timer Management
- `OtpTimerService` - Encapsulates timer logic
- No UI dependencies
- Callback-based updates
- Proper disposal to prevent memory leaks

---

## Navigation Flow

```
SignInScreen
├── Sign in → Home (on success)
├── Forgot Password → ForgotPasswordScreen
├── Social → Home (on success)
└── Create Account → SignUpScreen

SignUpScreen
├── Send OTP → OtpScreen
├── Social → Home (on success)
└── Back → SignInScreen

OtpScreen
├── Verify OTP → CompleteProfileScreen
├── Resend OTP → Reset timer
└── Back → SignUpScreen

CompleteProfileScreen
├── Complete → Home (on success)
└── Back → OtpScreen

ForgotPasswordScreen
├── Send Code → VerifyResetCodeScreen
└── Back → SignInScreen

VerifyResetCodeScreen
├── Verify Code → SetNewPasswordScreen
├── Resend Code → Reset timer
└── Back → ForgotPasswordScreen

SetNewPasswordScreen
├── Reset Password → PasswordChangedSuccessfullyScreen
└── Back → VerifyResetCodeScreen

PasswordChangedSuccessfullyScreen
└── Continue → SignInScreen
```

---

## State Management Flow

Each screen follows this pattern:

```dart
BlocListener<AuthCubitV2, AuthState>(
  listenWhen: (previous, current) => /* specific states */,
  listener: (context, state) {
    // Handle success/error
    // Navigate if needed
  },
  child: BlocBuilder<AuthCubitV2, AuthState>(
    builder: (context, state) {
      final isLoading = state is AuthLoadingState;
      // Build UI based on state
    },
  ),
);
```

---

## Testing Considerations

### Unit Tests
- Validators (pure functions)
- OtpTimerService
- UseCases

### Widget Tests
- Screen rendering
- Form validation feedback
- Button states

### Integration Tests
- End-to-end auth flows
- Navigation between screens

---

## Summary

✅ **All 6 auth screens implemented** with clean separation:
1. Sign In
2. Sign Up
3. OTP Verification
4. Complete Profile
5. Forgot Password
6. Verify Reset Code
7. Set New Password
8. Password Changed Successfully (confirmation)

✅ **Each screen**:
- Uses only UI code (no business logic)
- Delegates to Cubit and Validators
- Has proper error handling
- Follows RTL conventions (Arabic)
- Uses centralized strings (no hardcoding)
- Implements proper state listening
- Shows loading states
