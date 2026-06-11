/// Auth Feature Strings
/// 
/// All static strings used in Auth feature screens and widgets
/// This prevents hardcoding strings and makes translations easier
class AuthStrings {
  // Private constructor to prevent instantiation
  AuthStrings._();

  // === Sign In Screen ===
  static const String signInTitle = 'تسجيل الدخول';
  static const String welcomeBackAlt = 'مرحباً بعودتك';
  static const String emailLabel = 'البريد الإلكتروني';
  static const String emailPlaceholder = 'أدخل البريد الإلكتروني';
  static const String passwordLabel = 'كلمة المرور';
  static const String passwordPlaceholder = 'أدخل كلمة المرور';
  static const String login = 'تسجيل الدخول';
  static const String rememberMe = 'تذكرني';
  static const String forgotPassword = 'نسيت كلمة المرور؟';
  static const String orUsing = 'أو باستخدام';
  static const String signInWithGoogle = 'تسجيل عبر Google';
  static const String signInWithApple = 'تسجيل عبر Apple';
  static const String dontHaveAccount = 'ليس لديك حساب ؟ ';
  static const String createAccount = 'إنشاء حساب';
  
  // Terms and Privacy granular strings for RichText
  static const String termsAndPrivacy = 'بتسجيل الدخول أنت توافق على الشروط والأحكام وسياسة الخصوصية';
  static const String termsAgreePrefix = 'بتسجيل الدخول أنت توافق على ';
  static const String termsOfService = 'الشروط والأحكام';
  static const String andSeparator = ' و ';
  static const String privacyPolicy = 'سياسة الخصوصية';

  static const String loginWithNewPassword = 'يمكنك الآن تسجيل الدخول بكلمة المرور الجديدة';
  static const String errorFieldRequired = 'جميع الحقول مطلوبة';
  static const String invalidEmail = 'البريد الإلكتروني غير صحيح';
  static const String passwordTooShort = 'كلمة المرور قصيرة جداً (6 أحرف على الأقل)';
  
  // Others
  static const String continueAsGuest = 'المتابعة كضيف';

  // === Sign Up Screen ===
  static const String signUpTitle = 'إنشاء حساب';
  static const String welcomeBack = 'أهلاً بعودتك';
  static const String phoneLabel = 'الهاتف';
  static const String phonePlaceholder = '5123 4567';
  static const String phoneRequired = 'رقم الهاتف مطلوب';
  static const String sendCode = 'أرسل الكود';
  static const String signUpOtpMessage =
      'سنتصل بك أو سنرسل لك رمز التحقق لإكمال تسجيل الدخول';
  static const String socialSignUpButtons = 'أو باستخدام';
  static const String alreadyHaveAccount = 'لديك حساب بالفعل؟ ';
  static const String signIn = 'تسجيل الدخول';
  static const String signUpWithGoogle = 'تسجيل عبر Google';
  static const String signUpWithApple = 'تسجيل عبر Apple';
  static const String defaultCountryCode = '+974';
  static const String countryCodeQatar = '+974';
  static const String flagQatar = '🇶🇦';

  // === OTP Verification Screen ===
  static const String otpVerificationTitle = 'التحقق من الرمز';
  static const String otpVerificationSubtitle =
      'أدخل رمز التحقق المكون من 6 أرقام المرسل إلى';
  static const String otpCodeHint = 'أدخل الرمز';
  static const String confirm = 'تأكيد';
  static const String otpVerifiedSuccess = 'تم التحقق من الرمز بنجاح';
  static const String resendCodePromptAlt = 'لم تتلقى الكود بعد ؟ ';
  static const String resendCodeLink = 'إعادة إرسال الكود';
  static const String otpTimer = '0:59';

  // === Complete Profile Screen ===
  static const String completeProfileTitle = 'أكمل ملفك الشخصي';
  static const String completeProfileSubtitle =
      'أضف بعض المعلومات لتخصيص تجربتك داخل التطبيق';
  static const String nameLabel = 'الاسم';
  static const String namePlaceholder = 'أدخل اسمك بالكامل';
  static const String nameRequired = 'الاسم مطلوب';
  static const String nameInvalid = 'الاسم قصير جداً (حد أدنى حرفين)';
  static const String genderLabel = 'النوع';
  static const String genderPlaceholder = 'اختر النوع';
  static const String genderRequired = 'النوع مطلوب';
  static const String genderMale = 'ذكر';
  static const String genderFemale = 'أنثى';
  static const String addressLabel = 'العنوان (اختياري)';
  static const String bioLabel = 'نبذة عنك (اختياري)';
  static const String bioHint = 'اكتب نبذة عن نفسك';
  static const String genderSelectError = 'الرجاء اختيار النوع';
  static const String completeRegistration = 'إكمال التسجيل';
  static const String profileCompletionSuccess = 'تم إكمال الملف الشخصي بنجاح';
  static const String profileCompletionError = 'فشل إكمال الملف الشخصي';

  // === Forgot Password Screen ===
  static const String forgotPasswordTitle = 'إعادة تعيين كلمة المرور';
  static const String forgotPasswordDescription =
      'من فضلك أدخل بريدك الإلكتروني لإعادة تعيين كلمة السر';
  static const String sendResetCode = 'أرسل رمز التحقق';

  // === Check Your Email Screen ===
  static const String checkEmailTitle = 'تحقق من بريدك الإلكتروني';
  static const String checkEmailDescription =
      'تم إرسال رابط إعادة تعيين إلى البريد الإلكتروني الخاص بك';
  static const String backToSignIn = 'العودة للدخول';

  // === Verify Reset Code Screen ===
  static const String verifyResetCodeTitle = 'تحقق من الرمز';
  static const String verifyResetCodeDescription =
      'أدخل الرمز المكون من 6 أرقام المرسل إلى بريدك الإلكتروني';
  static const String resetCodeError = 'الرمز غير صحيح أو منتهي الصلاحية';
  static const String resetCodeExpired = 'انتهت صلاحية الرمز';

  // === Set New Password Screen ===
  static const String setNewPasswordTitle = 'تعيين كلمة مرور جديدة';
  static const String setNewPasswordDescription =
      'أنشئ كلمة مرور جديدة، وتأكد من أنها مختلفة عن كلمة المرور السابقة';
  static const String newPasswordLabel = 'كلمة المرور الجديدة';
  static const String newPasswordPlaceholder = 'أدخل كلمة المرور الجديدة';
  static const String confirmPasswordLabel = 'تأكيد كلمة المرور';
  static const String confirmPasswordPlaceholder = 'أعد إدخال كلمة المرور';
  static const String passwordMismatch = 'كلمتا المرور غير متطابقتين';
  static const String updatePassword = 'تحديث كلمة المرور';
  static const String passwordUpdated = 'تم تحديث كلمة المرور بنجاح';

  // === Success/Generic Messages ===
  static const String errorNetwork = 'خطأ في الاتصال بالإنترنت';
  static const String errorUserNotFound = 'المستخدم غير مسجل';
  static const String errorAccountDisabled = 'الحساب معطل';
  static const String errorTooManyAttempts = 'محاولات كثيرة جداً، حاول لاحقاً';

  // === Success Messages ===
  static const String successSignIn = 'تم تسجيل الدخول بنجاح';
  static const String successSignUp = 'تم التسجيل بنجاح';
  static const String successOtpSent = 'تم إرسال الرمز بنجاح';
  static const String successResetCodeSent = 'تم إرسال رمز التحقق إلى بريدك الإلكتروني';
  static const String successPasswordReset = 'تم إعادة تعيين كلمة المرور بنجاح';
  static const String successProfileComplete = 'تم إكمال الملف الشخصي بنجاح';

  // === Buttons ===
  static const String continueBtn = 'متابعة';
  static const String nextBtn = 'التالي';
  static const String backBtn = 'رجوع';
  static const String saveBtn = 'حفظ';
  static const String cancelBtn = 'إلغاء';
  static const String skipBtn = 'تخطي';

  // === Validation Messages ===
  // Already defined above in Sign In/Up sections

  // === Error Messages for Exceptions ===
  // Network errors
  static const String errorNetworkNoInternet = 'لا يوجد اتصال بالإنترنت. تحقق من الاتصال وحاول مجددًا.';
  static const String errorNetworkTimeout = 'انتهت مهلة الاتصال. يرجى المحاولة مجددًا.';
  static const String errorNetworkUnreachable = 'الخادم غير متاح حالياً. يرجى المحاولة لاحقًا.';
  
  // Server errors
  static const String errorServer = 'حدث خطأ في الخادم. يرجى المحاولة لاحقًا.';
  static const String errorBadRequest = 'بيانات غير صحيحة. يرجى التحقق والمحاولة مجددًا.';
  static const String errorServerGeneric = 'خطأ في الخادم. حاول لاحقاً';

  // Authentication errors
  static const String errorInvalidCredentials = 'بريد إلكتروني أو كلمة مرور غير صحيحة.';
  static const String errorAccountNotFound = 'الحساب غير موجود. يرجى التسجيل أولاً.';
  static const String errorUnauthorized = 'غير مصرح. يرجى تسجيل الدخول مجددًا.';
  static const String errorTokenExpired = 'انتهت صلاحية الجلسة. يرجى تسجيل الدخول مجددًا.';
  static const String errorAccountLocked = 'الحساب مقفول. الرجاء المحاولة لاحقًا.';
  static const String errorAccountLockedWithTime = 'الحساب مقفول. حاول مجددًا بعد {minutes} دقيقة.';
  static const String errorForbidden = 'ليس لديك صلاحية للوصول إلى هذا المورد.';
  
  // OTP & Reset Code errors
  static const String invalidOtp = 'الرمز غير صحيح.';
  static const String otpExpired = 'انتهت صلاحية كود التحقق. يرجى طلب كود جديد.';
  static const String smsSendingFailed = 'فشل إرسال رسالة التحقق. يرجى المحاولة مجددًا.';
  static const String emailAlreadyExists = 'هذا البريد الإلكتروني مسجل بالفعل.';
  static const String phoneAlreadyRegistered = 'هذا الرقم مسجل بالفعل.';
  static const String localStorageError = 'فشل الوصول إلى البيانات المحلية.';
  static const String unknownError = 'حدث خطأ غير متوقع. يرجى المحاولة لاحقًا.';

  // OTP/SMS errors
  static const String errorInvalidOtp = 'كود التحقق غير صحيح.';
  static const String errorInvalidOtpWithAttempts = 'كود التحقق غير صحيح. لديك {attempts} محاولات متبقية.';
  static const String errorOtpExpired = 'انتهت صلاحية كود التحقق. يرجى طلب كود جديد.';
  static const String errorSmsSendingFailed = 'فشل إرسال رسالة التحقق. يرجى المحاولة مجددًا.';

  // Validation errors
  static const String errorValidationGeneric = 'حدث خطأ في التحقق من البيانات.';
  static const String errorEmailAlreadyExists = 'هذا البريد الإلكتروني مسجل بالفعل.';
  static const String errorPhoneAlreadyExists = 'هذا الرقم مسجل بالفعل.';

  // Storage errors
  static const String errorStorageRead = 'فشل قراءة البيانات من التخزين المحلي.';
  static const String errorStorageWrite = 'فشل حفظ البيانات في التخزين المحلي.';
  static const String errorStorageCorrupted = 'بيانات تالفة في التخزين المحلي.';

  // Generic errors
  static const String errorUnknown = 'حدث خطأ غير متوقع. يرجى المحاولة لاحقًا.';
}
