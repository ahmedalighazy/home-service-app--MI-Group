# Authentication Guide - English

## 📋 Overview

The authentication system in the application provides comprehensive sign in, sign up, and password recovery functionality. It uses the Cubit pattern for state management with Clean Architecture.

---

## 🏗️ System Architecture

```
lib/features/auth/
├── logic/
│   ├── cubits/
│   │   └── auth_cubit.dart         # State management
│   └── states/
│       └── auth_state.dart         # State definitions
├── presentation/
│   ├── screens/
│   │   ├── sing_in/                # Sign In
│   │   └── sing_up_screens/        # Sign Up
│   └── widgets/                    # UI Components
├── domain/                         # Domain Layer (future)
└── data/                           # Data Layer (future)
```

---

## 🔑 AuthCubit - Authentication Management

### Main File
`lib/features/auth/logic/cubits/auth_cubit.dart`

### Basic Definition

```dart
@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  // All functions...
}
```

### Available States

#### 1. Basic States

| State | Description | Usage |
|-------|-------------|-------|
| `AuthInitial` | Initial state | App launch |
| `AuthLoading` | Loading | During operation |
| `AuthSuccess` | Success | Registration complete |
| `AuthError` | Error | Operation failed |

#### 2. Sign In States

```dart
class SignInSuccess extends AuthState {}           // Success
class SignInInvalidCredentials extends AuthState {} // Wrong credentials
class SignInError extends AuthState {
  final String message;
  SignInError(this.message);
}
```

#### 3. OTP Verification States

```dart
class OtpSent extends AuthState {}                 // Code sent
class OtpVerified extends AuthState {}             // Verified
class OtpError extends AuthState {
  final String message;
  OtpError(this.message);
}
```

#### 4. Password Reset States

```dart
class ResetCodeSent extends AuthState {
  final String email;
  ResetCodeSent(this.email);
}
class ResetCodeVerified extends AuthState {}
class ResetPasswordSuccess extends AuthState {}
class ResetPasswordError extends AuthState {
  final String message;
  ResetPasswordError(this.message);
}
```

### Available Functions

#### 1. User Registration

```dart
Future<void> register({
  required String name,
  required String email,
  String? phone,
  required String password,
}) async {
  emit(AuthLoading());
  try {
    // Registration operation
    await registerService.register(
      name: name,
      email: email,
      phone: phone,
      password: password,
    );
    emit(AuthSuccess());
  } catch (e) {
    emit(AuthError(e.toString()));
  }
}
```

**Usage:**
```dart
context.read<AuthCubit>().register(
  name: 'Ahmed',
  email: 'ahmed@email.com',
  phone: '966501234567',
  password: 'password123',
);
```

---

#### 2. Email Login

```dart
Future<void> loginWithEmail(String email, String password) async {
  emit(AuthLoading());
  try {
    // Verify credentials
    final result = await authService.loginEmail(
      email: email,
      password: password,
    );
    
    if (result.isSuccess) {
      // Save token and user data
      await CacheHelper.saveData(key: 'token', value: result.token);
      emit(SignInSuccess());
    } else {
      emit(SignInInvalidCredentials());
    }
  } catch (e) {
    emit(SignInError('Connection error'));
  }
}
```

**Usage:**
```dart
context.read<AuthCubit>().loginWithEmail('user@email.com', 'password');
```

**Response Handling:**
```dart
BlocConsumer<AuthCubit, AuthState>(
  listener: (context, state) {
    if (state is SignInSuccess) {
      context.go(AppRouter.home);
    } else if (state is SignInInvalidCredentials) {
      showErrorSnackBar('Invalid credentials');
    } else if (state is SignInError) {
      showErrorSnackBar(state.message);
    }
  },
  builder: (context, state) {
    if (state is AuthLoading) {
      return const CircularProgressIndicator();
    }
    return const SizedBox();
  },
)
```

---

#### 3. Phone Login

```dart
Future<void> loginWithPhone(String phoneNumber) async {
  emit(AuthLoading());
  try {
    // Send OTP
    await authService.sendOTP(phoneNumber);
    emit(OtpSent());
  } catch (e) {
    emit(AuthError(e.toString()));
  }
}
```

**Usage:**
```dart
context.read<AuthCubit>().loginWithPhone('966501234567');
```

---

#### 4. OTP Verification

```dart
Future<void> verifyOtp(String phoneNumber, String code) async {
  emit(AuthLoading());
  try {
    final isValid = await authService.verifyOTP(phoneNumber, code);
    if (isValid) {
      emit(OtpVerified());
    } else {
      emit(OtpError('Invalid code'));
    }
  } catch (e) {
    emit(OtpError('Verification failed'));
  }
}
```

---

#### 5. Password Recovery

##### Step 1: Send Reset Code

```dart
Future<void> sendResetCode(String email) async {
  emit(AuthLoading());
  try {
    await authService.sendPasswordResetCode(email);
    emit(ResetCodeSent(email));
  } catch (e) {
    emit(AuthError(e.toString()));
  }
}
```

##### Step 2: Verify Code

```dart
Future<void> verifyResetCode(String email, String code) async {
  emit(AuthLoading());
  try {
    final isValid = await authService.verifyResetCode(email, code);
    if (isValid) {
      emit(ResetCodeVerified());
    } else {
      emit(ResetCodeError('Invalid or expired code'));
    }
  } catch (e) {
    emit(ResetCodeError('Verification failed'));
  }
}
```

##### Step 3: Set New Password

```dart
Future<void> resetPassword({
  required String email,
  required String code,
  required String newPassword,
}) async {
  emit(AuthLoading());
  try {
    await authService.resetPassword(
      email: email,
      code: code,
      newPassword: newPassword,
    );
    emit(ResetPasswordSuccess());
  } catch (e) {
    emit(ResetPasswordError('Password reset failed'));
  }
}
```

---

#### 6. Form Field Updates

```dart
void emailChanged(String email) {
  // Future: Monitor email changes
}

void passwordChanged(String password) {
  // Future: Monitor password changes
}

void rememberMeChanged(bool value) {
  // Future: Save remember me option
}
```

---

## 🎨 Screens

### 1. Sign In Screen - Login

**Location:** `lib/features/auth/sing_in/sing_in.dart`

#### Structure

```
SingIn (StatelessWidget)
└── BlocProvider<AuthCubit>
    └── _SingInBody
        ├── AppBar (Back & Language Toggle)
        ├── BlocConsumer<AuthCubit, AuthState>
        │   ├── Listener (Event Handling)
        │   └── Builder (UI Building)
        └── Content
            ├── Welcome Title
            ├── _EmailField
            ├── _PasswordField
            ├── _LoginButton
            ├── _RememberAndForgot
            ├── AuthOrDivider
            ├── AuthSocialButton (Google)
            ├── AuthSocialButton (Apple)
            └── _SignUpRow
```

#### Internal Components

##### _EmailField
```dart
class _EmailField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthTextField(
      label: AppStrings.emailLabel,
      hint: AppStrings.emailPlaceholder,
      prefixIcon: Icons.mail_outline_rounded,
      keyboardType: TextInputType.emailAddress,
      onChanged: (email) {
        context.read<AuthCubit>().emailChanged(email);
      },
    );
  }
}
```

##### _PasswordField
```dart
class _PasswordField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthTextField(
      label: AppStrings.passwordLabel,
      hint: AppStrings.passwordPlaceholder,
      prefixIcon: Icons.lock_outline_rounded,
      isPassword: true,
      onChanged: (password) {
        context.read<AuthCubit>().passwordChanged(password);
      },
    );
  }
}
```

##### _LoginButton
```dart
class _LoginButton extends StatelessWidget {
  final bool isLoading;
  
  @override
  Widget build(BuildContext context) {
    return AuthPrimaryButton(
      label: AppStrings.login,
      isLoading: isLoading,
      onPressed: () {
        context.read<AuthCubit>().loginWithEmail('email', 'password');
      },
    );
  }
}
```

#### Event Handling

```dart
void _handleStateListener(BuildContext context, AuthState state) {
  if (state is SignInSuccess) {
    // Successful login
    context.go(AppRouter.home);
  } else if (state is SignInInvalidCredentials) {
    // Wrong credentials
    showErrorSnackBar('Invalid login credentials');
  } else if (state is SignInError) {
    // General error
    showErrorSnackBar(state.message);
  }
}
```

---

### 2. Sign Up Screen - Create Account

**Location:** `lib/features/auth/sing_up_screens/complete_profile_screen/complete_profile_screen.dart`

#### Structure

```
CompleteProfileScreen (StatefulWidget)
├── BlocProvider<AuthCubit>
│   └── Scaffold
│       └── BlocConsumer<AuthCubit, AuthState>
│           ├── Listener (Success/Error)
│           └── Builder
│               ├── FadeTransition
│               └── SlideTransition
│                   └── SafeArea
│                       └── SingleChildScrollView
│                           └── Form
│                               ├── Back Button
│                               ├── Profile Avatar
│                               ├── Title
│                               ├── AuthFormField (Name)
│                               ├── AuthFormField (Email)
│                               ├── AuthFormField (Password)
│                               ├── AuthFormField (Confirm)
│                               └── AuthPrimaryButton
```

#### Form Validation

```dart
// Name Validation
validator: (v) {
  if (v == null || v.trim().isEmpty) {
    return 'Name is required';
  }
  if (v.length < 3) {
    return 'Name must be at least 3 characters';
  }
  return null;
}

// Email Validation
validator: (v) {
  if (v == null || v.trim().isEmpty) {
    return 'Email is required';
  }
  if (!v.contains('@') || !v.contains('.')) {
    return 'Invalid email format';
  }
  return null;
}

// Password Validation
validator: (v) {
  if (v == null || v.isEmpty) {
    return 'Password is required';
  }
  if (v.length < 6) {
    return 'Minimum 6 characters required';
  }
  return null;
}

// Confirm Password
validator: (v) {
  if (v == null || v.isEmpty) {
    return 'Confirm password is required';
  }
  if (v != _passCtrl.text) {
    return 'Passwords do not match';
  }
  return null;
}
```

#### Submission Handling

```dart
void _onComplete(BuildContext context) {
  if (!_formKey.currentState!.validate()) return;
  
  context.read<AuthCubit>().register(
    name: _nameCtrl.text.trim(),
    email: _emailCtrl.text.trim(),
    phone: widget.phoneNumber ?? '',
    password: _passCtrl.text,
  );
}
```

---

## 🧩 Shared UI Components

### AuthTextField
```dart
AuthTextField(
  label: 'Email Address',
  hint: 'Enter your email',
  prefixIcon: Icons.mail,
  keyboardType: TextInputType.emailAddress,
  isPassword: false,
  onChanged: (value) { },
)
```

### AuthFormField
```dart
AuthFormField(
  label: 'Name',
  hint: 'Enter your name',
  controller: _nameController,
  prefixIcon: Icons.person,
  validator: (value) => validateName(value),
)
```

### AuthPrimaryButton
```dart
AuthPrimaryButton(
  label: 'Login',
  isLoading: false,
  onPressed: () { },
)
```

---

## 🔄 Complete Workflows

### New User Sign Up

```
1. User opens app
   ↓
2. Splash Screen (8 seconds)
   ↓
3. Check onboarding from cache
   ├─ New user → Onboarding Screen
   └─ Existing → Sign In Screen
   ↓
4. Complete Profile Screen
   ↓
5. Fill form:
   - Name
   - Email
   - Password
   - Confirm Password
   ↓
6. Click "Complete Registration"
   ↓
7. Form validation
   ├─ Error → Show message
   └─ Success → AuthCubit.register()
       ├─ emit(AuthLoading)
       └─ API Call
           ├─ Success → emit(AuthSuccess) → Home Screen
           └─ Failed → emit(AuthError) → Error Snackbar
```

### Password Recovery

```
1. From Sign In → "Forgot Password?"
   ↓
2. Forget Password Screen
   ↓
3. Enter email
   ↓
4. AuthCubit.sendResetCode(email)
   ├─ emit(AuthLoading)
   └─ emit(ResetCodeSent)
   ↓
5. Check Your Email Screen
   ↓
6. Enter verification code
   ↓
7. AuthCubit.verifyResetCode(email, code)
   ├─ Valid → emit(ResetCodeVerified)
   └─ Invalid → emit(ResetCodeError)
   ↓
8. Set New Password Screen
   ↓
9. Enter new password
   ↓
10. AuthCubit.resetPassword(email, code, newPassword)
    ├─ Success → emit(ResetPasswordSuccess) → Sign In
    └─ Failed → emit(ResetPasswordError)
```

---

## ⚠️ Important Notes

### 1. Security
```dart
// ✅ Correct: Don't print passwords
emit(AuthLoading());

// ❌ Wrong: Never log sensitive data
print('Password: $password');
```

### 2. Error Handling
```dart
// ✅ Correct: Clear user message
emit(AuthError('Email already exists'));

// ❌ Wrong: Technical error message
emit(AuthError(e.toString()));
```

### 3. Validation
```dart
// ✅ Correct: Complete validation
validator: (v) {
  if (v == null || v.isEmpty) return 'Required';
  if (v.length < 3) return 'Too short';
  return null;
}

// ❌ Wrong: Partial validation
validator: (v) => v?.isEmpty ?? true ? 'Required' : null
```

### 4. State Management
```dart
// ✅ Correct: Use BlocBuilder/Consumer
BlocBuilder<AuthCubit, AuthState>(
  builder: (context, state) => ...,
)

// ❌ Wrong: Don't use setState
setState(() => isLoading = true);
```

---

## 📚 References

- [Flutter BLoC Library](https://bloclibrary.dev/)
- [Clean Architecture](https://resocoder.com/flutter-clean-architecture)
- [State Management Best Practices](https://codewithandrea.com/articles/flutter-state-management-riverpod/)

---

**Last Updated:** 2024
**Version:** 1.0
