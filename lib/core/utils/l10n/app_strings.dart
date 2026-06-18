/// Centralized static string constants used across the application.
///
/// This file has been reorganized into logical, feature-based sections for
/// easier navigation and maintenance. No string values have been removed.
/// Poorly named constants were renamed to meaningful camelCase names, and
/// duplicate semantic keys were preserved for backward compatibility (marked
/// with comments for future cleanup).
class AppStrings {
  // Private constructor to prevent instantiation
  AppStrings._();

  // ==================================================
  // GENERAL
  // ==================================================
  static const String save = 'حفظ';
  static const String cancelBtn = 'إلغاء';
  static const String okBtn = 'حسناً';
  static const String confirm = 'تأكيد';
  static const String viewAll = 'عرض الكل';
  static const String bookNow = 'احجز الآن';
  static const String goBack = 'رجوع';
  static const String next = 'التالي';
  static const String currency = 'ر.ق';
  static const String code = 'Code';
  static const String copy = 'نسخ';
  static const String share = 'مشاركة';
  static const String retry = 'اعادة المحاولة';
  static const String send = 'ارسال';
  static const String backToHome = 'العودة للرئيسية';
  static const String unknownRoute = 'العنوان غير معروف';

  //  Merge duplicate semantic keys in future cleanup
  // backBtn duplicates goBack ('رجوع')
  //static const String backBtn = 'رجوع';

  // ==================================================
  // AUTHENTICATION
  // ==================================================
  static const String sendCode = 'أرسل الكود';
  static const String emailPlaceholder = 'أدخل البريد الإلكتروني';
  static const String passwordLabel = 'كلمة المرور';
  static const String passwordPlaceholder = 'أدخل كلمة المرور';
  static const String confirmPasswordLabel = 'تأكيد كلمة المرور';
  static const String confirmPasswordPlaceholder = 'أعد إدخال كلمة المرور';
  static const String login = 'تسجيل الدخول';
  static const String termsAndPrivacy =
      'بتسجيل الدخول أنت توافق على الشروط والأحكام وسياسة الخصوصية';
  static const String orUsing = 'أو باستخدام';

  // --- Sign Up / Login Screen ---
  static const String welcomeBack = 'أهلاً بعودتك';

  // Merge duplicate semantic keys in future cleanup
  // welcomeBackAlt duplicates welcomeBack
  static const String welcomeBackAlt = 'مرحباً بعودتك';

  static const String welcomeSignUp = 'أنشئ حساب جديد';
  static const String signUpSubtitle =
      'أدخل رقم هاتفك للتسجيل والحصول على رمز التحقق';
  static const String verificationMethodInfo =
      'سنتصل بك أو سنرسل لك رمز التحقق لإكمال تسجيل الدخول';
  static const String signUpWithGoogle = 'تسجيل عبر Google';
  static const String signUpWithApple = 'تسجيل عبر Apple';
  static const String continueAsGuest = 'المتابعة كضيف';
  static const String alreadyHaveAccount = 'لديك حساب بالفعل؟ ';
  static const String signInAction = 'تسجيل الدخول';
  static const String dontHaveAccount = 'ليس لديك حساب ؟ ';
  static const String createAccount = 'إنشاء حساب';
  static const String forgotPassword = 'نسيت كلمة المرور؟';
  static const String rememberMe = 'تذكرني';
  static const String phonePlaceholder = '5123 4567';
  static const String defaultCountryCode = '+974';

  // --- Auth Errors ---
  static const String errorIncorrectPassword = 'كلمة مرور غير صحيحة';
  static const String errorPasswordsDoNotMatch = 'كلمتا المرور غير متطابقتين';

  // --- Auth Screen (Set New Password) ---
  static const String password = 'كلمة المرور';
  static const String passwordNow = ' كلمة المرور الحالية';
  static const String enterPassword = 'أدخل كلمة المرور';

  //  Merge duplicate semantic keys in future cleanup
  // confirmPassword duplicates confirmPasswordLabel ('تأكيد كلمة المرور')
  static const String confirmPassword = 'تأكيد كلمة المرور';

  //  Merge duplicate semantic keys in future cleanup
  // reEnterPassword duplicates confirmPasswordPlaceholder ('أعد إدخال كلمة المرور')
  static const String reEnterPassword = 'أعد إدخال كلمة المرور';

  // ==================================================
  // OTP VERIFICATION
  // ==================================================
  static const String confirmCode = 'تأكيد الرمز';
  static const String enterVerificationCode =
      'أدخل رمز التحقق المكون من 6 أرقام المرسل إلى';
  static const String resendCodePrompt = 'لم تتلقى الكود بعد؟ ';

  //  Merge duplicate semantic keys in future cleanup
  // resendCodePromptAlt duplicates resendCodePrompt
  static const String resendCodePromptAlt = 'لم تتلقى الكود بعد ؟ ';

  static const String resendCodeLink = 'إعادة إرسال الكود';
  static const String defaultOtpTimer = '0:59';

  // ==================================================
  // COMPLETE PROFILE
  // ==================================================
  static const String completeProfile = 'أكمل ملفك الشخصي';
  static const String completeProfileSubtitle =
      'أضف بعض المعلومات لتخصيص تجربتك داخل التطبيق';
  static const String namePlaceholder = 'أدخل اسمك بالكامل';
  static const String completeRegistration = 'إكمال التسجيل';

  // ==================================================
  // RESET PASSWORD
  // ==================================================
  static const String resetPassword = 'إعادة تعيين كلمة المرور';
  static const String resetPasswordDescription =
      'من فضلك أدخل بريدك الإلكتروني لإعادة تعيين كلمة السر';
  static const String checkEmail = 'تحقق من بريدك الإلكتروني';
  static const String emailSentDescription =
      'تم إرسال رابط إعادة تعيين إلى ahmed...‌@gmail.com أدخل الرمز المتكون من 4 أرقام لتأكيد البريد الإلكتروني';

  // --- Set New Password Screen ---
  static const String setNewPassword = 'تعيين كلمة مرور جديدة';
  static const String setNewPasswordDescription =
      'أنشئ كلمة مرور جديدة، وتأكد من أنها مختلفة عن كلمة المرور السابقة .';
  static const String passwordChangedSuccessfully =
      'تم تغيير كلمة المرور بنجاح';
  static const String loginWithNewPassword =
      'يمكنك الآن تسجيل الدخول بكلمة المرور الجديدة';
  static const String newPassword = 'كلمة المرور الجديدة';

  // Merge duplicate semantic keys in future cleanup
  // createNewPassDescription duplicates setNewPasswordDescription
  static const String createNewPassDescription =
      'يرجى إدخال كلمة مرور جديدة قوية وسهلة التذكر.';

  // Merge duplicate semantic keys in future cleanup
  // editNewPassDescription duplicates setNewPasswordDescription
  // (typo fixed: 'كلمه' -> 'كلمة')
  static const String editNewPassDescription =
      'أنشئ كلمة مرور جديدة، وتأكد من أنها مختلفة عن كلمة المرور السابقة ';

  // ==================================================
  // LOCATION
  // ==================================================
  static const String setYourLocation = 'حدد موقعك';
  static const String locationPermissionDescription =
      'نحتاج إلى موقعك لعرض الخدمات المتاحة بالقرب منك';
  static const String setCurrentLocation = 'تحديد الموقع الحالي';
  static const String chooseLocationManually = 'اختيار الموقع يدويا';
  static const String searchLocationPlaceholder = 'ابحث عن منطقة أو عنوان...';
  static const String confirmLocation = 'تأكيد الموقع';
  static const String errorOutOfZone = 'عذراً لا نقدم خدمة في هذه المنطقة';

  // ==================================================
  // HOME
  // ==================================================
  static const String currentLocation = 'الموقع الحالي';
  static const String searchServiceOrProblem = 'ابحث عن خدمة أو مشكلة...';
  static const String deepCleaning = 'تنظيف عميق';
  static const String houseCleaning = 'تنظيف منزل';
  static const String pestControl = 'مكافحة حشرات';
  static const String corporateServices = 'خدمات المؤسسات';
  static const String mostRequested = 'الأكثر طلباً';
  static const String navHome = 'الرئيسية';
  static const String navBookings = 'حجوزاتي';
  static const String navAccount = 'حسابي';
  static const String specialOfferTitle = 'عروض مخصصة للشركات والمؤسسات';
  static const String serviceAvailable24h = 'خدمة سريعة خلال 24 ساعة';

  // --- Promo Banner ---
  static const String bestCleaningWork = 'أنس أعمال التنظيف بعد العمل';
  static const String hourlyClean = 'تنظيف بالساعة';
  static const String startingPrice = 'تبدأ الأسعار من 100 ريال';

  // ==================================================
  // SEARCH
  // ==================================================
  static const String recentSearches = 'عمليات البحث الأخيرة';
  static const String clearAll = 'مسح الكل';
  static const String popularServices = 'خدمات شائعة';
  static const String youMightBeLookingFor = 'ربما تبحث عن';
  static const String categories = 'تصنيفات';
  static const String noResultsFound = 'لم يتم العثور على نتائج';
  static const String noResultsFoundDescription =
      'لم نتمكن من العثور على أي خدمات تطابق ببحثك عن';
  static const String browseServices = 'تصفح الخدمات';
  static const String tryOtherWords = 'جرب كلمات أخرى';
  static const String insectsInHouse = ' وجود حشرات في المنزل';
  static const String insectsInHouseDis = 'حلول فورية لمكافحة الآفات';

  // ==================================================
  // ADDRESS
  // ==================================================
  static const String chooseYourAddress = 'اختر عنوانك';
  static const String addYourAddress = 'إضافة عنوان جديد';

  //  Merge duplicate semantic keys in future cleanup
  // addNewAddress duplicates addYourAddress / addAddressBtn
  static const String addNewAddress = '+ إضافة عنوان جديد';

  //  Merge duplicate semantic keys in future cleanup
  // addressHome duplicates homeAddress ('المنزل')
  static const String addressHome = 'المنزل';

  //  Merge duplicate semantic keys in future cleanup
  // addressWork duplicates workAddress ('العمل')
  static const String addressWork = 'العمل';

  static const String streetNameOrNumber = 'اسم الشارع/الرقم';
  static const String companyName = 'اسم الشركة';
  static const String buildingNumber = 'رقم المبنى';
  static const String floorNumber = 'الدور';
  static const String officeOrFloorNumber = 'رقم المكتب / الدور';
  static const String apartmentNumber = 'رقم الشقة';
  static const String additionalNotes = 'ملاحظات إضافية';
  static const String saveAddress = 'حفظ العنوان';
  static const String editAddressHint =
      'لتعديل عنوان، اذهب إلى حسابي -> العناوين .';

  // --- Saved Addresses ---
  static const String savedAddresses = 'عناوين المحفوظة';
  static const String noAddressesYet = 'لا توجد عناوين أخرى';
  static const String addFavoriteAddressesDesc =
      'أضف عناوينك المفضلة للوصول السريع إليها أثناء الحجز.';

  //  Merge duplicate semantic keys in future cleanup
  // addAddressBtn duplicates addYourAddress / addNewAddress
  static const String addAddressBtn = 'اضافة عنوان';

  //  Merge duplicate semantic keys in future cleanup
  // savedAddressesHeader duplicates savedAddresses ('عناوين المحفوظة')
  static const String savedAddressesHeader = 'العناوين';

  static const String homeAddress = 'المنزل';
  static const String workAddress = 'العمل';
  static const String addressLocation = 'عنوان الموقع';
  static const String writeLocationInDetail = 'اكتب الموقع بالتفصيل';

  static const String deleteAddressTitle = 'حذف العنوان';
  static const String deleteDefaultAddressDesc =
      'هذا هو العنوان الافتراضي الحالي. سيتم اختيار عنوان آخر كافتراضي تلقائيًا.';

  // ==================================================
  // NOTIFICATIONS
  // ==================================================
  static const String notifications = 'الاشعارات';
  static const String noNewNotifications = 'لا توجد تنبيهات جديدة';
  static const String newNotifications = 'جديد';
  static const String today = 'اليوم';
  static const String earlier = 'سابقا';

  //  Merge duplicate semantic keys in future cleanup
  // serviceCompleted duplicates completedService ('اكتملت الخدمة')
  static const String serviceCompleted = 'اكتملت الخدمة';
  static const String serviceCompletedDesc =
      'نأمل أن تكون قد استمتعت بخدمة تنظيف السجاد، رأيك يهمنا، يرجى تقييم الفريق.';

  static const String serviceStarted = 'بدء الخدمة';
  static const String serviceStartedDesc =
      'يعمل فريقنا الآن على تنفيذ خدمتك المطلوبة بأعلى جودة.';

  static const String serviceReminder = 'تذكير بموعد الخدمة';
  static const String serviceReminderDesc =
      'موعد خدمتك اليوم الساعة 5:00 مساءً';

  //  Merge duplicate semantic keys in future cleanup
  // bookingConfirmed is closely related to bookingConfirmedSuccess /
  // doneConfirmYourBookingSuccessfully
  static const String bookingConfirmed = 'تم تأكيد حجزك';
  static const String bookingConfirmedDesc =
      'تم تأكيد موعد الخدمة يوم الثلاثاء الساعة 4:00 مساءً.';

  static const String appointmentModified = 'تم تعديل موعد الخدمة';
  static const String appointmentModifiedDesc =
      'تم تحديث موعد الحجز إلى الساعة 6:00 مساءً بناءً على طلبك.';

  static const String rebookPrompt = 'هل ترغب بإعادة الحجز؟';
  static const String rebookPromptDesc = 'احجز نفس الخدمة مرة أخرى خلال ثواني.';

  static const String specialDiscount = 'خصم خاص لفترة محدودة';
  static const String specialDiscountDesc =
      'استمتع بخصم 20٪ على خدمات تنظيف الكنب كود الخصم clean20.';

  // ==================================================
  // SERVICE DETAILS
  // ==================================================
  static const String reviewsCount = 'تقييم';
  static const String discount = 'خصم';
  static const String applyCode = 'تطبيق الكود';
  static const String viewServiceDetails = 'عرض تفاصيل الخدمة';
  static const String serviceIncludes = 'تشمل الخدمة:';
  static const String notesBeforeBooking = 'ملاحظات قبل الحجز:';
  static const String add = 'أضف +';
  static const String codePrefix = 'الكود';

  // --- Service Cards ---
  static const String deepFurnitureCleaning = 'تنظيف أثاث عميق';
  static const String pestControlService = 'القضاء علي الحشرات';
  static const String glassCleaning = 'تنظيف الزجاج';

  // --- Sofa Cleaning Service Content ---
  // Renamed from: cleaningDeepThatWasWaitingForYourSofa
  static const String sofaDeepCleaningTagline =
      'التنظيف العميق الذي كانت تنتظره كنبتك';

  // Renamed from: cleaningSimpleSofaVacuumThingButDustGrains
  static const String sofaCleaningDetailedDescription =
      'تنظيف بسيط للكنبة بالمكنسة شيء، لكن الغبار وحبيبات الرمل والبقع المخفية التي تتراكم داخل نسيج الكنبة شيء مختلف تماماً.\n\nيقوم متخصصو التنظيف المعتمدون لدينا بالوصول إليك مجهزين بالكامل والعمل على كل طبقة من الكنبة لإعادة الانتعاش واللون والراحة إليها.';

  static const String inspectionFreeFully = 'معاينة مجانية بالكامل';

  // Renamed from: inspectSofaDetermineTypeFabricDetermineNeedsCleaning
  static const String sofaInspectionSteps =
      'فحص الكنبة لتحديد نوع القماش\nتحديد احتياجات التنظيف\nفحص الكنبة لتحديد نوع القماش\nتنظيف جاف بالمكنسة لإزالة الغبار والشعر والمخلفات\nتنظيف رطب بالشامبو باستخدام مواد متخصصة\nاستخراج البقع أثناء عملية الشامبو لمعالجتها\nمعالجة موضعية لاستخراج البقع العنيدة';

  // Renamed from: mayRemainSofaWetDurationUpToToNumber12
  static const String postCleaningSofaDryingNotes =
      'قد تظل الكنبة رطبة لمدة تصل إلى 12 ساعة بعد التنظيف.\nيعتمد وقت التجفيف على نوع القماش ودرجة التهوية في المكان.\nقد يصعب إزالة بعض البقع العنيدة جداً مثل بقع الحيوانات أو الدم أو الزيوت.\nسيقوم المختص بإرشادك إذا كانت بعض طرق التنظيف غير مناسبة لبعض أنواع الأقمشة.\nيرجى تغطية العناصر التي لا تشملها الخدمة أو لا يمكن تنظيفها.';

  // Renamed from: notExistsAnyCommitmentAfter
  static const String noCommitmentAfterInspection =
      'لا يوجد أي التزام بعد المعاينة';

  //  Merge duplicate semantic keys in future cleanup
  // notSureGetFreeInspection duplicates notSureFreeInspection
  // (typo fixed: 'لست وائقاً' -> 'لست واثقاً')
  static const String notSureGetFreeInspection =
      'لست واثقاً! احصل على معاينة مجانية';

  // ==================================================
  // BOOKING
  // ==================================================
  // --- Booking Statuses & Tabs ---
  //  Merge duplicate semantic keys in future cleanup
  // upcoming duplicates upcomingVisits ('القادمة')
  static const String upcoming = 'القادمة';

  static const String previous = 'السابقة';

  //  Merge duplicate semantic keys in future cleanup
  // scheduled duplicates scheduledStatus ('مجدولة')
  static const String scheduled = 'مجدولة';

  //  Merge duplicate semantic keys in future cleanup
  // inProgress duplicates inProgressStatus ('قيد التنفيذ')
  static const String inProgress = 'قيد التنفيذ';

  static const String completed = 'مكتمله';
  static const String cancelled = 'ملغاة';
  static const String viewDetails = 'عرض التفاصيل';
  static const String reschedule = 'إعادة جدولة';
  static const String cancelBooking = 'إلغاء الحجز';

  // Renamed from: confirmcancel (typo fixed: 'تاكيد الالغاء' -> 'تأكيد الإلغاء')
  //  Merge duplicate semantic keys in future cleanup
  // confirmCancel duplicates confirmCancelBtn ('تأكيد الإلغاء')
  static const String confirmCancel = 'تأكيد الإلغاء';

  // Renamed from: notFindbooking
  static const String noUpcomingBookings = 'لا توجد حجوزات قادمة';

  // Renamed from: bookdesc
  static const String noUpcomingBookingsDescription =
      'احجز خدمتك الآن وحدد الموعد المناسب لك بكل سهولة.';

  //  Merge duplicate semantic keys in future cleanup
  // rebookNow duplicates rebook / rebookBooking
  static const String rebookNow = 'اعادة حجز';

  //  Merge duplicate semantic keys in future cleanup
  // confirmReschedule duplicates confirmReschedule2
  static const String confirmReschedule = ' اعادة الجدولة';
  static const String confirmReschedule2 = 'تأكيد  اعادة الجدولة';

  static const String specialNotesOptional =
      'ملاحظات او تعليمات خاصه ( اختياري )';
  static const String exampleHomeLocation = 'مثال : المنزل أمام المسجد..';

  // Typo fixed: 'هل انت متاكد من الغاي الحجز' -> 'هل أنت متأكد من إلغاء الحجز؟'
  static const String areYouSureCancel = 'هل أنت متأكد من إلغاء الحجز؟';

  static const String cancelWarning =
      'سيتم الغاء الحجز ولن يتم تنفيذ الخدمة في الوقت المحدد لها';
  static const String cancelReasonOptional = 'سبب الالغاء';
  static const String mentionCancelReason = 'اذكر سبب الغاء الحجز';

  // --- Booking Flow: Shared ---
  static const String step = 'الخطوة';
  static const String ofText = 'من';
  static const String currentTotal = 'المجموع الحالي';

  // --- Booking Flow: Step 2 (Add-ons) ---
  static const String addonsTitle = 'الاضافات';

  //  Merge duplicate semantic keys in future cleanup
  // notSureFreeInspection duplicates notSureGetFreeInspection
  static const String notSureFreeInspection =
      'لست متأكداً احصل على معاينة مجانية';

  static const String inspectionDescription =
      'فريقنا جاهز لمساعدتك في اختيار الخدمة المناسبة بسهولة';
  static const String requestInspection = 'اطلب معاينة';

  // --- Booking Flow: Step 3 (Date & Time) ---
  static const String dateAndTimeTitle = 'التاريخ والوقت';
  static const String chooseDay = 'اختر اليوم';
  static const String chooseTime = 'اختر وقت';

  // Renamed from: start
  static const String advancePaymentLabel = ' مقدمه';

  static const String cancellationPolicy =
      'يمكنك إلغاء الحجز أو تعديله مجاناً قبل 5 ساعة من الموعد المقرر. في حال الإلغاء خلال أقل من 5 ساعة، سيتم تطبيق رسوم إلغاء بنسبة 25٪. عرض التفاصيل';

  static const String saturday = 'السبت';
  static const String sunday = 'الاحد';
  static const String monday = 'الاثنين';
  static const String tuesday = 'الثلاثاء';
  static const String wednesday = 'الاربعاء';
  static const String thursday = 'الخميس';
  static const String friday = 'الجمعة';

  // --- Booking Flow: Step 4 (Address) ---
  static const String addressTitle = 'العنوان';
  static const String specialInstructions = 'ملاحظات او تعليمات خاصة (اختياري)';

  // Typo fixed: 'امام' -> 'أمام'
  static const String specialInstructionsHint = 'مثال: اتصل أمام المسجد..';

  // --- Booking Flow: Order Summary ---
  static const String bookingSummary = 'ملخص الحجز';

  // --- House Cleaning Flow Config ---
  static const String houseCleaningTitle = 'تنظيف المنزل';
  static const String howManyHours = 'كم ساعة تريد عاملة / عاملة التنظيف؟';
  static const String oneHour = 'ساعة';
  static const String twoHours = 'ساعتين';
  static const String hours3 = '3 ساعات';
  static const String hours4 = '4 ساعات';
  static const String hours5 = '5 ساعات';
  static const String howManyWorkers = 'كم عدد العاملات /العمال؟';
  static const String worker = 'عامل';
  static const String placeSize = 'حجم المكان ؟';
  static const String smallApartment = 'شقة صغيرة';
  static const String mediumApartment = 'شقة متوسطة';
  static const String largeApartment = 'شقة كبيرة';
  static const String villa = 'فيلا';
  static const String teamPreference = 'تفضيل الفريق؟';
  static const String femaleTeam = 'نسائي';
  static const String maleTeam = 'رجالي';
  static const String noPreference = 'لا يهم';

  // --- Service Frequency ---
  static const String serviceFrequency = 'تكرار الخدمة';
  static const String once = 'مرة واحدة';
  static const String weekly = 'أسبوعيا';
  static const String monthly = 'شهريا';
  static const String discountUpTo10 = 'خصم يصل الى 10%';
  static const String discountUpTo20 = 'خصم يصل الى 20%';
  static const String discountUpTo70 = 'خصم يصل لـ %70';

  // --- Appointments ---
  static const String noAppointmentsAvailable = 'لا تتوفر مواعيد';
  static const String noAppointmentsDesc =
      'عذراً، جميع المواعيد محجوزة لليوم المختار، إليك بعض الاقتراحات البديلة:';
  static const String viewAllAppointments = 'عرض جميع المواعيد';

  // --- Booking Confirmation Popups ---
  //  Merge duplicate semantic keys in future cleanup
  // bookingConfirmedSuccess duplicates doneConfirmYourBookingSuccessfully
  static const String bookingConfirmedSuccess = 'تم تأكيد حجزك بنجاح !';

  //  Merge duplicate semantic keys in future cleanup
  // bookingConfirmedPopupDesc duplicates
  // doneConfirmYourBookingWeWillRemindYouBeforeAppointmentVisit
  static const String bookingConfirmedPopupDesc =
      'تم تأكيد حجزك وسيتم تذكيرك قبل موعد الزيارة بساعة';

  static const String bookingNumber = 'رقم الحجز';

  // Renamed from: dettailsbooking
  static const String bookingDetails = 'تفاصيل الحجز';

  // --- Booking Success / Failure ---
  static const String doneConfirmBooking = 'تم تأكيد الحجز';

  //  Merge duplicate semantic keys in future cleanup
  // doneConfirmYourBookingSuccessfully duplicates bookingConfirmedSuccess
  static const String doneConfirmYourBookingSuccessfully =
      'تم تأكيد حجزك بنجاح !';

  //  Merge duplicate semantic keys in future cleanup
  // doneConfirmYourBookingWeWillRemindYouBeforeAppointmentVisit duplicates
  // bookingConfirmedPopupDesc
  static const String
  doneConfirmYourBookingWeWillRemindYouBeforeAppointmentVisit =
      'تم تأكيد حجزك وسنقوم بتذكيرك قبل موعد الزيارة بساعة';

  static const String doneCopyNumberBooking = 'تم نسخ رقم الحجز';

  //  Merge duplicate semantic keys in future cleanup
  // rebookBooking duplicates rebookNow / rebook
  static const String rebookBooking = 'إعادة الحجز';

  // ==================================================
  // PAYMENT
  // ==================================================
  static const String paymentTitle = 'الدفع';

  //  Merge duplicate semantic keys in future cleanup
  // paymentMethod duplicates paymentMethodLabel
  static const String paymentMethod = 'طريقة الدفع';

  //  Merge duplicate semantic keys in future cleanup
  // payAfterService duplicates paymentOnService ('الدفع عند الخدمة')
  static const String payAfterService = 'الدفع عند الخدمة';

  //  Merge duplicate semantic keys in future cleanup
  // payAfterServiceDesc duplicates afterCompletionService
  static const String payAfterServiceDesc = 'ادفع نقداً بعد اتمام الخدمة';

  static const String discountCode = 'كود الخصم';
  static const String enterDiscountCode = 'ادخل كود الخصم';

  //  Merge duplicate semantic keys in future cleanup
  // securePaymentNote duplicates securePaymentNoteAlt
  static const String securePaymentNote =
      'جميع المدفوعات مشفرة لضمان أعلى مستويات الأمان والخصوصية.';

  //  Merge duplicate semantic keys in future cleanup
  // savedCards duplicates cardsSaved ('البطاقات المحفوظة')
  static const String savedCards = 'البطاقات المحفوظة';

  static const String defaultCard = 'افتراضي';
  static const String addNewCard = '+ اضافة بطاقه جديد';

  // --- Order Summary ---
  static const String paymentSummary = 'ملخص الدفع';
  static const String totalIncludingVat = 'المجموع (شامل الضريبة المضافة)';
  static const String totalLabel = 'المجموع';

  // Renamed from: totalprice
  static const String totalPrice = 'السعر الاجمالي';

  // --- Payment Methods Screen ---
  static const String afterCompletionService = 'ادفع نقداً بعد إتمام الخدمة';
  static const String cardCreditMada = 'بطاقة الائتمان / مدى';
  static const String cardsSaved = 'البطاقات المحفوظة';
  static const String mada = 'مدى';
  static const String paymentOnService = 'الدفع عند الخدمة';

  //  Merge duplicate semantic keys in future cleanup
  // changeMethodPayment duplicates changePaymentMethod ('تغيير طريقة الدفع')
  static const String changeMethodPayment = 'تغيير طريقة الدفع';

  // Renamed from: allPaymentsEncryptedEnsureHighestLevelsSecurityPrivacy
  //  Merge duplicate semantic keys in future cleanup
  // securePaymentNoteAlt duplicates securePaymentNote
  static const String securePaymentNoteAlt =
      'جميع المدفوعات مشفرة لضمان أعلى مستويات الأمان والخصوصية.';

  // Renamed from: sorryCouldNotFromProcessProcessPaymentYour
  //  Merge duplicate semantic keys in future cleanup
  // paymentFailedDescriptionAlt duplicates paymentFailedDesc
  static const String paymentFailedDescriptionAlt =
      'نعتذر، لم نتمكن من معالجة عملية الدفع الخاصة بك. يرجى التحقق من بيانات البطاقة أو المحاولة مرة أخرى.';

  static const String noSavedPaymentMethods = 'لا توجد طرق دفع محفوظة';
  static const String addPaymentMethodDesc =
      'قم بإضافة وسيلة دفع لتسهيل إتمام الطلبات بسرعة وأمان.';
  static const String addPaymentMethodBtn = 'اضافة وسيلة دفع';
  static const String defaultPaymentNotice =
      'سيتم استخدام وسيلة الدفع الافتراضية تلقائياً لجميع الحجوزات القادمة. يمكنك تغيير هذا الإعداد في أي وقت قبل إتمام عملية الدفع.';
  static const String cardNumberLabel = 'رقم البطاقه';
  static const String cardHolderLabel = 'اسم حامل البطاقة';

  // Typo fixed: 'هوا' -> 'هو', 'علي' -> 'على'
  static const String cardHolderPlaceholder = 'ادخل الاسم كما هو على البطاقة';

  //  Merge duplicate semantic keys in future cleanup
  // expiryDateLabel duplicates expiryDateLabelTitle
  static const String expiryDateLabel = 'تاريخ الانتهاء';

  static const String cvvLabel = 'رمز الامان';

  // Renamed from: paid
  //  Merge duplicate semantic keys in future cleanup
  // paymentMethodLabel duplicates paymentMethod
  static const String paymentMethodLabel = ' وسيلة الدفع';

  static const String saveCardForLater = 'حفظ البطاقة لاستخدام لاحقا';

  // --- Payment Result Popups ---
  //  Merge duplicate semantic keys in future cleanup
  // paymentFailed duplicates failedPayment ('فشل الدفع')
  static const String paymentFailed = 'فشل الدفع';

  //  Merge duplicate semantic keys in future cleanup
  // paymentFailedDesc duplicates paymentFailedDescriptionAlt
  static const String paymentFailedDesc =
      'نعتذر، لم نتمكن من معالجة عملية الدفع الخاصة بك، يرجى التحقق من بيانات البطاقة أو المحاولة مرة أخرى.';

  //  Merge duplicate semantic keys in future cleanup
  // changePaymentMethod duplicates changeMethodPayment
  static const String changePaymentMethod = 'تغيير طريقه الدفع';

  //  Merge duplicate semantic keys in future cleanup
  // failedPayment duplicates paymentFailed
  static const String failedPayment = 'فشل الدفع';

  // ==================================================
  // TRACKING
  // ==================================================
  static const String trackOrder = 'تتبع الطلب';

  //  Merge duplicate semantic keys in future cleanup
  // onTheWay duplicates inWay ('في الطريق')
  static const String onTheWay = 'في الطريق';

  static const String eta5Mins = 'الوصول المتوقع خلال 5 دقائق';

  //  Merge duplicate semantic keys in future cleanup
  // serviceStatus duplicates statusService ('حالة الخدمة')
  static const String serviceStatus = 'حالة الخدمة';

  static const String bookingConfirmedStatus = 'تم تأكيد الحجز';

  //  Merge duplicate semantic keys in future cleanup
  // teamOnTheWay duplicates teamInWayToYou ('الفريق في الطريق إليك')
  static const String teamOnTheWay = 'الفريق في الطريق إليك';

  //  Merge duplicate semantic keys in future cleanup
  // serviceInProgress duplicates serviceInProgressExecution
  static const String serviceInProgress = 'الخدمة قيد التنفيذ';

  static const String serviceCompletedStatus = 'تم الانتهاء';
  static const String teamLeader = 'قائد الفريق';

  //  Merge duplicate semantic keys in future cleanup
  // inWay duplicates onTheWay
  static const String inWay = 'في الطريق';

  //  Merge duplicate semantic keys in future cleanup
  // teamInWayToYou duplicates teamOnTheWay
  static const String teamInWayToYou = 'الفريق في الطريق إليك';

  //  Merge duplicate semantic keys in future cleanup
  // serviceInProgressExecution duplicates serviceInProgress
  static const String serviceInProgressExecution = 'الخدمة قيد التنفيذ';

  //  Merge duplicate semantic keys in future cleanup
  // completedService duplicates serviceCompleted
  static const String completedService = 'اكتملت الخدمة';

  //  Merge duplicate semantic keys in future cleanup
  // statusService duplicates serviceStatus
  static const String statusService = 'حالة الخدمة';

  //  Merge duplicate semantic keys in future cleanup
  // summaryWorkCompleted duplicates workSummary ('ملخص العمل المنجز')
  static const String summaryWorkCompleted = 'ملخص العمل المنجز';

  //  Merge duplicate semantic keys in future cleanup
  // timeSpent duplicates timeTaken ('الوقت المستغرق')
  static const String timeSpent = 'الوقت المستغرق';

  // Renamed from: text59
  static const String expectedArrival = 'الوصول المتوقع';

  // --- Service Completed ---
  static const String serviceCompletedScreenTitle = 'اكتملت الخدمة';
  static const String thankYouForChoosingUs = 'شكرا لاختيارك لنا';
  static const String serviceExecutedSuccessfully =
      'تم تنفيذ خدمة التنظيف العميق لمنزلك بنجاح وبأعلى معايير الجودة الفندقية.';

  //  Merge duplicate semantic keys in future cleanup
  // workSummary duplicates summaryWorkCompleted
  static const String workSummary = 'ملخص العمل المنجز';

  static const String serviceType = 'نوع الخدمة';

  //  Merge duplicate semantic keys in future cleanup
  // timeTaken duplicates timeSpent
  static const String timeTaken = 'الوقت المستغرق';

  static const String roomsCompletedDesc =
      'شامل الصالة، المطبخ، وغرف النوم مع التعقيم الكامل.';

  //  Merge duplicate semantic keys in future cleanup
  // rebook duplicates rebookNow / rebookBooking
  static const String rebook = 'إعادة الحجز';

  //  Merge duplicate semantic keys in future cleanup
  // trackBooking duplicates trackingBooking ('تتبع الحجز')
  static const String trackBooking = 'تتبع الحجز';

  //  Merge duplicate semantic keys in future cleanup
  // trackingBooking duplicates trackBooking
  static const String trackingBooking = 'تتبع الحجز';

  // ==================================================
  // RATINGS & REVIEWS
  // ==================================================
  static const String rateExperience = 'قيم تجربتك';
  static const String serviceRating = 'تقييم الخدمة';
  static const String teamRating = 'تقييم الفريق';
  static const String rating = ' ملاحظاتك';

  //  Merge duplicate semantic keys in future cleanup
  // teamRatingQuestion duplicates howWasExperienceWithIbrahimMohamedToday
  static const String teamRatingQuestion =
      'كيف كانت تجربتك مع فريق "ابراهيم محمد" اليوم؟';

  static const String addYourNotesHere = 'أضف ملاحظاتك هنا...';

  //  Merge duplicate semantic keys in future cleanup
  // levelOfServiceRatingQuestion duplicates howWasExperienceWithLevelServiceToday
  static const String levelOfServiceRatingQuestion =
      'كيف كانت تجربتك مع مستوى الخدمة اليوم؟';

  static const String submitRating = 'إرسال التقييم';

  //  Merge duplicate semantic keys in future cleanup
  // forRating duplicates thankYouForRating
  static const String forRating = 'شكراً لتقييمك';

  //  Merge duplicate semantic keys in future cleanup
  // howWasExperienceWithIbrahimMohamedToday duplicates teamRatingQuestion
  static const String howWasExperienceWithIbrahimMohamedToday =
      'كيف كانت تجربتك مع فريق "إبراهيم محمد" اليوم؟';

  //  Merge duplicate semantic keys in future cleanup
  // howWasExperienceWithLevelServiceToday duplicates
  // levelOfServiceRatingQuestion
  static const String howWasExperienceWithLevelServiceToday =
      'كيف كانت تجربتك مع مستوى الخدمة اليوم؟';

  //  Merge duplicate semantic keys in future cleanup
  // yourOpinionHelpsUsOnImproveService duplicates ratingHelpsImprove
  static const String yourOpinionHelpsUsOnImproveService =
      'رأيك يساعدنا على تحسين الخدمة';

  // --- Popups ---
  //  Merge duplicate semantic keys in future cleanup
  // thankYouForRating duplicates forRating
  static const String thankYouForRating = 'شكرا لتقييمك';

  //  Merge duplicate semantic keys in future cleanup
  // ratingHelpsImprove duplicates yourOpinionHelpsUsOnImproveService
  static const String ratingHelpsImprove = 'رأيك يساعدنا على تحسين الخدمة';

  // ==================================================
  // FAVORITES
  // ==================================================
  static const String favorites = 'المفضلات';
  static const String noFavoritesYet = 'لا توجد خدمات مفضلة حتى الآن';
  static const String saveServicesToAccessLater =
      'قم بحفظ الخدمات التي تعجبك للوصول إليها بسرعة لاحقًا.';

  // ==================================================
  // PROFILE
  // ==================================================
  static const String editProfile = ' الملف الشخصي';
  static const String nameLabel = 'الاسم';
  static const String phoneLabel = 'الهاتف';
  static const String emailLabel = 'البريد الإلكتروني';
  static const String deleteAccountBtn = 'حذف الحساب';
  static const String footerHint =
      'سيتم استخدام هذه المعلومات للتواصل معك بشأن حجوزاتك والخدمات المتاحة، ولن يتم مشاركتها بشكل عام.';

  // --- Delete Account Screens ---
  static const String deleteAccountHeader = 'حذف الحساب';
  static const String deleteWarningTitle = 'حذف الحساب نهائياً!';
  static const String deleteWarningDesc =
      'سيؤدي حذف حسابك إلى إزالة بياناتك الشخصية والعناوين المحفوظة وسجل الطلبات والإحصاءات بشكل نهائي.';

  static const String rule1Title = 'لا يمكن التراجع عن هذا الإجراء بعد التأكيد';
  static const String rule1Desc = 'سيتم حذف حسابك وجميع بياناتك بشكل دائم.';
  static const String rule2Title = 'يجب إنهاء أو إلغاء جميع الطلبات النشطة';
  static const String rule2Desc =
      'لا يمكنك حذف الحساب ولديك طلبات قيد التنفيذ.';
  static const String rule3Title = 'سيتم إلغاء أي اشتراكات أو باقات مفعولة';
  static const String rule3Desc =
      'جميع الاشتراكات أو الباقات المدفوعة المرتبطة بحسابك سيتم إلغاؤها.';
  static const String rule4Title =
      'قد يتم الاحتفاظ ببعض البيانات لأغراض قانونية';
  static const String rule4Desc =
      'مثل بيانات الفواتير والمعاملات وفقاً للأنظمة واللوائح المعمول بها.';

  static const String confirmDeleteHint = 'لتأكيد حذف الحساب يرجى كتابة كلمة (';
  static const String deleteConfirmWord = 'حذف';
  static const String confirmFieldHint = 'كلمة التأكيد غير صحيحة';
  static const String deleteConfirmBtn = 'حذف الحساب نهائياً';

  // --- Pop-ups ---
  static const String cannotDeleteTitle = 'لا يمكن حذف الحساب';
  static const String cannotDeleteDesc =
      'لديك طلبات أو باقات نشطة، يرجى إنهاء أو إلغاء المعاملات النشطة أولاً ثم إعادة المحاولة.';

  // --- Profile Sections ---
  static const String myAddresses = 'العناوين';
  static const String mySubscriptions = 'اشتراكاتي';
  static const String paymentMethods = 'طرق الدفع';
  static const String settings = 'الاعدادات';
  static const String contactUs = 'تواصل معنا';

  // ==================================================
  // SETTINGS
  // ==================================================
  static const String changePassword = 'تغيير كلمة المرور';
  static const String privacy = 'الخصوصية';
  static const String help = 'المساعدة';
  static const String language = 'اللغة';
  static const String arabic = 'العربية';
  static const String bookingNotifications = 'إشعارات الحجز';
  static const String logout = 'تسجيل الخروج';
  static const String logoutContent =
      'هل أنت متأكد أنك تريد تسجيل الخروج من حسابك؟ ';

  // ==================================================
  // HELP CENTER
  // ==================================================
  static const String helpCenter = 'مركز المساعدة';
  static const String faq = 'الاسئلة الشائعة';
  static const String technicalSupport = 'الدعم الفني';
  static const String newIssue = 'مشكلة جديدة  +';
  static const String open = 'مفتوح';
  static const String resolved = 'تم الحل';
  static const String ticketPrefix = 'TKT.';

  // --- FAQ Section (Intro) ---
  static const String faqIntro =
      'يمكنك اختيار الخدمة المناسبة، تحديد العنوان والموعد، ثم تأكيد الطلب والدفع مباشرة من التطبيق او اطلب معاينة وسيتواصل معك الفريق المختص مجانا.';

  //  Merge duplicate semantic keys in future cleanup
  // faqModifyBooking duplicates faqQ2
  static const String faqModifyBooking = 'هل يمكن تعديل أو إلغاء الحجز؟';

  static const String faqOrderStatus = 'كيف أعرف حالة طلبي؟';

  //  Merge duplicate semantic keys in future cleanup
  // faqPaymentMethods duplicates faqQ3
  static const String faqPaymentMethods = 'ما طرق الدفع المتوفرة؟';

  //  Merge duplicate semantic keys in future cleanup
  // faqProblemDuringService duplicates faqQ5
  static const String faqProblemDuringService =
      'ماذا أفعل إذا واجهت مشكلة أثناء الخدمة؟';

  // --- FAQ Section (Detailed Questions) ---
  static const String faqQ1 = 'كيف يمكنني حجز خدمة؟';

  //  Merge duplicate semantic keys in future cleanup
  // faqQ2 duplicates faqModifyBooking
  static const String faqQ2 = 'هل يمكنني تعديل أو إلغاء الحجز؟';

  //  Merge duplicate semantic keys in future cleanup
  // faqQ3 duplicates faqPaymentMethods
  static const String faqQ3 = 'ما هي طرق الدفع المتاحة؟';

  static const String faqQ4 = 'كيف يمكنني التواصل مع الدعم الفني؟';

  //  Merge duplicate semantic keys in future cleanup
  // faqQ5 duplicates faqProblemDuringService
  static const String faqQ5 = 'ماذا أفعل إذا لم أكن راضياً عن الخدمة؟';

  // --- Chat & Ticket Details ---
  // Typo fixed: 'هذة المحادثة للقراة فقط' -> 'هذه المحادثة للقراءة فقط'
  static const String readOnlyChat = 'هذه المحادثة للقراءة فقط';

  static const String reopenTicket = 'اعادة فتح التذكرة';

  //  Merge duplicate semantic keys in future cleanup
  // writeYourMessage duplicates typeMessageHint ('اكتب رسالتك...')
  static const String writeYourMessage = 'اكتب رسالتك...';

  // --- New Issue Bottom Sheet ---
  static const String newIssueTitle = 'مشكلة جديدة';
  static const String issueTitleLabel = 'عنوان المشكلة*';
  static const String issueTitleHint = 'مثال : مشكلة في خدمة التنظيف';
  static const String orderNumberLabel = 'رقم الطلب (اختياري)';
  static const String issueDescLabel = 'وصف المشكلة *';
  static const String issueDescHint = 'اشرح مشكلتك بالتفصيل.....';

  // --- Chat & Support ---
  static const String active = 'نشط';
  static const String online = 'متصل';

  //  Merge duplicate semantic keys in future cleanup
  // typeMessageHint duplicates writeYourMessage
  static const String typeMessageHint = 'اكتب رسالتك...';

  // --- Help Center Extra ---
  static const String contactInfoLabel = 'معلومات التواصل';
  static const String customerServiceNumberLabel = 'رقم خدمة العملاء';
  static const String emailAddressLabel = 'البريد الالكتروني';
  static const String privacyConfidentialityNote =
      'جميع بياناتك وارائك تعامل بسرية تامة ولا تشارك مع اي طرف ثالت .';

  // ==================================================
  // SUBSCRIPTIONS
  // ==================================================
  static const String currentSubscriptions = 'الحالية';
  static const String previousSubscriptions = 'السابقة';
  static const String noActiveSubscriptions = 'لا توجد اشتراكات نشطة';
  static const String subscribePackagesDesc =
      'اشترك في إحدى الباقات لتوفير الوقت والحصول على زيارات منتظمة بسهولة.';
  static const String browsePackagesBtn = 'استعراض الباقات';
  static const String manageSubscription = 'إدارة الاشتراك';
  static const String activeStatus = 'نشط';
  static const String pausedStatus = 'موقوف';
  static const String endedStatus = 'منتهي';
  static const String subscriptionTypeLabel = 'نوع الاشتراك';
  static const String nextVisitLabel = 'الزيارة القادمة';

  //  Merge duplicate semantic keys in future cleanup
  // expiryDateLabelTitle duplicates expiryDateLabel
  static const String expiryDateLabelTitle = 'ميعاد الانتهاء';

  static const String timeLabel = 'الوقت';
  static const String priceLabel = 'السعر';
  static const String monthlyPriceSuffix = 'ر.ق / شهرياً';
  static const String viewVisits = 'عرض الزيارات';
  static const String viewVisitsDesc = 'عرض المواعيد القادمة وسجل الزيارات';
  static const String pauseTemporarily = 'إيقاف مؤقت';
  static const String pauseTemporarilyDesc = 'إيقاف الاشتراك لفترة مؤقتة';
  static const String changePackage = 'تغيير الباقة';
  static const String changePackageDesc = 'تغيير الباقة الحالية لباقة أخرى';
  static const String cancelSubscription = 'إلغاء الاشتراك';
  static const String cancelSubscriptionDesc = 'إيقاف الاشتراك نهائياً';
  static const String reactivateBtn = 'إعادة التفعيل';
  static const String subscribeAgainBtn = 'اشترك مرة أخرى';
  static const String subscriptionPausedMsg = 'تم إيقاف الاشتراك مؤقتاً';

  // --- Subscription Popups ---
  static const String pausePopupTitle = 'إيقاف الاشتراك مؤقتاً';
  static const String pausePopupDesc =
      'لن يتم جدولة أي زيارات أثناء فترة الإيقاف يمكنك إعادة تفعيلة في أي وقت';
  static const String confirmPauseBtn = 'تأكيد الإيقاف';
  static const String cancelPopupTitle = 'إلغاء الاشتراك';
  static const String cancelPopupDesc =
      'سيتم إلغاء جميع الزيارات القادمة لن تتمكن من استئناف الاشتراك بعد إلغائه';

  //  Merge duplicate semantic keys in future cleanup
  // confirmCancelBtn duplicates confirmCancel
  static const String confirmCancelBtn = 'تأكيد الإلغاء';

  // ==================================================
  // VISITS
  // ==================================================
  static const String myVisits = 'زياراتي';

  //  Merge duplicate semantic keys in future cleanup
  // upcomingVisits duplicates upcoming
  static const String upcomingVisits = 'القادمة';

  //  Merge duplicate semantic keys in future cleanup
  // scheduledStatus duplicates scheduled
  static const String scheduledStatus = 'مجدولة';

  //  Merge duplicate semantic keys in future cleanup
  // inProgressStatus duplicates inProgress
  static const String inProgressStatus = 'قيد التنفيذ';

  // ==================================================
  // LEGAL & POLICIES
  // ==================================================
  // Typo fixed: 'القوانيين والسياسات' -> 'القوانين والسياسات'
  static const String policiesAndRules = 'القوانين والسياسات';

  static const String privacyPolicyLabel = 'سياسة الخصوصية';
  static const String termsAndConditionsLabel = 'الشروط والاحكام';

  // --- Privacy Policy Content ---
  static const String privacyPolicyIntro =
      'في خدمتنا، خصوصيتك تأتي أولًا. توضح هذه السياسة كيفية جمع بياناتك الشخصية واستخدامها وحمايتها عند استخدامك لتطبيق حجز الخدمات المنزلية. نلتزم بحماية خصوصيتك والشفافية الكاملة حول بياناتك.';
  static const String collectedData = 'البيانات التي نجمعها';
  static const String dataUsage = 'كيفية استخدام البيانات';
  static const String dataProtection = 'حماية البيانات';
  static const String dataSharing = 'مشاركة البيانات';

  // Renamed from: data
  static const String acceptanceOfTerms = 'القبول بالشروط';

  static const String policyModifications = 'التعديلات على السياسة';

  // --- Terms & Conditions Content ---
  static const String termsIntro =
      'باستخدامك لتطبيق وخدمات منصة الخدمات المنزلية، فإنك تقر وتوافق على الالتزام بهذه الشروط والأحكام. إذا كنت لا توافق على أي جزء من هذه الشروط، يرجى عدم استخدام الخدمة.';
  static const String services = 'الخدمات';
  static const String bookings = 'الحجوزات';
  static const String serviceCancellation = 'إلغاء الخدمة';
  static const String responsibility = 'المسؤولية';
  static const String companyResponsibilities = 'مسؤوليات الشركة';
  static const String accounts = 'الحسابات';
  static const String modifications = 'التعديلات';

  // ==================================================
  // DUMMY DATA / PLACEHOLDERS
  // ==================================================
  //  Replace with API or local storage values
  static const String profileName = 'Ahmed Ibrahim';
  static const String phoneNumber = '+974 5123 4567';
  static const String emailValue = 'ahmed.m@gmail.com';

  // Example promo code value
  static const String promoCode = 'CLEAN15';

  // Example price value
  static const String price120 = '120';

  // Support contact info
  static const String customerServiceNumber = '+974 3000 0000';
  static const String supportEmailAddress = 'support@migroup.com';

  // Help Center example tickets
  static const String ticketTitle1 = 'مشكلة في خدمه التنظيف';

  // Typo fixed: 'تنضيفهما' -> 'تنظيفهما'
  static const String ticketDesc1 =
      'المطبخ والحمام الرئيسي لم يتم تنظيفهما يشكل جيد';

  static const String ticketTitle2 = 'سعر خدمة مكافحة الحشرات';
  static const String ticketDesc2 = 'شكرا لكم هذا واضح';
  static const String timeOneDayAgo = 'منذ ١ يوم';

  // Example chat messages
  static const String supportMsg1 = 'مرحباً أحمد، كيف يمكننا مساعدتك اليوم؟';
  static const String userMsg1 = 'أريد الاستفسار عن موعد الزيارة القادم.';

  // Example address values
  static const String exampleHomeFrontMosque = 'مثال: المنزل أمام المسجد';
  static const String homeAddressSubtitle = '18، شارع النغيب، الدوحة، الدوحة';
  static const String workAddressSubtitle = 'برج المراقب - الطابق الثامن';

  // Example tracking / job summary values
  static const String eightRoomsCompleted = 'تم العمل ٨ غرف';
  static const String within18Minutes = 'خلال 18د';
  static const String minutes45 = '45 دقيقة';
  static const String roomsCompleted = 'تم إنجاز 4 غرف';

  // Example subscription name
  static const String weeklyCleaning = 'تنظيف منزلي أسبوعي';
}
