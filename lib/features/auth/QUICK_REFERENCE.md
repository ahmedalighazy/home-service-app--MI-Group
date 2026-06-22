# Auth Feature - Quick Reference Guide

## Project Stats

✅ **8 Screens** - All implemented with clean architecture
✅ **9 UseCases** - All business logic in domain layer
✅ **4 Validators** - Pure functions, no UI dependencies
✅ **1 Timer Service** - Reusable, testable
✅ **100% Separated** - Logic, UI, Widgets clearly divided

---

## File Structure at a Glance

```
auth/
├── domain/
│   ├── entities/ (User, AuthToken)
│   ├── repositories/ (abstract AuthRepository)
│   └── usecases/ (9 usecases - sign in, sign up, OTP, profile, password reset, social)
│
├── data/
│   ├── datasources/ (local + remote, abstract + impl)
│   ├── models/ (with JSON/Entity mappers)
│   ├── repositories/ (AuthRepositoryImpl)
│   └── exceptions/
│
├── presentation/
│   ├── screens/ (8 screens)
│   ├── widgets/ (TextField, Button)
│   ├── cubits/ (AuthCubitV2 - CURRENT)
│   ├── states/ (sealed class with all states)
│   └── providers/ (DI setup)
│
├── logic/
│   ├── validators/ (4 validators)
│   └── services/ (OtpTimerService)
│
└── utils/
    └── auth_strings.dart (all UI text)
```

---

## The 8 Screens

| Screen | Purpose | Timer | Validation |
|--------|---------|-------|-----------|
| 🟢 Sign In | Email + password login | ❌ | Email, Password |
| 🟢 Sign Up | Phone number OTP flow start | ❌ | Qatar phone |
| 🟢 OTP Verification | Verify 6-digit OTP | ✅ 60s | 6 digits |
| 🟢 Complete Profile | Name, email, gender, address, bio | ❌ | Name, Email, Gender |
| 🟢 Forgot Password | Email for password reset | ❌ | Email |
| 🟢 Verify Reset Code | Verify 6-digit reset code | ✅ 60s | 6 digits |
| 🟢 Set New Password | New password + confirm | ❌ | Match, Length |
| 🟢 Password Changed | Success confirmation | ❌ | None |

---

## Quick Code Snippets

### Import Auth Cubit
```dart
import 'presentation/cubits/auth_cubit_v2.dart';

final authCubit = context.read<AuthCubitV2>();
```

### Use in Screen
```dart
BlocListener<AuthCubitV2, AuthState>(
  listener: (context, state) {
    if (state is SignInSuccessState) {
      Navigator.pushNamed(context, '/home');
    }
  },
  child: BlocBuilder<AuthCubitV2, AuthState>(
    builder: (context, state) {
      return state is AuthLoadingState 
          ? LoadingWidget()
          : ContentWidget();
    },
  ),
);
```

### Validate Before Calling Cubit
```dart
final error = SignInValidator.validateEmail(email);
if (error != null) {
  _showError(error);
  return;
}
_authCubit.signIn(email: email, password: password);
```

### Show Error/Success
```dart
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text('Error message')),
);

ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text('Success'),
    backgroundColor: Colors.green,
  ),
);
```

### Get Strings
```dart
import 'utils/auth_strings.dart';

Text(AuthStrings.signInTitle)
Text(AuthStrings.emailLabel)
Text(AuthStrings.errorNetwork)
```

---

## Validators Available

```dart
// Sign In Validator
SignInValidator.validateEmail(email)          // String? error
SignInValidator.validatePassword(password)    // String? error
SignInValidator.isEmailValid(email)           // bool
SignInValidator.isPasswordValid(password)     // bool
SignInValidator.isFormValid(...)              // bool

// Sign Up Validator
SignUpValidator.validatePhoneNumber(phone)    // String? error
SignUpValidator.isPhoneValid(phone)           // bool

// OTP Validator
OtpValidator.validate(code)                   // String? error
OtpValidator.isValid(code)                    // bool (exactly 6 digits)

// Profile Validator
ProfileValidator.validateForm(...)            // Map<String, String?>
ProfileValidator.isFormValid(...)             // bool
```

---

## Cubit Methods

```dart
// Sign In
authCubit.signIn(
  email: 'user@example.com',
  password: 'password123',
)

// Sign Up - Send OTP
authCubit.sendOtp(phoneNumber: '+974XXXXXXXX')

// Sign Up - Verify OTP
authCubit.verifyOtp(
  phoneNumber: '+974XXXXXXXX',
  otp: '123456',
)

// Complete Profile
authCubit.completeProfile(
  phoneNumber: '+974XXXXXXXX',
  name: 'Name',
  email: 'email@example.com',
  gender: 'ذكر',
  address: 'Optional',
  bio: 'Optional',
)

// Password Reset - Request Code
authCubit.requestPasswordReset(email: 'user@example.com')

// Password Reset - Verify Code
authCubit.verifyResetCode(
  email: 'user@example.com',
  code: '123456',
)

// Password Reset - Reset Password
authCubit.resetPassword(
  email: 'user@example.com',
  newPassword: 'newPassword123',
)

// Social Sign In
authCubit.signInWithGoogle()
authCubit.signInWithApple()
```

---

## State Examples

```dart
// Success States
SignInSuccessState(userId, email, token)
OtpVerifiedState(phoneNumber)
ProfileCompletedState(userId, email, name)
PasswordResetSuccessState()
GoogleSignInSuccessState(userId, email)

// Error States
SignInErrorState(message)
OtpInvalidCodeState(message)
OtpExpiredState(message)
ProfileCompletionErrorState(message)
PasswordResetErrorState(message)
ResetCodeExpiredState(message)

// Loading State
AuthLoadingState()

// Info States
OtpSentState(phoneNumber, expirySeconds)
ResetCodeSentState(email)
ResetCodeVerifiedState(email)
```

---

## Architecture Principles

### ✅ Separation of Concerns
- **Domain**: Pure business logic (no UI)
- **Data**: Implementation details (API/Storage)
- **Presentation**: UI only (never calls Repository directly)
- **Logic**: Helpers (Validators, Services)

### ✅ Cubit Hierarchy
```
Screen
  ↓ Calls method
Cubit
  ↓ Calls UseCase
UseCase
  ↓ Calls Repository
Repository
  ↓ Calls DataSource
DataSource
  ↓ Calls API/Storage
```

### ✅ No Hardcoded Strings
All text in `AuthStrings` class for easy translation

### ✅ Form Validation Pattern
1. User types → `setState(() {})`
2. Button validates → `_isFormValid()`
3. Button disabled if invalid
4. On submit → Validator check
5. If errors → Show snackbar
6. If valid → Call Cubit

---

## Common Patterns

### Loading Button
```dart
ElevatedButton(
  onPressed: isLoading ? null : _handleAction,
  child: isLoading
      ? CircularProgressIndicator()
      : Text('Button'),
)
```

### Password Visibility Toggle
```dart
TextFormField(
  obscureText: !_passwordVisible,
  suffixIcon: IconButton(
    icon: Icon(_passwordVisible 
        ? Icons.visibility 
        : Icons.visibility_off),
    onPressed: () => setState(
      () => _passwordVisible = !_passwordVisible
    ),
  ),
)
```

### Form Validation Feedback
```dart
TextFormField(
  onChanged: (_) => setState(() {}),
)

ElevatedButton(
  onPressed: _isFormValid() ? _handleAction : null,
)
```

### Error Display
```dart
void _showError(String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}
```

### Success Display
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

## Navigation Flow

```
SignIn ← → SignUp
  ↓         ↓
Home ← Forgot → Verify Reset Code
            ↓         ↓
        Set Password ← Success
```

### Screen Parameters

```dart
// OTP Screen
OtpScreen(phoneNumber: '+974XXXXXXXX')

// Complete Profile Screen
CompleteProfileScreen(phoneNumber: '+974XXXXXXXX')

// Verify Reset Code Screen
VerifyResetCodeScreen(email: 'user@example.com')

// Set New Password Screen
SetNewPasswordScreen(email: 'user@example.com')
```

---

## Testing Checklist

- [ ] Unit test all validators
- [ ] Unit test OtpTimerService
- [ ] Unit test all UseCases
- [ ] Widget test all screens
- [ ] Integration test all flows
- [ ] Test error scenarios
- [ ] Test loading states
- [ ] Test timer expiration

---

## Debugging Tips

### Enable Logging
```dart
// In Cubit
Future<void> signIn(...) async {
  emit(AuthLoadingState());
  print('Signing in with $email');
  
  final result = await _signInUseCase(...);
  
  result.fold(
    (failure) {
      print('Sign in failed: ${failure.message}');
      emit(SignInErrorState(failure.message));
    },
    (token) {
      print('Sign in success');
      emit(SignInSuccessState(...));
    },
  );
}
```

### Check State Changes
```dart
BlocListener<AuthCubitV2, AuthState>(
  listener: (context, state) {
    print('State changed: ${state.runtimeType}');
  },
)
```

### Verify Validators
```dart
// Test validators independently
print(SignInValidator.validateEmail('invalid'));
print(OtpValidator.validate('12345')); // Too short
```

---

## Performance Considerations

✅ **Validators**: O(1) - instant feedback
✅ **Timer**: Efficient tick-by-tick updates
✅ **Cubit**: Single Cubit for entire auth feature
✅ **Widgets**: Minimal rebuilds with BlocBuilder
✅ **Strings**: Constant strings (no allocations)

---

## Security Considerations

⚠️ **Passwords**: Never log or display unnecessarily
⚠️ **Tokens**: Store securely in local datasource
⚠️ **API Calls**: Use HTTPS only
⚠️ **Validation**: Validate both client and server
⚠️ **Errors**: Don't expose sensitive info in error messages

---

## Next Steps

1. ✅ Review Clean Architecture structure
2. ✅ Understand layer separation
3. ✅ Review each screen implementation
4. ✅ Setup DI container (GetIt) in main.dart
5. ✅ Define named routes for navigation
6. ✅ Implement actual API calls
7. ✅ Add widget and integration tests
8. ✅ Setup Firebase or your auth service
9. ✅ Implement analytics
10. ✅ Add proper error handling

---

## Key Files to Review

Start with these in order:

1. `domain/usecases/sign_in_usecase.dart` - See UseCase pattern
2. `presentation/cubits/auth_cubit_v2.dart` - Understand Cubit
3. `presentation/screens/sign_in_screen/sign_in_screen.dart` - See Screen pattern
4. `logic/validators/sign_in_validator.dart` - Understand Validators
5. `CLEAN_ARCHITECTURE_OVERVIEW.md` - Full architecture guide

---

## Questions?

Refer to:
- `CLEAN_ARCHITECTURE_OVERVIEW.md` - Complete architecture explanation
- `IMPLEMENTATION_GUIDE.md` - How to use and implement features
- `SCREENS_ARCHITECTURE.md` - Detailed screen documentation

All code follows **SOLID principles** and **Clean Architecture** best practices.

**Happy coding!** 🚀
