# Auth Feature Implementation Guide

## Quick Start

### 1. Setup Dependency Injection (in main.dart)

```dart
import 'package:get_it/get_it.dart';
import 'presentation/providers/auth_providers.dart';

final getIt = GetIt.instance;

void main() {
  // Initialize auth providers
  setupAuthProviders();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubitV2>(
            create: (context) => getIt<AuthCubitV2>(),
          ),
        ],
        child: const SignInScreen(),
      ),
    );
  }
}
```

### 2. Navigate Between Screens

Use named routes or direct navigation:

```dart
// Using Navigator
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => const OtpScreen(phoneNumber: '+974XXXXXXXX'),
  ),
);

// Using named routes (recommended)
Navigator.pushNamed(context, '/otp', arguments: {'phoneNumber': '+974XXXXXXXX'});
```

---

## Screen Usage Patterns

### Sign In Screen

```dart
// Navigate to sign in
Navigator.of(context).pushReplacementNamed('/sign_in');

// Success listener handles navigation to home
// Error listener shows snackbar
```

**Validation**:
- Email required and valid format
- Password required and min 6 characters

**Outcomes**:
- ✅ SignIn Success → Navigate to Home
- ❌ SignIn Error → Show error message
- ❌ Invalid Credentials → Show error message

---

### Sign Up Screen

```dart
// Navigate to sign up
Navigator.of(context).pushNamed('/sign_up');

// Phone number must be Qatar format (+974XXXXXXXX)
// Success sends OTP to phone number
```

**Validation**:
- Phone number required
- Must be valid Qatar phone format

**Outcomes**:
- ✅ OTP Sent → Navigate to OtpScreen
- ❌ Error → Show error message

---

### OTP Verification Screen

```dart
// Pass phone number from sign up
Navigator.of(context).pushNamed('/otp', arguments: {
  'phoneNumber': '+974XXXXXXXX',
});

// 60-second timer automatically starts
// Resend available after timer expires
```

**Validation**:
- Code required and exactly 6 digits
- Cannot verify with expired code

**Timer Behavior**:
- Starts at 59 seconds
- Resend button disabled until 0:00
- Shows error when time expires

**Outcomes**:
- ✅ OTP Verified → Navigate to CompleteProfileScreen
- ❌ Invalid Code → Show error
- ❌ Expired Code → Show error, enable resend

---

### Complete Profile Screen

```dart
// Pass phone number from previous step
Navigator.of(context).pushNamed('/complete_profile', arguments: {
  'phoneNumber': '+974XXXXXXXX',
});

// Collects full profile information
```

**Validation**:
- Name required (min 2 characters)
- Email required and valid format
- Gender required
- Address optional
- Bio optional (max 150 chars)

**Outcomes**:
- ✅ Profile Completed → Navigate to Home
- ❌ Error → Show error message

---

### Forgot Password Screen

```dart
// Navigate from sign in
Navigator.of(context).pushNamed('/forgot_password');

// User enters email to receive reset code
```

**Validation**:
- Email required and valid format

**Outcomes**:
- ✅ Code Sent → Navigate to VerifyResetCodeScreen
- ❌ Error → Show error message

---

### Verify Reset Code Screen

```dart
// Pass email from forgot password
Navigator.of(context).pushNamed('/verify_reset_code', arguments: {
  'email': 'user@example.com',
});

// 60-second timer automatically starts
// Resend available after timer expires
```

**Validation**:
- Code required and exactly 6 digits
- Cannot verify with expired code

**Timer Behavior**:
- Starts at 59 seconds
- Resend button disabled until 0:00
- Shows error when time expires

**Outcomes**:
- ✅ Code Verified → Navigate to SetNewPasswordScreen
- ❌ Invalid Code → Show error
- ❌ Expired Code → Show error, enable resend

---

### Set New Password Screen

```dart
// Pass email from previous step
Navigator.of(context).pushNamed('/set_new_password', arguments: {
  'email': 'user@example.com',
});

// User sets new password
```

**Validation**:
- New password required and min 6 characters
- Confirm password required
- Passwords must match

**Outcomes**:
- ✅ Password Updated → Navigate to PasswordChangedSuccessfullyScreen
- ❌ Password Mismatch → Show error
- ❌ Error → Show error message

---

### Password Changed Successfully Screen

```dart
// Auto-navigated after successful password reset
// Shows confirmation with success icon

// User clicks "Continue to Login"
Navigator.pushNamedAndRemoveUntil(context, '/sign_in', (_) => false);
```

---

## State Management Pattern

### Understanding AuthCubitV2

```dart
// Inject into widget
final authCubit = context.read<AuthCubitV2>();

// Call appropriate method
await authCubit.signIn(email: 'user@example.com', password: 'password');

// Listen to state changes
BlocListener<AuthCubitV2, AuthState>(
  listener: (context, state) {
    if (state is SignInSuccessState) {
      // Navigate to home
    } else if (state is SignInErrorState) {
      // Show error
    }
  },
);

// Build UI based on state
BlocBuilder<AuthCubitV2, AuthState>(
  builder: (context, state) {
    if (state is AuthLoadingState) {
      return LoadingWidget();
    }
    return NormalWidget();
  },
);
```

### Available Methods

```dart
// Sign In
authCubit.signIn(
  email: 'user@example.com',
  password: 'password123',
);

// Sign Up - Request OTP
authCubit.sendOtp(phoneNumber: '+974XXXXXXXX');

// Sign Up - Verify OTP
authCubit.verifyOtp(
  phoneNumber: '+974XXXXXXXX',
  otp: '123456',
);

// Complete Profile
authCubit.completeProfile(
  phoneNumber: '+974XXXXXXXX',
  name: 'Ahmed Mohammed',
  email: 'ahmed@example.com',
  gender: 'ذكر',
  address: 'Doha, Qatar',
  bio: 'Software Developer',
);

// Forgot Password - Request Code
authCubit.requestPasswordReset(email: 'user@example.com');

// Forgot Password - Verify Code
authCubit.verifyResetCode(
  email: 'user@example.com',
  code: '123456',
);

// Forgot Password - Reset Password
authCubit.resetPassword(
  email: 'user@example.com',
  newPassword: 'newPassword123',
);

// Social Sign In
authCubit.signInWithGoogle();
authCubit.signInWithApple();
```

---

## Validation Usage

### Sign In Validator

```dart
import 'logic/validators/sign_in_validator.dart';

// Check if form is valid
if (SignInValidator.isFormValid(email: email, password: password)) {
  // Form is valid
}

// Validate and get errors
final errors = SignInValidator.validateForm(email: email, password: password);
if (errors['email'] != null) {
  // Show email error
}
if (errors['password'] != null) {
  // Show password error
}

// Validate individual fields
final emailError = SignInValidator.validateEmail(email);
final passwordError = SignInValidator.validatePassword(password);
```

### OTP Validator

```dart
import 'logic/validators/otp_validator.dart';

// Check if valid (exactly 6 digits)
if (OtpValidator.isValid(code)) {
  // Code is valid
}

// Get error message if invalid
final error = OtpValidator.validate(code);
if (error != null) {
  showError(error);
}
```

### Profile Validator

```dart
import 'logic/validators/profile_validator.dart';

// Check if form is valid
if (ProfileValidator.isFormValid(
  name: name,
  email: email,
  gender: gender,
)) {
  // Form is valid
}

// Validate and get errors
final errors = ProfileValidator.validateForm(
  name: name,
  email: email,
  gender: gender,
);
```

---

## String Usage

All UI strings are centralized:

```dart
import 'utils/auth_strings.dart';

// Sign In strings
AuthStrings.signInTitle // "تسجيل الدخول"
AuthStrings.emailLabel // "البريد الإلكتروني"
AuthStrings.passwordLabel // "كلمة المرور"

// OTP strings
AuthStrings.otpVerificationTitle // "التحقق من الرمز"
AuthStrings.otpCodeHint // "أدخل الرمز"

// Error messages
AuthStrings.errorNetwork // "خطأ في الاتصال بالإنترنت"
AuthStrings.invalidEmail // "البريد الإلكتروني غير صحيح"

// Success messages
AuthStrings.successSignIn // "تم تسجيل الدخول بنجاح"
```

---

## Common Patterns

### Disable Button While Loading

```dart
ElevatedButton(
  onPressed: isLoading ? null : _handleAction,
  child: isLoading
      ? CircularProgressIndicator()
      : Text('تأكيد'),
);
```

### Show/Hide Password

```dart
TextFormField(
  obscureText: !_passwordVisible,
  suffixIcon: IconButton(
    icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
    onPressed: () => setState(() => _passwordVisible = !_passwordVisible),
  ),
);
```

### Form Validation Feedback

```dart
TextFormField(
  onChanged: (_) => setState(() {}),
);

ElevatedButton(
  onPressed: _isFormValid() ? _handleSubmit : null,
);
```

### Error Snackbar

```dart
void _showError(String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}
```

### Success Snackbar

```dart
void _showSuccess(String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
    ),
  );
}
```

---

## Testing Checklist

### Unit Tests
- [ ] SignInValidator tests
- [ ] SignUpValidator tests
- [ ] OtpValidator tests
- [ ] ProfileValidator tests
- [ ] OtpTimerService tests
- [ ] All UseCases tests

### Widget Tests
- [ ] Sign In Screen rendering
- [ ] Form validation feedback
- [ ] Button disabled state
- [ ] Password visibility toggle
- [ ] Error display
- [ ] Loading state display

### Integration Tests
- [ ] Complete sign in flow
- [ ] Complete sign up flow (OTP)
- [ ] Complete profile flow
- [ ] Password reset flow
- [ ] Social sign in (mock)

---

## Troubleshooting

### Timer Not Working
- ✅ Ensure `OtpTimerService` is properly initialized in `initState`
- ✅ Ensure `dispose()` is called to clean up resources
- ✅ Check that `_onTimerTick` triggers `setState(() {})`

### Validation Not Working
- ✅ Ensure validator is imported correctly
- ✅ Check that `onChanged: (_) => setState(() {})` is set on fields
- ✅ Verify button's `onPressed` checks `_isFormValid()`

### Navigation Not Working
- ✅ Ensure routes are defined in MaterialApp
- ✅ Check that screen is properly imported
- ✅ Verify correct route name in `pushNamed`

### State Not Updating
- ✅ Ensure Cubit is provided in BlocProvider
- ✅ Check that listener `listenWhen` condition is correct
- ✅ Verify Cubit is properly emitting states

---

## Clean Code Principles Applied

✅ **Single Responsibility**: Each class has one reason to change
✅ **Open/Closed**: Easy to extend without modifying existing code
✅ **Liskov Substitution**: Validators and Services are interchangeable
✅ **Interface Segregation**: Small, focused interfaces
✅ **Dependency Inversion**: Depend on abstractions, not implementations

---

## Next Steps

1. Setup DI container (GetIt) in main.dart
2. Define named routes for navigation
3. Add proper error handling for API responses
4. Implement actual API calls in RemoteDataSource
5. Add widget and integration tests
6. Setup proper logging for debugging
7. Add analytics for user tracking
