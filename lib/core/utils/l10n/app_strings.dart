import '../helpers/cache_helper.dart';

class AppStrings {
  // Private constructor to prevent instantiation
  AppStrings._();

  static bool get _isArabic {
    try {
      final saved = CacheHelper.getData(key: 'language');
      if (saved == 'en') return false;
      return true; // Default to Arabic if not set
    } catch (_) {
      return true; // Fallback
    }
  }

  static bool get isArabic => _isArabic;

  static void syncLocale(String language) {
    CacheHelper.saveData(key: 'language', value: language);
  }

  // --- General & Shared ---
  static String get confirm => _isArabic ? 'تأكيد' : 'Confirm';
  static String get sendCode => _isArabic ? 'أرسل الكود' : 'Send Code';
  static String get emailLabel => _isArabic ? 'البريد الإلكتروني' : 'Email Address';
  static String get emailPlaceholder => _isArabic ? 'أدخل البريد الإلكتروني' : 'Enter email address';
  static String get passwordLabel => _isArabic ? 'كلمة المرور' : 'Password';
  static String get passwordPlaceholder => _isArabic ? 'أدخل كلمة المرور' : 'Enter password';
  static String get confirmPasswordLabel => _isArabic ? 'تأكيد كلمة المرور' : 'Confirm Password';
  static String get confirmPasswordPlaceholder => _isArabic ? 'أعد إدخال كلمة المرور' : 'Re-enter password';
  static String get login => _isArabic ? 'تسجيل الدخول' : 'Login';
  static String get termsAndPrivacy => _isArabic 
      ? 'بتسجيل الدخول أنت توافق على الشروط والأحكام وسياسة الخصوصية'
      : 'By logging in, you agree to our Terms & Conditions and Privacy Policy';
  static String get orUsing => _isArabic ? 'أو باستخدام' : 'Or using';
  static String get viewAll => _isArabic ? 'عرض الكل' : 'View All';
  static String get bookNow => _isArabic ? 'احجز الآن' : 'Book Now';

  // --- Sign Up / Login Screen ---
  static String get welcomeBack => _isArabic ? 'أهلاً بعودتك' : 'Welcome Back';
  static String get welcomeBackAlt => _isArabic ? 'مرحباً بعودتك' : 'Welcome Back';
  static String get verificationMethodInfo => _isArabic 
      ? 'سنتصل بك أو سنرسل لك رمز التحقق لإكمال تسجيل الدخول'
      : 'We will call or send a verification code to complete login';
  static String get signUpWithGoogle => _isArabic ? 'تسجيل عبر Google' : 'Sign in with Google';
  static String get signUpWithApple => _isArabic ? 'تسجيل عبر Apple' : 'Sign in with Apple';
  static String get continueAsGuest => _isArabic ? 'المتابعة كضيف' : 'Continue as Guest';
  static String get alreadyHaveAccount => _isArabic ? 'لديك حساب بالفعل؟ ' : 'Already have an account? ';
  static String get dontHaveAccount => _isArabic ? 'ليس لديك حساب ؟ ' : 'Don\'t have an account? ';
  static String get createAccount => _isArabic ? 'إنشاء حساب' : 'Create Account';
  static String get forgotPassword => _isArabic ? 'نسيت كلمة المرور؟' : 'Forgot Password?';
  static String get rememberMe => _isArabic ? 'تذكرني' : 'Remember Me';
  static String get phonePlaceholder => _isArabic ? '5123 4567' : '5123 4567';
  static String get defaultCountryCode => _isArabic ? '+974' : '+974';

  // --- OTP Verification Screen ---
  static String get confirmCode => _isArabic ? 'تأكيد الرمز' : 'Confirm Code';
  static String get enterVerificationCode => _isArabic 
      ? 'أدخل رمز التحقق المكون من 6 أرقام المرسل إلى'
      : 'Enter the 6-digit verification code sent to';
  static String get resendCodePrompt => _isArabic ? 'لم تتلقى الكود بعد؟ ' : 'Didn\'t receive code? ';
  static String get resendCodePromptAlt => _isArabic ? 'لم تتلقى الكود بعد ؟ ' : 'Didn\'t receive code? ';
  static String get resendCodeLink => _isArabic ? 'إعادة إرسال الكود' : 'Resend Code';
  static String get defaultOtpTimer => _isArabic ? '0:59' : '0:59';

  // --- Complete Profile Screen ---
  static String get completeProfile => _isArabic ? 'أكمل ملفك الشخصي' : 'Complete Your Profile';
  static String get completeProfileSubtitle => _isArabic 
      ? 'أضف بعض المعلومات لتخصيص تجربتك داخل التطبيق'
      : 'Add some information to customize your experience in the app';
  static String get nameLabel => _isArabic ? 'الاسم' : 'Full Name';
  static String get namePlaceholder => _isArabic ? 'أدخل اسمك بالكامل' : 'Enter your full name';
  static String get completeRegistration => _isArabic ? 'إكمال التسجيل' : 'Complete Registration';

  // --- Reset Password & Verification ---
  static String get resetPassword => _isArabic ? 'إعادة تعيين كلمة المرور' : 'Reset Password';
  static String get resetPasswordDescription => _isArabic 
      ? 'من فضلك أدخل بريدك الإلكتروني لإعادة تعيين كلمة السر'
      : 'Please enter your email to reset your password';
  static String get checkEmail => _isArabic ? 'تحقق من بريدك الإلكتروني' : 'Check your email';
  static String get emailSentDescription => _isArabic 
      ? 'تم إرسال رابط إعادة تعيين إلى ahmed...‌@gmail.com أدخل الرمز المتكون من 4 أرقام لتأكيد البريد الإلكتروني'
      : 'A reset link has been sent to ahmed...‌@gmail.com. Enter the 4-digit code to verify your email';

  // --- Set New Password Screen ---
  static String get setNewPassword => _isArabic ? 'تعيين كلمة مرور جديدة' : 'Set New Password';
  static String get setNewPasswordDescription => _isArabic 
      ? 'أنشئ كلمة مرور جديدة، وتأكد من أنها مختلفة عن كلمة المرور السابقة .'
      : 'Create a new password. Make sure it is different from your previous password.';
  static String get passwordChangedSuccessfully => _isArabic ? 'تم تغيير كلمة المرور بنجاح' : 'Password changed successfully';
  static String get loginWithNewPassword => _isArabic ? 'يمكنك الآن تسجيل الدخول بكلمة المرور الجديدة' : 'You can now log in with your new password';

  // --- Location & Map Screens ---
  static String get setYourLocation => _isArabic ? 'حدد موقعك' : 'Set Your Location';
  static String get locationPermissionDescription => _isArabic 
      ? 'نحتاج إلى موقعك لعرض الخدمات المتاحة بالقرب منك'
      : 'We need your location to show available services near you';
  static String get setCurrentLocation => _isArabic ? 'تحديد الموقع الحالي' : 'Use Current Location';
  static String get chooseLocationManually => _isArabic ? 'اختيار الموقع يدويا' : 'Choose Location Manually';
  static String get searchLocationPlaceholder => _isArabic ? 'ابحث عن منطقة أو عنوان...' : 'Search for area or address...';
  static String get confirmLocation => _isArabic ? 'تأكيد الموقع' : 'Confirm Location';
  
  // --- Home Screen ---
  static String get currentLocation => _isArabic ? 'الموقع الحالي' : 'Current Location';
  static String get searchServiceOrProblem => _isArabic ? 'ابحث عن خدمة أو مشكلة...' : 'Search for service or problem...';
  static String get deepCleaning => _isArabic ? 'تنظيف عميق' : 'Deep Cleaning';
  static String get houseCleaning => _isArabic ? 'تنظيف منزل' : 'House Cleaning';
  static String get pestControl => _isArabic ? 'مكافحة حشرات' : 'Pest Control';
  static String get corporateServices => _isArabic ? 'خدمات المؤسسات' : 'Corporate Services';
  static String get mostRequested => _isArabic ? 'الأكثر طلباً' : 'Most Requested';
  static String get navHome => _isArabic ? 'الرئيسية' : 'Home';
  static String get navBookings => _isArabic ? 'حجوزاتي' : 'Bookings';
  static String get navAccount => _isArabic ? 'حسابي' : 'My Account';

  // --- Search Screens ---
  static String get recentSearches => _isArabic ? 'عمليات البحث الأخيرة' : 'Recent Searches';
  static String get clearAll => _isArabic ? 'مسح الكل' : 'Clear All';
  static String get popularServices => _isArabic ? 'خدمات شائعة' : 'Popular Services';
  static String get youMightBeLookingFor => _isArabic ? 'ربما تبحث عن' : 'You might be looking for';
  static String get categories => _isArabic ? 'تصنيفات' : 'Categories';
  static String get noResultsFound => _isArabic ? 'لم يتم العثور على نتائج' : 'No results found';
  static String get browseServices => _isArabic ? 'تصفح الخدمات' : 'Browse Services';
  static String get tryOtherWords => _isArabic ? 'جرب كلمات أخرى' : 'Try other keywords';

  // --- Addresses Bottom Sheet ---
  static String get chooseYourAddress => _isArabic ? 'اختر عنوانك' : 'Choose Your Address';
  static String get addNewAddress => _isArabic ? '+ إضافة عنوان جديد' : '+ Add New Address';
  static String get addressHome => _isArabic ? 'المنزل' : 'Home';
  static String get addressWork => _isArabic ? 'العمل' : 'Work';
  static String get streetNameOrNumber => _isArabic ? 'اسم الشارع/الرقم' : 'Street Name/Number';
  static String get buildingNumber => _isArabic ? 'رقم المبنى' : 'Building Number';
  static String get floorNumber => _isArabic ? 'الدور' : 'Floor';
  static String get officeOrFloorNumber => _isArabic ? 'رقم المكتب / الدور' : 'Office/Floor Number';
  static String get additionalNotes => _isArabic ? 'ملاحظات إضافية' : 'Additional Notes';
  static String get editAddressHint => _isArabic 
      ? 'لتعديل عنوان، اذهب إلى حسابي -> العناوين .'
      : 'To edit an address, go to My Account -> Addresses.';

  // --- Notifications Screens ---
  static String get notifications => _isArabic ? 'الاشعارات' : 'Notifications';
  static String get noNewNotifications => _isArabic ? 'لا توجد تنبيهات جديدة' : 'No new notifications';
  static String get newNotifications => _isArabic ? 'جديد' : 'New';
  static String get today => _isArabic ? 'اليوم' : 'Today';
  static String get earlier => _isArabic ? 'سابقا' : 'Earlier';
  static String get serviceCompleted => _isArabic ? 'اكتملت الخدمة' : 'Service Completed';
  static String get serviceCompletedDesc => _isArabic 
      ? 'نأمل أن تكون قد استمتعت بخدمة تنظيف السجاد، رأيك يهمنا، يرجى تقييم الفريق.'
      : 'We hope you enjoyed the carpet cleaning service. Your feedback matters, please rate the team.';
  static String get serviceStarted => _isArabic ? 'بدء الخدمة' : 'Service Started';
  static String get serviceStartedDesc => _isArabic 
      ? 'يعمل فريقنا الآن على تنفيذ خدمتك المطلوبة بأعلى جودة.'
      : 'Our team is now executing your requested service with the highest quality.';
  static String get serviceReminder => _isArabic ? 'تذكير بموعد الخدمة' : 'Service Reminder';
  static String get serviceReminderDesc => _isArabic ? 'موعد خدمتك اليوم الساعة 5:00 مساءً' : 'Your service appointment is today at 5:00 PM';
  static String get bookingConfirmed => _isArabic ? 'تم تأكيد حجزك' : 'Booking Confirmed';
  static String get bookingConfirmedDesc => _isArabic 
      ? 'تم تأكيد موعد الخدمة يوم الثلاثاء الساعة 4:00 مساءً.'
      : 'Your service appointment has been confirmed for Tuesday at 4:00 PM.';
  static String get appointmentModified => _isArabic ? 'تم تعديل موعد الخدمة' : 'Appointment Modified';
  static String get appointmentModifiedDesc => _isArabic 
      ? 'تم تحديث موعد الحجز إلى الساعة 6:00 مساءً بناءً على طلبك.'
      : 'Your appointment time has been updated to 6:00 PM based on your request.';
  static String get rebookPrompt => _isArabic ? 'هل ترغب بإعادة الحجز؟' : 'Would you like to rebook?';
  static String get rebookPromptDesc => _isArabic ? 'احجز نفس الخدمة مرة أخرى خلال ثواني.' : 'Rebook the same service in seconds.';
  static String get specialDiscount => _isArabic ? 'خصم خاص لفترة محدودة' : 'Special limited-time discount';
  static String get specialDiscountDesc => _isArabic 
      ? 'استمتع بخصم 20٪ على خدمات تنظيف الكنب كود الخصم clean20.'
      : 'Enjoy 20% off sofa cleaning services. Promo code: clean20.';

  // --- Service Details Screen ---
  static String get reviewsCount => _isArabic ? 'تقييم' : 'Reviews';
  static String get discount => _isArabic ? 'خصم' : 'Discount';
  static String get code => _isArabic ? 'كود' : 'Code';
  static String get applyCode => _isArabic ? 'تطبيق الكود' : 'Apply Code';
  static String get viewServiceDetails => _isArabic ? 'عرض تفاصيل الخدمة' : 'View Service Details';
  static String get serviceIncludes => _isArabic ? 'تشمل الخدمة:' : 'Service Includes:';
  static String get notesBeforeBooking => _isArabic ? 'ملاحظات قبل الحجز:' : 'Notes Before Booking:';
  static String get currency => _isArabic ? 'ر.ق' : 'QAR';
  static String get add => _isArabic ? 'أضف +' : 'Add +';

  // --- Booking Flow: Shared ---
  static String get step => _isArabic ? 'الخطوة' : 'Step';
  static String get ofText => _isArabic ? 'من' : 'of';
  static String get next => _isArabic ? 'التالي' : 'Next';
  static String get currentTotal => _isArabic ? 'المجموع الحالي' : 'Current Total';

  // --- Booking Flow: Step 2 (Add-ons) ---
  static String get addonsTitle => _isArabic ? 'الاضافات' : 'Add-ons';
  static String get notSureFreeInspection => _isArabic ? 'لست متأكداً احصل على معاينة مجانية' : 'Not sure? Get a free inspection';
  static String get inspectionDescription => _isArabic 
      ? 'فريقنا جاهز لمساعدتك في اختيار الخدمة المناسبة بسهولة'
      : 'Our team is ready to help you choose the right service easily';
  static String get requestInspection => _isArabic ? 'اطلب معاينة' : 'Request Inspection';

  // --- Booking Flow: Step 3 (Date & Time) ---
  static String get dateAndTimeTitle => _isArabic ? 'التاريخ والوقت' : 'Date & Time';
  static String get chooseDay => _isArabic ? 'اختر اليوم' : 'Choose Day';
  static String get chooseTime => _isArabic ? 'اختر وقت' : 'Choose Time';
  static String get cancellationPolicy => _isArabic 
      ? 'يمكنك إلغاء الحجز أو تعديله مجاناً قبل 5 ساعة من الموعد المقرر. في حال الإلغاء خلال أقل من 5 ساعة، سيتم تطبيق رسوم إلغاء بنسبة 25٪. عرض التفاصيل'
      : 'You can cancel or modify your booking for free up to 5 hours before the scheduled time. Cancellations under 5 hours will incur a 25% fee. View Details';
  static String get saturday => _isArabic ? 'السبت' : 'Saturday';
  static String get sunday => _isArabic ? 'الاحد' : 'Sunday';
  static String get monday => _isArabic ? 'الاثنين' : 'Monday';
  static String get tuesday => _isArabic ? 'الثلاثاء' : 'Tuesday';
  static String get wednesday => _isArabic ? 'الاربعاء' : 'Wednesday';
  static String get thursday => _isArabic ? 'الخميس' : 'Thursday';
  static String get friday => _isArabic ? 'الجمعة' : 'Friday';

  // --- Booking Flow: Step 4 (Address) ---
  static String get addressTitle => _isArabic ? 'العنوان' : 'Address';
  static String get savedAddresses => _isArabic ? 'عناوين المحفوظة' : 'Saved Addresses';
  static String get specialInstructions => _isArabic ? 'ملاحظات او تعليمات خاصة (اختياري)' : 'Special notes or instructions (Optional)';
  static String get specialInstructionsHint => _isArabic ? 'مثال: اتصل امام المسجد..' : 'e.g. Call when in front of the mosque..';

  // --- Booking Flow: Step 5 (Payment) ---
  static String get paymentTitle => _isArabic ? 'الدفع' : 'Payment';
  static String get paymentMethod => _isArabic ? 'طريقة الدفع' : 'Payment Method';
  static String get payAfterService => _isArabic ? 'الدفع عند الخدمة' : 'Pay After Service';
  static String get payAfterServiceDesc => _isArabic ? 'ادفع نقداً بعد اتمام الخدمة' : 'Pay in cash after service completion';
  static String get discountCode => _isArabic ? 'كود الخصم' : 'Discount Code';
  static String get enterDiscountCode => _isArabic ? 'ادخل كود الخصم' : 'Enter discount code';
  static String get securePaymentNote => _isArabic 
      ? 'جميع المدفوعات مشفرة لضمان أعلى مستويات الأمان والخصوصية.'
      : 'All payments are encrypted to ensure the highest security and privacy.';

  static const String savedCards = 'البطاقات المحفوظة';
  static const String defaultCard = 'افتراضي';
  static const String addNewCard = '+ اضافة بطاقه جديد';

  // --- Booking Flow: Order Summary ---
  static String get bookingSummary => _isArabic ? 'ملخص الحجز' : 'Booking Summary';
  static String get paymentSummary => _isArabic ? 'ملخص الدفع' : 'Payment Summary';
  static String get totalIncludingVat => _isArabic ? 'المجموع (شامل الضريبة المضافة)' : 'Total (incl. VAT)';
  static String get totalLabel => _isArabic ? 'المجموع' : 'Total';

  // --- House Cleaning Flow Config ---
  static String get houseCleaningTitle => _isArabic ? 'تنظيف المنزل' : 'House Cleaning';
  static String get howManyHours => _isArabic ? 'كم ساعة تريد عاملة / عاملة التنظيف؟' : 'How many hours of cleaning do you need?';
  static String get oneHour => _isArabic ? 'ساعة' : '1 Hour';
  static String get twoHours => _isArabic ? 'ساعتين' : '2 Hours';
  static String get hours3 => _isArabic ? '3 ساعات' : '3 Hours';
  static String get hours4 => _isArabic ? '4 ساعات' : '4 Hours';
  static String get hours5 => _isArabic ? '5 ساعات' : '5 Hours';
  static String get howManyWorkers => _isArabic ? 'كم عدد العاملات /العمال؟' : 'How many cleaners?';
  static String get worker => _isArabic ? 'عامل' : 'cleaner';
  static String get placeSize => _isArabic ? 'حجم المكان ؟' : 'Size of place?';
  static String get smallApartment => _isArabic ? 'شقة صغيرة' : 'Small Apartment';
  static String get mediumApartment => _isArabic ? 'شقة متوسطة' : 'Medium Apartment';
  static String get largeApartment => _isArabic ? 'شقة كبيرة' : 'Large Apartment';
  static String get villa => _isArabic ? 'فيلا' : 'Villa';
  static String get teamPreference => _isArabic ? 'تفضيل الفريق؟' : 'Team Preference?';
  static String get femaleTeam => _isArabic ? 'نسائي' : 'Female Team';
  static String get maleTeam => _isArabic ? 'رجالي' : 'Male Team';
  static String get noPreference => _isArabic ? 'لا يهم' : 'No Preference';
  
  // --- Service Frequency ---
  static String get serviceFrequency => _isArabic ? 'تكرار الخدمة' : 'Service Frequency';
  static String get once => _isArabic ? 'مرة واحدة' : 'Once';
  static String get weekly => _isArabic ? 'أسبوعيا' : 'Weekly';
  static String get monthly => _isArabic ? 'شهريا' : 'Monthly';
  static String get discountUpTo10 => _isArabic ? 'خصم يصل الى 10%' : 'Discount up to 10%';
  static String get discountUpTo20 => _isArabic ? 'خصم يصل الى 20%' : 'Discount up to 20%';

  // --- Order Tracking ---
  static String get trackOrder => _isArabic ? 'تتبع الطلب' : 'Track Order';
  static String get onTheWay => _isArabic ? 'في الطريق' : 'On the Way';
  static String get eta5Mins => _isArabic ? 'الوصول المتوقع خلال 5 دقائق' : 'ETA: 5 Minutes';
  static String get serviceStatus => _isArabic ? 'حالة الخدمة' : 'Service Status';
  static String get bookingConfirmedStatus => _isArabic ? 'تم تأكيد الحجز' : 'Booking Confirmed';
  static String get teamOnTheWay => _isArabic ? 'الفريق في الطريق إليك' : 'Team is on the way';
  static String get serviceInProgress => _isArabic ? 'الخدمة قيد التنفيذ' : 'Service in progress';
  static String get serviceCompletedStatus => _isArabic ? 'تم الانتهاء' : 'Service completed';
  static String get teamLeader => _isArabic ? 'قائد الفريق' : 'Team Leader';

  // --- Service Completed ---
  static String get serviceCompletedScreenTitle => _isArabic ? 'اكتملت الخدمة' : 'Service Completed';
  static String get thankYouForChoosingUs => _isArabic ? 'شكرا لاختيارك لنا' : 'Thank you for choosing us';
  static String get serviceExecutedSuccessfully => _isArabic 
      ? 'تم تنفيذ خدمة التنظيف العميق لمنزلك بنجاح وبأعلى معايير الجودة الفندقية.'
      : 'Deep cleaning service has been executed successfully with hospitality standards.';
  static String get workSummary => _isArabic ? 'ملخص العمل المنجز' : 'Work Summary';
  static String get serviceType => _isArabic ? 'نوع الخدمة' : 'Service Type';
  static String get timeTaken => _isArabic ? 'الوقت المستغرق' : 'Time Taken';
  static String get minutes45 => _isArabic ? '45 دقيقة' : '45 Minutes';
  static String get roomsCompleted => _isArabic ? 'تم إنجاز 4 غرف' : '4 Rooms Completed';
  static String get roomsCompletedDesc => _isArabic 
      ? 'شمل الصالة، المطبخ، وغرف النوم مع التعقيم الكامل.'
      : 'Including living room, kitchen, and bedrooms with full sanitization.';
  static String get rebook => _isArabic ? 'إعادة الحجز' : 'Rebook';
  static String get rateExperience => _isArabic ? 'قيم تجربتك' : 'Rate Your Experience';

  // --- Rating ---
  static String get serviceRating => _isArabic ? 'تقييم الخدمة' : 'Service Rating';
  static String get teamRating => _isArabic ? 'تقييم الفريق' : 'Team Rating';
  static String get teamRatingQuestion => _isArabic 
      ? 'كيف كانت تجربتك مع فريق "ابراهيم محمد" اليوم؟'
      : 'How was your experience with "Ibrahim Mohamed" team today?';
  static String get addYourNotesHere => _isArabic ? 'أضف ملاحظاتك هنا...' : 'Add your comments here...';
  static String get levelOfServiceRatingQuestion => _isArabic 
      ? 'كيف كانت تجربتك مع مستوى الخدمة اليوم؟'
      : 'How was your experience with the service level today?';
  static String get submitRating => _isArabic ? 'إرسال التقييم' : 'Submit Rating';

  // --- Popups ---
  static String get thankYouForRating => _isArabic ? 'شكرا لتقييمك' : 'Thank you for rating';
  static String get ratingHelpsImprove => _isArabic ? 'رأيك يساعدنا على تحسين الخدمة' : 'Your feedback helps us improve the service';
  static String get backToHome => _isArabic ? 'العودة للرئيسية' : 'Back to Home';
  static String get noAppointmentsAvailable => _isArabic ? 'لا تتوفر مواعيد' : 'No appointments available';
  static String get noAppointmentsDesc => _isArabic 
      ? 'عذراً، جميع المواعيد محجوزة لليوم المختار، إليك بعض الاقتراحات البديلة:'
      : 'Sorry, all appointments are fully booked for the selected day. Here are some alternative options:';
  static String get viewAllAppointments => _isArabic ? 'عرض جميع المواعيد' : 'View all appointments';

  // --- Payment Result Popups ---
  static String get bookingConfirmedSuccess => _isArabic ? 'تم تأكيد حجزك بنجاح !' : 'Booking Confirmed Successfully!';
  static String get bookingConfirmedPopupDesc => _isArabic 
      ? 'تم تأكيد حجزك وسيتم تذكيرك قبل موعد الزيارة بساعة'
      : 'Your booking has been confirmed and we will remind you an hour before the visit';
  static String get bookingNumber => _isArabic ? 'رقم الحجز' : 'Booking Number';
  static String get copy => _isArabic ? 'نسخ' : 'Copy';
  static String get share => _isArabic ? 'مشاركة' : 'Share';
  static String get trackBooking => _isArabic ? 'تتبع الحجز' : 'Track Booking';
  static String get paymentFailed => _isArabic ? 'فشل الدفع' : 'Payment Failed';
  static String get paymentFailedDesc => _isArabic 
      ? 'نعتذر، لم نتمكن من معالجة عملية الدفع الخاصة بك، يرجى التحقق من بيانات البطاقة أو المحاولة مرة أخرى.'
      : 'Sorry, we could not process your payment. Please check your card details or try again.';
  static String get retry => _isArabic ? 'اعادة المحاولة' : 'Retry';
  static String get changePaymentMethod => _isArabic ? 'تغيير طريقه الدفع' : 'Change Payment Method';

  // --- Error Messages ---
  static String get errorIncorrectPassword => _isArabic ? 'كلمة مرور غير صحيحة' : 'Incorrect password';
  static String get errorPasswordsDoNotMatch => _isArabic ? 'كلمتا المرور غير متطابقتين' : 'Passwords do not match';
  static String get errorOutOfZone => _isArabic ? 'عذراً لا نقدم خدمة في هذه المنطقة' : 'Sorry, we do not serve this area';
  static String get errorFieldRequired => _isArabic ? 'هذا الحقل مطلوب' : 'This field is required';
  static String get errorInvalidEmail => _isArabic ? 'البريد الإلكتروني غير صالح' : 'Invalid email address';

  // --- Additional missing strings ---
  static String get passwordsDoNotMatch => _isArabic ? 'كلمتا المرور غير متطابقتين' : 'Passwords do not match';
  static String get passwordsMatch => _isArabic ? 'كلمتا المرور متطابقتين' : 'Passwords match';
  static String get phoneRequired => _isArabic ? 'رقم الهاتف مطلوب' : 'Phone number is required';
  static String get signUpOtpMessage => _isArabic ? 'تم إرسال رمز التحقق إلى هاتفك' : 'Verification code sent to your phone';
  
  // --- OTP Screen ---
  static String get otpVerificationTitle => _isArabic ? 'تأكيد الرمز' : 'Confirm Code';
  static String get otpVerificationSubtitle => _isArabic 
      ? 'أدخل رمز التحقق المكون من 6 أرقام المرسل إلى'
      : 'Enter the 6-digit verification code sent to';
  static String get otpVerifiedSuccess => _isArabic ? 'تم تأكيد الرمز بنجاح!' : 'Code verified successfully!';
  static String get otpVerificationError => _isArabic ? 'الرمز غير صحيح' : 'Invalid code';
  
  // --- Verify Reset Code Screen ---
  static String get resetPasswordTitle => _isArabic ? 'إعادة تعيين كلمة المرور' : 'Reset Password';
  static String get resetPasswordSubtitle => _isArabic 
      ? 'من فضلك أدخل بريدك الإلكتروني لإعادة تعيين كلمة السر'
      : 'Please enter your email to reset your password';
  static String get sendCodeSuccess => _isArabic 
      ? 'تم إرسال رمز التحقق إلى'
      : 'Verification code sent to';
  static String get sendCodeButton => _isArabic ? 'أرسل الكود' : 'Send Code';
  
  // --- Check Your Email Screen ---
  static String get checkEmailTitle => _isArabic ? 'تحقق من بريدك الالكتروني' : 'Check Your Email';
  static String get resetLinkSent => _isArabic ? 'تم إرسال رابط إعادة تعيين إلى' : 'Reset link sent to';
  static String get enter4DigitCode => _isArabic 
      ? 'أدخل الرمز المكون من 4 أرقام المذكور في البريد الإلكتروني'
      : 'Enter the 4-digit code mentioned in the email';
  static String get emailVerifiedSuccess => _isArabic ? 'تم التحقق من بريدك الإلكتروني بنجاح' : 'Email verified successfully';
  
  // --- Onboarding ---
  static String get onboardingSkip => _isArabic ? 'تخطي' : 'Skip';
  static String get onboardingNext => _isArabic ? 'التالي' : 'Next';
  static String get onboardingGetStarted => _isArabic ? 'ابدأ الآن' : 'Get Started';
  static String get onboardingStep1Title => _isArabic 
      ? 'معدات وخامات بمعايير احترافية'
      : 'Professional-Grade Equipment & Supplies';
  static String get onboardingStep1Description => _isArabic 
      ? 'نعتمد على أحدث المعدات والخامات عالية الجودة لضمان نتائج تنظيف احترافية تدوم'
      : 'We rely on the latest high-quality equipment to ensure professional, long-lasting cleaning results';
  static String get onboardingStep2Title => _isArabic 
      ? 'أفضل الكفاءات لخدمة منزلك'
      : 'The Best Professionals for Your Home';
  static String get onboardingStep2Description => _isArabic 
      ? 'خدمات احترافية يقدمها فريق موثوق ومدرب بعناية لضمان الجودة والراحة في كل زيارة'
      : 'Professional services delivered by a trusted, carefully trained team to ensure quality and comfort on every visit';

  static String get appTitle => _isArabic ? 'تطبيق الخدمات المنزلية' : 'Home Service App';
}
