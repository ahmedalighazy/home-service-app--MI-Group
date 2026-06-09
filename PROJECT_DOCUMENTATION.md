# Home Service App - Authentication Screens Documentation

## 📋 Overview

This document covers the **Authentication Screens** implementation in the Home Service App, including:
- **Sign In Screen** - Email/Password login
- **Sign Up Screen** - Account creation with profile completion
- **Authentication State Management** (AuthCubit)
- **Validation & Error Handling**
- **Navigation Flow**

---

## 🔐 Authentication System Architecture

### Folder Structure

```
lib/features/auth/
├── presentation/
│   ├── screens/
│   │   ├── sign in/
│   │   │   └── sing_in_screen.dart
│   │   ├── sign up/
│   │   │   └── sing_up_screen.dart
│   │   ├── complete profile/
│   │   │   └── complete_profile_unified_screen.dart
│   │   ├── otp/
│   │   ├── set new pass/
│   │   └── ... other screens
│   └── widgets/
│       ├── common/
│       ├── sign_in/
│       ├── sign_up/
│       ├── auth_form_field.dart
│       ├── auth_primary_button.dart
│       ├── auth_text_field.dart
│       └── ... other widgets
├── logic/
│   └── cubits/
│       └── auth_cubit.dart
└── domain/
    └── entities/
        └── user_profile.dart
```

### Key Technologies Used

```dart
// State Management
flutter_bloc: ^8.1.4 (Cubit pattern)

// Navigation
go_router: ^14.8.1 (Type-safe routing)

// Dependency Injection
get_it: ^7.7.0 (Service locator)

// UI/Responsiveness
flutter_screenutil: ^5.9.0 (Responsive sizing)

// Validation
auth_validation.dart (Custom validation)

// Caching
shared_preferences: (LocalStorage for auth state)
```

---

## 1️⃣ Sign In Screen

**File:** `lib/features/auth/presentation/screens/sign in/sing_in_screen.dart`

### Purpose
- Email and password login
- Remember me functionality
- Social login options
- Forgot password link
- Navigation to sign up

### Architecture Pattern

```dart
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  late final AuthCubit _authCubit;

  @override
  void initState() {
    super.initState();
    _authCubit = getIt<AuthCubit>();
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>.value(
      value: _authCubit,
      child: Scaffold(
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: _handleAuthStateChange,
          builder: (context, state) {
            return _buildSignInForm(context, state);
          },
        ),
      ),
    );
  }
}
```

### Key Implementation Details

```dart
// 1. Form Building
Widget _buildSignInForm(BuildContext context, AuthState state) {
  return SingleChildScrollView(
    child: Column(
      children: [
        // Email Input
        AuthTextField(
          label: 'Email',
          controller: _emailCtrl,
          prefixIcon: Icons.mail_outline_rounded,
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {},
        ),
        
        // Password Input
        AuthTextField(
          label: 'Password',
          controller: _passwordCtrl,
          prefixIcon: Icons.lock_outline_rounded,
          isPassword: true,
          onChanged: (value) {},
        ),
        
        // Remember Me & Forgot Password
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RememberMeCheckbox(
              onChanged: (value) {
                context.read<AuthCubit>().rememberMeChanged(value);
              },
            ),
            ForgotPasswordLink(
              onTap: () => context.push(AppRouter.forgetPassword),
            ),
          ],
        ),
        
        // Login Button
        AuthPrimaryButton(
          label: 'Login',
          isLoading: state is AuthLoading,
          onPressed: () => _handleLogin(),
        ),
        
        // Social Login
        AuthOrDivider(),
        GoogleSignInButton(onTap: () {}),
        AppleSignInButton(onTap: () {}),
        
        // Sign Up Link
        SignUpLink(
          onTap: () => context.go(AppRouter.signUp),
        ),
      ],
    ),
  );
}

// 2. Login Handler
void _handleLogin() {
  final email = _emailCtrl.text.trim();
  final password = _passwordCtrl.text.trim();

  if (!_validateInputs(email, password)) return;

  _authCubit.loginWithEmail(email, password);
}

// 3. State Change Listener
void _handleAuthStateChange(BuildContext context, AuthState state) {
  if (state is AuthSuccess) {
    context.go(AppRouter.home);
  } else if (state is AuthInvalidCredentials) {
    _showErrorSnackBar(context, 'Invalid email or password');
  } else if (state is AuthError) {
    _showErrorSnackBar(context, state.message);
  }
}

// 4. Input Validation
bool _validateInputs(String email, String password) {
  if (!AuthValidation.isValidEmail(email)) {
    _showErrorSnackBar(context, AuthValidation.getEmailErrorMessage(email));
    return false;
  }
  if (!AuthValidation.isValidPassword(password)) {
    _showErrorSnackBar(context, AuthValidation.getPasswordErrorMessage(password));
    return false;
  }
  return true;
}
```

### UI Components Used

| Component | Purpose |
|-----------|---------|
| `AuthTextField` | Email & password input with styling |
| `AuthPrimaryButton` | Primary action button with loading state |
| `RememberMeCheckbox` | Remember me option |
| `AuthOrDivider` | Social login separator |
| `GoogleSignInButton` | Google authentication |
| `AppleSignInButton` | Apple authentication |

---

## 2️⃣ Sign Up Screen

**File:** `lib/features/auth/presentation/screens/sign up/sing_up_screen.dart`

### Purpose
- Phone number collection
- OTP verification
- Profile completion
- Account creation

### Multi-Step Flow

```dart
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  int _currentStep = 0; // 0: Phone, 1: OTP, 2: Profile
  final _phoneCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  @override
  void dispose() {
    _phoneCtrl.dispose();
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>.value(
      value: getIt<AuthCubit>(),
      child: Scaffold(
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: _handleSignUpProgress,
          builder: (context, state) {
            return _buildStepScreen(_currentStep, state);
          },
        ),
      ),
    );
  }

  // Step 1: Phone Number
  Widget _buildPhoneStep(AuthState state) {
    return Column(
      children: [
        AuthTextField(
          label: 'Phone Number',
          hint: 'Enter your phone',
          controller: _phoneCtrl,
          keyboardType: TextInputType.phone,
        ),
        AuthPrimaryButton(
          label: 'Send OTP',
          isLoading: state is AuthLoading,
          onPressed: () {
            final phone = _phoneCtrl.text.trim();
            if (AuthValidation.isValidPhone(phone)) {
              context.read<AuthCubit>().sendOtp(phoneNumber: phone);
            }
          },
        ),
      ],
    );
  }

  // Step 2: OTP Verification
  Widget _buildOtpStep(AuthState state) {
    return Column(
      children: [
        Text('Enter 6-digit code sent to your phone'),
        OtpInputRow(
          onComplete: (code) {
            if (AuthValidation.isValidOtpCode(code)) {
              context.read<AuthCubit>().verifyOtp(
                phoneNumber: _phoneCtrl.text,
                otp: code,
              );
            }
          },
        ),
      ],
    );
  }

  // Step 3: Profile Completion
  Widget _buildProfileStep(AuthState state) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AuthFormField(
            label: 'Full Name',
            controller: _nameCtrl,
            validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
          ),
          AuthFormField(
            label: 'Email',
            controller: _emailCtrl,
            keyboardType: TextInputType.emailAddress,
            validator: (v) => AuthValidation.isValidEmail(v ?? '') 
              ? null 
              : 'Invalid email',
          ),
          AuthPrimaryButton(
            label: 'Create Account',
            isLoading: state is AuthLoading,
            onPressed: () => _submitProfile(context),
          ),
        ],
      ),
    );
  }

  void _handleSignUpProgress(BuildContext context, AuthState state) {
    if (state is OtpSent) {
      setState(() => _currentStep = 1);
    } else if (state is OtpVerified) {
      setState(() => _currentStep = 2);
    } else if (state is AuthSuccess) {
      context.go(AppRouter.home);
    } else if (state is AuthError) {
      _showErrorSnackBar(context, state.message);
    }
  }
}
```

---

## 🎮 AuthCubit - State Management

**File:** `lib/features/auth/logic/cubits/auth_cubit.dart`

### Cubit Implementation

```dart
@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  // ─── Sign In ──────────────────────────────
  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      if (!AuthValidation.isValidEmail(email)) {
        emit(AuthError('Invalid email format'));
        return;
      }
      if (!AuthValidation.isValidPassword(password)) {
        emit(AuthError('Password must be at least 6 characters'));
        return;
      }

      await Future.delayed(const Duration(seconds: 2));
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError('Connection error: ${e.toString()}'));
    }
  }

  // ─── Sign Up ────────────────────────────
  Future<void> sendOtp({
    required String phoneNumber,
    String? email,
  }) async {
    emit(AuthLoading());
    try {
      if (!AuthValidation.isValidPhone(phoneNumber)) {
        emit(AuthError('Invalid phone number'));
        return;
      }
      
      await Future.delayed(const Duration(seconds: 1));
      emit(OtpSent());
    } catch (e) {
      emit(AuthError('Failed to send OTP'));
    }
  }

  Future<void> verifyOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    emit(AuthLoading());
    try {
      if (!AuthValidation.isValidOtpCode(otp)) {
        emit(AuthError('Invalid OTP code'));
        return;
      }

      await Future.delayed(const Duration(seconds: 1));
      emit(OtpVerified());
    } catch (e) {
      emit(AuthError('OTP verification failed'));
    }
  }

  Future<void> register({
    required String name,
    required String email,
    String? phone,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // ─── Social Login ──────────────────────
  Future<void> signInWithGoogle() async {
    emit(SocialSignInLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));
      emit(GoogleSignInSuccess(
        email: 'user@gmail.com',
        displayName: 'Google User',
      ));
    } catch (e) {
      emit(SocialSignInError('Google sign in failed'));
    }
  }

  Future<void> signInWithApple() async {
    emit(SocialSignInLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));
      emit(AppleSignInSuccess(
        email: 'user@icloud.com',
        displayName: 'Apple User',
      ));
    } catch (e) {
      emit(SocialSignInError('Apple sign in failed'));
    }
  }
}
```

### Authentication States

```dart
abstract class AuthState {}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}

// ─── Sign In States ────────────────────
class AuthSuccess extends AuthState {}
class AuthInvalidCredentials extends AuthState {}
class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

// ─── Sign Up States ───────────────────
class OtpSent extends AuthState {}
class OtpVerified extends AuthState {}

// ─── Social States ────────────────────
class SocialSignInLoading extends AuthState {}
class GoogleSignInSuccess extends AuthState {
  final String? email;
  final String? displayName;
  GoogleSignInSuccess({this.email, this.displayName});
}
class AppleSignInSuccess extends AuthState {
  final String? email;
  final String? displayName;
  AppleSignInSuccess({this.email, this.displayName});
}
class SocialSignInError extends AuthState {
  final String message;
  SocialSignInError(this.message);
}
```

---

## ✅ Input Validation

**File:** `lib/core/utils/validation/auth_validation.dart`

```dart
class AuthValidation {
  static bool isValidEmail(String email) {
    if (email.isEmpty) return false;
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    return emailRegex.hasMatch(email);
  }

  static bool isValidPassword(String password) {
    return password.isNotEmpty && password.length >= 6;
  }

  static bool isValidOtpCode(String code) {
    if (code.isEmpty) return false;
    return code.length == 6 && RegExp(r'^\d{6}$').hasMatch(code);
  }

  static bool isValidPhone(String phone) {
    return phone.isNotEmpty && phone.length >= 7;
  }

  static String getEmailErrorMessage(String email) {
    if (email.isEmpty) return 'Email is required';
    if (!isValidEmail(email)) return 'Invalid email format';
    return '';
  }

  static String getPasswordErrorMessage(String password) {
    if (password.isEmpty) return 'Password is required';
    if (password.length < 6) return 'Password must be at least 6 characters';
    return '';
  }
}
```

---

## 🧩 Reusable Auth Widgets

### 1. AuthTextField
```dart
class AuthTextField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData prefixIcon;
  final bool isPassword;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(prefixIcon),
        border: OutlineInputBorder(),
      ),
      obscureText: isPassword,
      keyboardType: keyboardType,
      onChanged: onChanged,
    );
  }
}
```

### 2. AuthFormField
```dart
class AuthFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      validator: validator,
    );
  }
}
```

### 3. AuthPrimaryButton
```dart
class AuthPrimaryButton extends StatelessWidget {
  final String label;
  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? CircularProgressIndicator(strokeWidth: 2)
          : Text(label),
    );
  }
}
```

---

## 🔄 Navigation Flow

```
Sign In Screen
    ├─ Login Success → Home Screen
    ├─ Invalid Credentials → Show Error
    ├─ Forgot Password → Reset Password Flow
    └─ No Account → Sign Up Screen
        ├─ Enter Phone
        ├─ Verify OTP
        ├─ Complete Profile
        └─ Success → Home Screen
```

---

## 📝 Setup & Usage

```dart
// main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await setupGetIt();
  runApp(const HomeServiceApp());
}

// Use AuthCubit
BlocProvider<AuthCubit>(
  create: (_) => getIt<AuthCubit>(),
  child: SignInScreen(),
)
```

---

## 🎯 Best Practices Applied

```
✅ StatefulWidget for screens with TextControllers
✅ BlocConsumer for state + UI updates
✅ Input validation before API calls
✅ Error handling with user-friendly messages
✅ Loading states during async operations
✅ Resource cleanup in dispose()
✅ Reusable auth widgets
✅ Centralized validation logic
✅ Dependency Injection for testability
✅ GoRouter for type-safe navigation
```

---

**End of Documentation**
