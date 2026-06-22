# أمثلة عملية لإعادة هيكلة فصل الـ UI و Logic

---

## 1️⃣ إعادة هيكلة SignIn Screen

### ❌ الحالة الحالية (خاطئة)

```dart
// sing_in_screen.dart - كل المنطق مختلط مع الـ UI
class _SignInScreenState extends State<SignInScreen> {
  bool _isValidEmail(String email) {  // ❌ منطق في الـ Screen
    return email.contains('@') && email.contains('.');
  }

  bool _isFormValid() {  // ❌ منطق في الـ Screen
    return _emailCtrl.text.trim().isNotEmpty &&
        _isValidEmail(_emailCtrl.text.trim()) &&
        _passwordCtrl.text.trim().length >= 4;
  }

  void _showErrorSnackBar(String message) {  // ❌ عرض مباشر في الـ Screen
    ScaffoldMessenger.of(context).showSnackBar(...);
  }
}
```

### ✅ الحالة المطلوبة (صحيحة)

#### أولاً: إنشاء Validation Class
```dart
// lib/core/validation/auth_validation.dart
class AuthValidation {
  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 128;

  static bool isValidEmail(String email) {
    return RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(email.trim());
  }

  static bool isValidPassword(String password) {
    return password.trim().length >= minPasswordLength;
  }

  static bool isFormValid({
    required String email,
    required String password,
  }) {
    return isValidEmail(email) && isValidPassword(password);
  }

  static String getEmailErrorMessage(String email) {
    if (email.isEmpty) return 'البريد الإلكتروني مطلوب';
    if (!isValidEmail(email)) return 'البريد الإلكتروني غير صحيح';
    return '';
  }

  static String getPasswordErrorMessage(String password) {
    if (password.isEmpty) return 'كلمة المرور مطلوبة';
    if (password.length < minPasswordLength) {
      return 'كلمة المرور يجب أن تكون $minPasswordLength أحرف على الأقل';
    }
    return '';
  }
}
```

#### ثانياً: إنشاء Cubit للتحكم بـ UI State
```dart
// lib/features/auth/logic/cubits/sign_in_ui_cubit.dart
class SignInUiCubit extends Cubit<SignInUiState> {
  SignInUiCubit() : super(SignInUiInitial());

  void togglePasswordVisibility() {
    if (state is SignInUiState) {
      final current = state as SignInUiState;
      emit(current.copyWith(
        isPasswordVisible: !current.isPasswordVisible,
      ));
    }
  }

  void updateFormValidity({
    required String email,
    required String password,
  }) {
    final isValid = AuthValidation.isFormValid(
      email: email,
      password: password,
    );
    emit((state as SignInUiState).copyWith(
      isFormValid: isValid,
      emailError: AuthValidation.getEmailErrorMessage(email),
      passwordError: AuthValidation.getPasswordErrorMessage(password),
    ));
  }

  void setRememberMe(bool value) {
    emit((state as SignInUiState).copyWith(rememberMe: value));
  }
}

// State
class SignInUiState extends Equatable {
  final bool isPasswordVisible;
  final bool rememberMe;
  final bool isFormValid;
  final String emailError;
  final String passwordError;

  const SignInUiState({
    this.isPasswordVisible = false,
    this.rememberMe = false,
    this.isFormValid = false,
    this.emailError = '',
    this.passwordError = '',
  });

  SignInUiState copyWith({
    bool? isPasswordVisible,
    bool? rememberMe,
    bool? isFormValid,
    String? emailError,
    String? passwordError,
  }) {
    return SignInUiState(
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      rememberMe: rememberMe ?? this.rememberMe,
      isFormValid: isFormValid ?? this.isFormValid,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
    );
  }

  @override
  List<Object?> get props => [
    isPasswordVisible,
    rememberMe,
    isFormValid,
    emailError,
    passwordError,
  ];
}
```

#### ثالثاً: إنشاء Error Dialog Widget
```dart
// lib/core/widgets/error_dialog.dart
class ErrorDialog extends StatelessWidget {
  final String message;
  final String? title;
  final VoidCallback? onRetry;

  const ErrorDialog({
    required this.message,
    this.title,
    this.onRetry,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title != null ? Text(title!) : null,
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('إغلاق'),
        ),
        if (onRetry != null)
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onRetry!();
            },
            child: const Text('إعادة محاولة'),
          ),
      ],
    );
  }
}
```

#### رابعاً: تنظيف الـ Screen
```dart
// lib/features/auth/presentation/screens/sign in/sing_in_screen.dart
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  late final AuthCubit _authCubit;
  late final SignInUiCubit _uiCubit;

  @override
  void initState() {
    super.initState();
    _authCubit = getIt<AuthCubit>();
    _uiCubit = SignInUiCubit();
    
    // Listen to text changes
    _emailCtrl.addListener(_updateFormValidity);
    _passwordCtrl.addListener(_updateFormValidity);
  }

  void _updateFormValidity() {
    _uiCubit.updateFormValidity(
      email: _emailCtrl.text,
      password: _passwordCtrl.text,
    );
  }

  void _handleSignIn(BuildContext context) {
    // ✅ منطق بسيط فقط - استدعاء Cubit
    _authCubit.login(
      email: _emailCtrl.text.trim(),
      password: _passwordCtrl.text,
    );
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _uiCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = AppStrings.isArabic;

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              // ✅ معالجة الحالات - بدون logic
              if (state is AuthSuccess) {
                _showSuccessSnackBar('تم تسجيل الدخول بنجاح');
                Future.delayed(const Duration(seconds: 1), () {
                  if (!context.mounted) return;
                  Navigator.of(context).pushReplacementNamed(AppRoutes.home);
                });
              } else if (state is AuthError) {
                _showErrorDialog(state.message);
              }
            },
            child: BlocBuilder<SignInUiCubit, SignInUiState>(
              bloc: _uiCubit,
              builder: (context, uiState) {
                // ✅ UI فقط
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('أهلا بعودتك'),
                      SizedBox(height: 24.h),
                      // Email Field
                      AuthFormField(
                        label: 'البريد الإلكتروني',
                        controller: _emailCtrl,
                        errorText: uiState.emailError,
                      ),
                      SizedBox(height: 16.h),
                      // Password Field
                      AuthFormField(
                        label: 'كلمة المرور',
                        controller: _passwordCtrl,
                        obscureText: !uiState.isPasswordVisible,
                        onToggleObscure: () =>
                            _uiCubit.togglePasswordVisibility(),
                        errorText: uiState.passwordError,
                      ),
                      SizedBox(height: 24.h),
                      // Sign In Button
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, authState) {
                          return AuthPrimaryButton(
                            label: 'دخول',
                            isLoading: authState is AuthLoading,
                            isEnabled: uiState.isFormValid,
                            onPressed: () => _handleSignIn(context),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => ErrorDialog(message: message),
    );
  }
}
```

---

## 2️⃣ إعادة هيكلة SignUp Screen مع Phone Field

### ✅ إنشاء Phone Input Field Widget

```dart
// lib/features/auth/presentation/widgets/phone_input_field.dart
class PhoneInputField extends StatefulWidget {
  final TextEditingController controller;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final String countryCode;
  final String countryFlag;

  const PhoneInputField({
    required this.controller,
    this.errorText,
    this.onChanged,
    this.countryCode = '+974',
    this.countryFlag = '🇶🇦',
    super.key,
  });

  @override
  State<PhoneInputField> createState() => _PhoneInputFieldState();
}

class _PhoneInputFieldState extends State<PhoneInputField> {
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = (widget.errorText?.isNotEmpty ?? false)
        ? AppColors.errorRed
        : AppColors.borderFocus;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 56.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(color: borderColor, width: 1.5),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          // Country Flag & Code
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.countryFlag, style: TextStyle(fontSize: 18.sp)),
              SizedBox(width: 8.w),
              Text(
                widget.countryCode,
                style: AppText.ibmDescription14(color: AppColors.primaryText)
                    .copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          SizedBox(width: 12.w),
          Container(width: 1, height: 22.h, color: AppColors.borderInputs),
          SizedBox(width: 16.w),
          // Phone Input
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              keyboardType: TextInputType.phone,
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.left,
              style: AppText.ibmDescription14(color: AppColors.primaryText)
                  .copyWith(fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                hintText: 'رقم الهاتف',
                hintStyle: AppText.ibmPlaceholder14(),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
              onChanged: (value) {
                setState(() {}); // Update border color
                widget.onChanged?.call(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
```

### ✅ إنشاء Phone Validation Class

```dart
// lib/core/validation/phone_validation.dart
class PhoneValidation {
  static const int qatarPhoneLength = 8;
  static const String countryCode = '+974';

  static bool isValidQatarPhone(String phoneNumber) {
    final cleaned = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    
    if (cleaned.length != qatarPhoneLength) return false;
    
    // رقم صحيح في قطر يبدأ من 3-9
    final firstDigit = int.parse(cleaned[0]);
    return firstDigit >= 3 && firstDigit <= 9;
  }

  static String getErrorMessage(String phoneNumber) {
    if (phoneNumber.isEmpty) return 'رقم الهاتف مطلوب';
    
    final cleaned = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    
    if (cleaned.length < qatarPhoneLength) {
      return 'رقم الهاتف ناقص';
    }
    if (cleaned.length > qatarPhoneLength) {
      return 'رقم الهاتف طويل جداً';
    }
    if (!isValidQatarPhone(phoneNumber)) {
      return 'رقم هاتف غير صحيح';
    }
    
    return '';
  }

  static String formatPhoneNumber(String phoneNumber) {
    return '$countryCode$phoneNumber';
  }
}
```

### ✅ تنظيف SignUp Screen

```dart
// lib/features/auth/presentation/screens/sign up/sing_up_screen.dart
class _SignUpScreenState extends State<SignUpScreen> {
  final _phoneCtrl = TextEditingController();
  late final AuthCubit _authCubit;
  late final SignUpUiCubit _uiCubit;

  @override
  void initState() {
    super.initState();
    _authCubit = getIt<AuthCubit>();
    _uiCubit = SignUpUiCubit();
    _phoneCtrl.addListener(_updateFormValidity);
  }

  void _updateFormValidity() {
    _uiCubit.updatePhoneValidity(_phoneCtrl.text);
  }

  void _handleSendCode(BuildContext context) {
    // ✅ منطق بسيط - استدعاء Cubit فقط
    _authCubit.sendOtp(
      phoneNumber: PhoneValidation.formatPhoneNumber(_phoneCtrl.text.trim()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is OtpSent) {
            Navigator.of(context).pushNamed(AppRoutes.otp);
          } else if (state is AuthError) {
            _showErrorDialog(state.message);
          }
        },
        child: BlocBuilder<SignUpUiCubit, SignUpUiState>(
          bloc: _uiCubit,
          builder: (context, uiState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Text('أهلا بك'),
                  SizedBox(height: 32.h),
                  // ✅ استخدام الـ Widget المنفصل
                  PhoneInputField(
                    controller: _phoneCtrl,
                    errorText: uiState.phoneError,
                    onChanged: (_) => _updateFormValidity(),
                  ),
                  if (uiState.phoneError.isNotEmpty) ...[
                    SizedBox(height: 6.h),
                    Text(
                      uiState.phoneError,
                      style: AppText.ibmError12(),
                    ),
                  ],
                  SizedBox(height: 24.h),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, authState) {
                      return AuthPrimaryButton(
                        label: 'إرسال الكود',
                        isLoading: authState is AuthLoading,
                        isEnabled: uiState.isPhoneValid,
                        onPressed: () => _handleSendCode(context),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
```

---

## 3️⃣ إنشاء Cubits للـ Splash و Onboarding

### Splash Cubit

```dart
// lib/features/splash/logic/splash_cubit.dart
class SplashCubit extends Cubit<SplashState> {
  final CacheHelper _cacheHelper;

  SplashCubit({required CacheHelper cacheHelper})
      : _cacheHelper = cacheHelper,
        super(SplashInitial());

  Future<void> checkFirstTime() async {
    try {
      await Future.delayed(const Duration(seconds: 2)); // Animation duration
      
      final isOnBoarded = _cacheHelper.getData(key: 'onBoarding') ?? false;
      
      if (isOnBoarded) {
        emit(SplashNavigateToSignUp());
      } else {
        emit(SplashNavigateToOnboarding());
      }
    } catch (e) {
      emit(SplashError(e.toString()));
    }
  }
}

// States
abstract class SplashState extends Equatable {}

class SplashInitial extends SplashState {
  @override
  List<Object?> get props => [];
}

class SplashNavigateToOnboarding extends SplashState {
  @override
  List<Object?> get props => [];
}

class SplashNavigateToSignUp extends SplashState {
  @override
  List<Object?> get props => [];
}

class SplashError extends SplashState {
  final String message;

  SplashError(this.message);

  @override
  List<Object?> get props => [message];
}
```

### Onboarding Cubit

```dart
// lib/features/onboarding/logic/onboarding_cubit.dart
class OnboardingCubit extends Cubit<OnboardingState> {
  final CacheHelper _cacheHelper;

  OnboardingCubit({required CacheHelper cacheHelper})
      : _cacheHelper = cacheHelper,
        super(OnboardingInitial());

  void nextPage() {
    emit(OnboardingPageChanged(page: (state as OnboardingState).currentPage + 1));
  }

  void skipToEnd() {
    emit(OnboardingPageChanged(page: 2));
  }

  Future<void> completeOnboarding() async {
    try {
      final saved = await _cacheHelper.saveData(
        key: 'onBoarding',
        value: true,
      );
      
      if (saved) {
        emit(OnboardingCompleted());
      } else {
        emit(OnboardingError('فشل حفظ البيانات'));
      }
    } catch (e) {
      emit(OnboardingError(e.toString()));
    }
  }
}

// States
abstract class OnboardingState extends Equatable {
  int get currentPage => 0;
}

class OnboardingInitial extends OnboardingState {
  @override
  List<Object?> get props => [];
}

class OnboardingPageChanged extends OnboardingState {
  final int page;

  OnboardingPageChanged({required this.page});

  @override
  int get currentPage => page;

  @override
  List<Object?> get props => [page];
}

class OnboardingCompleted extends OnboardingState {
  @override
  List<Object?> get props => [];
}

class OnboardingError extends OnboardingState {
  final String message;

  OnboardingError(this.message);

  @override
  List<Object?> get props => [message];
}
```

---

## ✅ الفوائد بعد الإعادة الهيكلية

| الجانب | قبل | بعد |
|--------|-----|-----|
| **اختبار Validation** | صعب (يحتاج UI) | سهل (unit tests) |
| **إعادة استخدام الـ Widget** | محدود | كامل |
| **إدارة حالة الـ UI** | مختلطة | واضحة ومنظمة |
| **صيانة الكود** | صعبة | سهلة |
| **إضافة ميزات جديدة** | معقدة | بسيطة |
| **Size من الملفات** | كبير | أصغر |

---

## 📝 ملاحظات مهمة

1. **كل Cubit = مسؤولية واحدة فقط**
   - `AuthCubit` → Authentication Logic
   - `SignInUiCubit` → UI State (password visibility, etc.)
   - `SplashCubit` → Navigation Logic

2. **الـ Screen يجب أن يحتوي على:**
   - Build method فقط
   - BlocListener للـ listeners
   - BlocBuilder للـ UI
   - Controller initialization

3. **لا يجب في الـ Screen:**
   - Validation logic
   - Error handling (معقد)
   - Business logic

---

**هذا التقرير يوفر اتجاهات واضحة للتطبيق!** ✅
