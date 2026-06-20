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
  static const String code = 'الكود';
  static const String copy = 'نسخ';
  static const String share = 'مشاركة';
  static const String retry = 'إعادة المحاولة';
  static const String send = 'إرسال';
  static const String regular = 'عادة';
  static const String backToHome = 'العودة للرئيسية';
  static const String unknownRoute = 'العنوان غير معروف';

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

  // ==================================================
  // OTP VERIFICATION
  // ==================================================
  static const String confirmCode = 'تأكيد الرمز';
  static const String enterVerificationCode =
      'أدخل رمز التحقق المكون من 6 أرقام المرسل إلى';
  static const String resendCodePrompt = 'لم تتلقى الكود بعد؟ ';

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
  static const String mosque = 'مسجد';
  static const String company = 'شركة';

  // ==================================================
  // HOME
  // ==================================================
  static const String currentLocation = 'الموقع الحالي';
  static const String searchServiceOrProblem = 'ابحث عن خدمة أو مشكلة...';
  static const String deepCleaning = 'تنظيف عميق';
  static const String cleaningFull = 'تنظيف شامل';
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
  static const String addNewAddress = '+ إضافة عنوان جديد';
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
  static const String savedAddresses = 'عناويني المحفوظة';
  static const String noAddressesYet = 'لا توجد عناوين أخرى';
  static const String addFavoriteAddressesDesc =
      'أضف عناوينك المفضلة للوصول السريع إليها أثناء الحجز.';
  static const String homeAddress = 'المنزل';
  static const String workAddress = 'العمل';
  static const String addressLocation = 'عنوان الموقع';
  static const String writeLocationInDetail = 'اكتب الموقع بالتفصيل';
  static const String writeNameCompanyOrMosque = 'اكتب اسم الشركة أو المسجد';

  static const String deleteAddressTitle = 'حذف العنوان';
  static const String deleteDefaultAddressDesc =
      'هذا هو العنوان الافتراضي الحالي. سيتم اختيار عنوان آخر كافتراضي تلقائيًا.';

  // ==================================================
  // NOTIFICATIONS
  // ==================================================
  static const String notifications = 'الإشعارات';
  static const String noNewNotifications = 'لا توجد تنبيهات جديدة';
  static const String newNotifications = 'جديد';
  static const String today = 'اليوم';
  static const String earlier = 'سابقا';
  static const String serviceCompletedDesc =
      'نأمل أن تكون قد استمتعت بخدمة تنظيف السجاد، رأيك يهمنا، يرجى تقييم الفريق.';
  static const String serviceStarted = 'بدء الخدمة';
  static const String serviceStartedDesc =
      'يعمل فريقنا الآن على تنفيذ خدمتك المطلوبة بأعلى جودة.';

  static const String serviceReminder = 'تذكير بموعد الخدمة';
  static const String serviceReminderDesc =
      'موعد خدمتك اليوم الساعة 5:00 مساءً';
  static const String bookingConfirmed = 'تم تأكيد حجزك بنجاح';
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
  static const String addCard = '+ إضافة بطاقة جديدة';

  // --- Service Cards ---
  static const String furniture = 'الأثاث';
  static const String deepFurnitureCleaning = 'تنظيف أثاث عميق';
  static const String pestControlService = 'القضاء على الحشرات';
  static const String glassCleaning = 'تنظيف الزجاج';
  static const String pestControlAntsApartment = 'مكافحة نمل - شقة';
  static const String pestControlAntsVilla = 'مكافحة نمل - فيلا';
  static const String pestControlApartment = 'مكافحة الصراصير - شقة';
  static const String pestControlBedbugsApartment = 'مكافحة بق - شقة';
  static const String pestControlBedbugsVilla = 'مكافحة بق - فيلا';
  static const String pestControlMiceApartment = 'مكافحة فئران - شقة';
  static const String pestControlMiceVilla = 'مكافحة فئران - فيلا';
  static const String pestControlPests = 'مكافحة حشرات';
  static const String pestControlVilla = 'مكافحة الصراصير - فيلا';
  static const String sprayFullAntsInApartment = 'رش شامل لمكافحة نمل في الشقة';
  static const String sprayFullAntsInVilla = 'رش شامل لمكافحة نمل في الفيلا';
  static const String sprayFullBedbugsInApartment =
      'رش شامل لمكافحة بق في الشقة';
  static const String sprayFullBedbugsInVilla = 'رش شامل لمكافحة بق في الفيلا';
  static const String sprayFullInApartment =
      'رش شامل لمكافحة الصراصير في الشقة';
  static const String sprayFullInVilla = 'رش شامل لمكافحة الصراصير في الفيلا';
  static const String sprayFullMiceInApartment =
      'رش شامل لمكافحة فئران في الشقة';
  static const String sprayFullMiceInVilla = 'رش شامل لمكافحة فئران في الفيلا';
  // --- Sofa Cleaning Service Content ---
  static const String sofaDeepCleaningTagline =
      'التنظيف العميق الذي كانت تنتظره كنبتك';

  static const String sofaCleaningDetailedDescription =
      'تنظيف بسيط للكنبة بالمكنسة شيء، لكن الغبار وحبيبات الرمل والبقع المخفية التي تتراكم داخل نسيج الكنبة شيء مختلف تماماً.\n\nيقوم متخصصو التنظيف المعتمدون لدينا بالوصول إليك مجهزين بالكامل والعمل على كل طبقة من الكنبة لإعادة الانتعاش واللون والراحة إليها.';

  static const String inspectionFreeFully = 'معاينة مجانية بالكامل';

  static const String sofaInspectionSteps =
      'فحص الكنبة لتحديد نوع القماش\nتحديد احتياجات التنظيف\nفحص الكنبة لتحديد نوع القماش\nتنظيف جاف بالمكنسة لإزالة الغبار والشعر والمخلفات\nتنظيف رطب بالشامبو باستخدام مواد متخصصة\nاستخراج البقع أثناء عملية الشامبو لمعالجتها\nمعالجة موضعية لاستخراج البقع العنيدة';

  static const String postCleaningSofaDryingNotes =
      'قد تظل الكنبة رطبة لمدة تصل إلى 12 ساعة بعد التنظيف.\nيعتمد وقت التجفيف على نوع القماش ودرجة التهوية في المكان.\nقد يصعب إزالة بعض البقع العنيدة جداً مثل بقع الحيوانات أو الدم أو الزيوت.\nسيقوم المختص بإرشادك إذا كانت بعض طرق التنظيف غير مناسبة لبعض أنواع الأقمشة.\nيرجى تغطية العناصر التي لا تشملها الخدمة أو لا يمكن تنظيفها.';

  static const String noCommitmentAfterInspection =
      'لا يوجد أي التزام بعد المعاينة';
  static const String notSureGetFreeInspection =
      'لست واثقاً! احصل على معاينة مجانية';

  static const String doneReceivedRequest = 'تم استلام طلب المعاينة';
  static const String companiesMosques = 'خدمات الشركات والمساجد';
  static const String provideCleaningSanitizationOfficesMosquesDetermine =
      'نقدم خدمات تنظيف وتعقيم للمكاتب والمساجد وفقاً لتحديد احتياجك بدقة وتقديم عرض سعر واضح بدون التزام.';
  static const String determineFinalAfterOnly =
      'يتم تحديد السعر النهائي بعد المعاينة فقط';

  // ==================================================
  // BOOKING
  // ==================================================
  static const String upcoming = 'القادمة';
  static const String previous = 'السابقة';
  static const String scheduled = 'مجدولة';
  static const String inProgress = 'قيد التنفيذ';
  static const String completed = 'مكتملة';
  static const String cancelled = 'ملغاة';
  static const String viewDetails = 'عرض التفاصيل';
  static const String reschedule = 'إعادة جدولة';
  static const String cancelBooking = 'إلغاء الحجز';
  static const String confirmCancel = 'تأكيد الإلغاء';
  static const String noUpcomingBookings = 'لا توجد حجوزات قادمة';
  static const String noUpcomingBookingsDescription =
      'احجز خدمتك الآن وحدد الموعد المناسب لك بكل سهولة.';
  static const String rebookNow = 'إعادة حجز';
  static const String confirmReschedule = 'إعادة الجدولة';
  static const String specialNotesOptional =
      'ملاحظات أو تعليمات خاصة (اختياري)';
  static const String exampleHomeLocation = 'مثال : المنزل أمام المسجد..';
  static const String areYouSureCancel = 'هل أنت متأكد من إلغاء الحجز؟';
  static const String cancelWarning =
      'سيتم إلغاء الحجز ولن يتم تنفيذ الخدمة في الوقت المحدد لها';
  static const String cancelReasonOptional = 'سبب الإلغاء';
  static const String mentionCancelReason = 'اذكر سبب إلغاء الحجز';
  // --- Booking Flow: Shared ---
  static const String step = 'الخطوة';
  static const String ofText = 'من';
  static const String currentTotal = 'المجموع الحالي';
  static const String sharingUnavailable = 'المشاركة غير متاحة حالياً';

  // --- Booking Flow: Step 2 (Add-ons) ---
  static const String addonsTitle = 'الإضافات';

  static const String inspectionDescription =
      'فريقنا جاهز لمساعدتك في اختيار الخدمة المناسبة بسهولة';
  static const String requestInspection = 'اطلب معاينة';

  // --- Booking Flow: Step 3 (Date & Time) ---
  static const String dateAndTimeTitle = 'التاريخ والوقت';
  static const String chooseDay = 'اختر اليوم';
  static const String chooseTime = 'اختر وقت';
  static const String advancePaymentLabel = 'مقدمة';
  static const String cancellationPolicy =
      'يمكنك إلغاء الحجز أو تعديله مجاناً قبل 5 ساعة من الموعد المقرر. في حال الإلغاء خلال أقل من 5 ساعة، سيتم تطبيق رسوم إلغاء بنسبة 25٪. عرض التفاصيل';
  static const String saturday = 'السبت';
  static const String sunday = 'الأحد';
  static const String monday = 'الاثنين';
  static const String tuesday = 'الثلاثاء';
  static const String wednesday = 'الأربعاء';
  static const String thursday = 'الخميس';
  static const String friday = 'الجمعة';

  // --- Booking Flow: Step 4 (Address) ---
  static const String addressTitle = 'العنوان';
  static const String specialInstructions = 'ملاحظات أو تعليمات خاصة (اختياري)';
  static const String savedAddressesTitle = 'عناويني المحفوظة';
  static const String detailsAdditionalOptional = 'تفاصيل إضافية (اختياري)';

  // Typo fixed: 'امام' -> 'أمام'
  static const String specialInstructionsHint = 'مثال: اتصل أمام المسجد..';

  // --- Booking Flow: Order Summary ---
  static const String bookingSummary = 'ملخص الحجز';

  // --- House Cleaning Flow Config ---
  static const String houseCleaningTitle = 'تنظيف المنزل';
  static const String howManyHours = 'كم ساعة تريد عاملة / عاملة التنظيف؟';
  static const String regularWithCleaningAddOn = 'عادة + إضافة التنظيف';
  static const String oneHour = 'ساعة';
  static const String hours = 'ساعات';
  static const String twoHours = 'ساعتين';
  static const String hours3 = '3 ساعات';
  static const String hours4 = '4 ساعات';
  static const String hours5 = '5 ساعات';
  static const String howManyWorkers = 'كم عدد العاملات /العمال؟';
  static const String countRoomsKitchens = 'كم عدد الغرف / المطابخ؟';
  static const String oneRoom = ' غرفة ١';
  static const String twoRooms = 'غرفة ٢';
  static const String threeRooms = 'غرفة ٣';
  static const String fourRooms = 'غرفة ٤';
  static const String worker = 'عامل';
  static const String placeSize = 'حجم المكان ؟';
  static const String smallApartment = 'شقة صغيرة';
  static const String mediumApartment = 'شقة متوسطة';
  static const String largeApartment = 'شقة كبيرة';
  static const String villa = 'فيلا';
  static const String studio = 'استوديو';
  static const String teamPreference = 'تفضيل الفريق؟';
  static const String femaleTeam = 'نسائي';
  static const String maleTeam = 'رجالي';
  static const String noPreference = 'لا يهم';
  static const String detailsFloors = 'تفاصيل الطوابق؟';
  static const String ground = 'أرضي';
  static const String first = 'أول';
  static const String second = 'ثاني';
  static const String sports = 'رياضي';
  static const String cleaningKitchen = 'تنظيف مطبخ';
  static const String cleaningWindows = 'تنظيف نوافذ';
  static const String cleaningBathroom = 'تنظيف حمام';
  static const String polishingFloors = 'تلميع أرضيات';
  static const String washingCurtains = 'غسيل ستائر';
  static const String cleaningOven = 'تنظيف فرن';
  static const String pillowsSleeping = 'وسادات نوم';
  static const String chairsDining = 'كراسي طعام';
  static const String pillowsDecorative = 'وسادات للزينة';
  static const String cockroaches = 'صراصير';
  static const String ants = 'نمل';
  static const String bedbugs = 'بق';
  static const String mice = 'فئران';
  static const String sofas = 'الكنب';
  static const String carpets = 'سجاد';
  static const String cleaningSofa = 'تنظيف الكنب';
  static const String cleaningSofaOnL = 'تنظيف الكنب على شكل حرف L';
  // cleaningInsideHome
  static const String cleaningInsideHomeForCarpets =
      'تنظيف احترافي للسجاد داخل المنزل';
  // cleaningInsideHome2
  static const String cleaningInsideHomeForSofas =
      'تنظيف احترافي للكنب داخل المنزل';

  // --- Service Frequency ---
  static const String serviceFrequency = 'تكرار الخدمة';
  static const String once = 'مرة واحدة';
  static const String weekly = 'أسبوعياً';
  static const String twoWeeks = 'أسبوعين';
  static const String monthly = 'شهرياً';
  static const String countTimesInWeek = 'عدد مرات في الأسبوع';
  static const String discountUpTo10 = 'خصم يصل الى 10%';
  static const String discountUpTo20 = 'خصم يصل الى 20%';
  static const String discountUpTo70 = 'خصم يصل لـ %70';
  static const String fivePercentDiscount = 'خصم 5٪';
  static const String sevenPercentDiscount = 'خصم 7%';
  static const String discountUpToTwelvePercent = 'خصم يصل إلى 12%';
  static const String discountUpToTwentyFivePercent = 'خصم يصل إلى 25%';

  // --- Appointments ---
  static const String noAppointmentsAvailable = 'لا تتوفر مواعيد';
  static const String noAppointmentsDesc =
      'عذراً، جميع المواعيد محجوزة لليوم المختار، إليك بعض الاقتراحات البديلة:';
  static const String viewAllAppointments = 'عرض جميع المواعيد';
  static const String bookingConfirmedPopupDesc =
      'تم تأكيد حجزك وسيتم تذكيرك قبل موعد الزيارة بساعة';
  static const String bookingNumber = 'رقم الحجز';
  static const String bookingDetails = 'تفاصيل الحجز';
  // --- Booking Success / Failure ---
  static const String doneConfirmBooking = 'تم تأكيد الحجز';
  static const String doneCopyNumberBooking = 'تم نسخ رقم الحجز';

  // ==================================================
  // PAYMENT
  // ==================================================
  static const String payment = 'الدفع';
  static const String discountCode = 'كود الخصم';
  static const String enterDiscountCode = 'أدخل كود الخصم';
  static const String securePaymentNote =
      'جميع المدفوعات مشفرة لضمان أعلى مستويات الأمان والخصوصية.';
  static const String defaultCard = 'افتراضي';
  static const String addNewCard = '+ إضافة بطاقة جديدة';

  // --- Order Summary ---
  static const String paymentSummary = 'ملخص الدفع';
  static const String totalIncludingVat = 'المجموع (شامل الضريبة المضافة)';
  static const String totalLabel = 'المجموع';
  static const String totalPrice = 'السعر الاجمالي';

  // --- Payment Methods Screen ---
  static const String afterCompletionService = 'ادفع نقداً بعد إتمام الخدمة';
  static const String cardCreditMada = 'بطاقة الائتمان / مدى';
  static const String cardsSaved = 'البطاقات المحفوظة';
  static const String mada = 'مدى';
  static const String paymentOnService = 'الدفع عند الخدمة';
  static const String changeMethodPayment = 'تغيير طريقة الدفع';
  static const String paymentFailedDescriptionAlt =
      'نعتذر، لم نتمكن من معالجة عملية الدفع الخاصة بك. يرجى التحقق من بيانات البطاقة أو المحاولة مرة أخرى.';

  static const String noSavedPaymentMethods = 'لا توجد طرق دفع محفوظة';
  static const String addPaymentMethodDesc =
      'قم بإضافة وسيلة دفع لتسهيل إتمام الطلبات بسرعة وأمان.';
  static const String addPaymentMethodBtn = 'إضافة وسيلة دفع';
  static const String defaultPaymentNotice =
      'سيتم استخدام وسيلة الدفع الافتراضية تلقائياً لجميع الحجوزات القادمة. يمكنك تغيير هذا الإعداد في أي وقت قبل إتمام عملية الدفع.';
  static const String cardNumberLabel = 'رقم البطاقة';
  static const String cardHolderLabel = 'اسم حامل البطاقة';

  // Typo fixed: 'هوا' -> 'هو', 'علي' -> 'على'
  static const String cardHolderPlaceholder = 'ادخل الاسم كما هو على البطاقة';
  static const String expiryDateLabel = 'تاريخ الانتهاء';
  static const String cvvLabel = 'رمز الأمان';
  static const String saveCardForLater = 'حفظ البطاقة لاستخدامها لاحقاً';
  // --- Payment Result Popups ---
  static const String paymentFailed = 'فشل الدفع';

  // ==================================================
  // TRACKING
  // ==================================================
  static const String trackOrder = 'تتبع الطلب';
  static const String onTheWay = 'في الطريق';
  static const String eta5Mins = 'الوصول المتوقع خلال 5 دقائق';
  static const String serviceStatus = 'حالة الخدمة';
  static const String bookingConfirmedStatus = 'تم تأكيد الحجز';
  static const String teamOnTheWay = 'الفريق في الطريق إليك';
  static const String serviceInProgress = 'الخدمة قيد التنفيذ';
  static const String serviceCompletedStatus = 'تم الانتهاء';
  static const String teamLeader = 'قائد الفريق';
  static const String completedService = 'اكتملت الخدمة';
  static const String summaryWorkCompleted = 'ملخص العمل المنجز';
  static const String timeSpent = 'الوقت المستغرق';
  static const String expectedArrival = 'الوصول المتوقع';

  // --- Service Completed ---
  static const String thankYouForChoosingUs = 'شكراً لاختيارك لنا';
  static const String serviceExecutedSuccessfully =
      'تم تنفيذ خدمة التنظيف العميق لمنزلك بنجاح ونتمنى رضاك وجودة الخدمة المقدمة.';

  static const String serviceType = 'نوع الخدمة';
  static const String typePlace = 'نوع المكان';
  static const String namePlace = 'اسم المكان';
  static const String areaPlace = 'مساحة المكان';
  static const String roomsCompletedDesc =
      'شامل الصالة، المطبخ، وغرف النوم مع التعقيم الكامل.';
  static const String trackBooking = 'تتبع الحجز';
  // ==================================================
  // RATINGS & REVIEWS
  // ==================================================
  static const String rateExperience = 'قيم تجربتك';
  static const String serviceRating = 'تقييم الخدمة';
  static const String teamRating = 'تقييم الفريق';
  static const String rating = ' ملاحظاتك';
  static const String teamRatingQuestion =
      'كيف كانت تجربتك مع فريق "ابراهيم محمد" اليوم؟';
  static const String addYourNotesHere = 'أضف ملاحظاتك هنا...';
  static const String levelOfServiceRatingQuestion =
      'كيف كانت تجربتك مع مستوى الخدمة اليوم؟';
  static const String submitRating = 'إرسال التقييم';
  static const String forRating = 'شكراً لتقييمك';
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
  static const String settings = 'الإعدادات';
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
  static const String faq = 'الأسئلة الشائعة';
  static const String technicalSupport = 'الدعم الفني';
  static const String newIssue = 'مشكلة جديدة  +';
  static const String open = 'مفتوح';
  static const String resolved = 'تم الحل';
  static const String ticketPrefix = 'TKT.';
  static const String careTechnician = 'فني العناية';

  // --- FAQ Section (Intro) ---
  static const String faqIntro =
      'يمكنك اختيار الخدمة المناسبة، تحديد العنوان والموعد، ثم تأكيد الطلب والدفع مباشرة من التطبيق أو اطلب معاينة وسيتواصل معك الفريق المختص مجاناً.';
  static const String faqModifyBooking = 'هل يمكن تعديل أو إلغاء الحجز؟';

  static const String faqOrderStatus = 'كيف أعرف حالة طلبي؟';
  static const String faqPaymentMethods = 'ما طرق الدفع المتوفرة؟';
  static const String faqProblemDuringService =
      'ماذا أفعل إذا واجهت مشكلة أثناء الخدمة؟';

  // --- FAQ Section (Detailed Questions) ---
  static const String faqQ1 = 'كيف يمكنني حجز خدمة؟';
  static const String faqQ4 = 'كيف يمكنني التواصل مع الدعم الفني؟';

  // --- Chat & Ticket Details ---
  // Typo fixed: 'هذة المحادثة للقراة فقط' -> 'هذه المحادثة للقراءة فقط'
  static const String readOnlyChat = 'هذه المحادثة للقراءة فقط';
  static const String reopenTicket = 'إعادة فتح التذكرة';
  static const String writeYourMessage = 'اكتب رسالتك...';
  // --- New Issue Bottom Sheet ---
  static const String newIssueTitle = 'مشكلة جديدة';
  static const String issueTitleLabel = 'عنوان المشكلة*';
  static const String issueTitleHint = 'مثال : مشكلة في خدمة التنظيف';
  static const String orderNumberLabel = 'رقم الطلب (اختياري)';
  static const String issueDescLabel = 'وصف المشكلة *';
  static const String issueDescHint = 'اشرح مشكلتك بالتفصيل.....';
  static const String writeAnyNotesHelpUsUnderstandYourNeed =
      'اكتب أي ملاحظات تساعدنا نفهم احتياجك...';

  // --- Chat & Support ---
  static const String active = 'نشط';
  static const String online = 'متصل';

  // --- Help Center Extra ---
  static const String contactInfoLabel = 'معلومات التواصل';
  static const String customerServiceNumberLabel = 'رقم خدمة العملاء';
  static const String emailAddressLabel = 'البريد الإلكتروني';
  static const String privacyConfidentialityNote =
      'جميع بياناتك وآراؤك تُعامل بسرية تامة ولا تُشارك مع أي طرف ثالث.';

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
  // ==================================================
  // VISITS
  // ==================================================
  static const String myVisits = 'زياراتي';
  // ==================================================
  // LEGAL & POLICIES
  // ==================================================
  // Typo fixed: 'القوانيين والسياسات' -> 'القوانين والسياسات'
  static const String policiesAndRules = 'القوانين والسياسات';

  static const String privacyPolicyLabel = 'سياسة الخصوصية';
  static const String termsAndConditionsLabel = 'الشروط والأحكام';

  // --- Privacy Policy Content ---
  static const String privacyPolicyIntro =
      'في خدمتنا، خصوصيتك تأتي أولًا. توضح هذه السياسة كيفية جمع بياناتك الشخصية واستخدامها وحمايتها عند استخدامك لتطبيق حجز الخدمات المنزلية. نلتزم بحماية خصوصيتك والشفافية الكاملة حول بياناتك.';
  static const String collectedData = 'البيانات التي نجمعها';
  static const String dataUsage = 'كيفية استخدام البيانات';
  static const String dataProtection = 'حماية البيانات';
  static const String dataSharing = 'مشاركة البيانات';
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
  static const String ibrahimMohamed = 'إبراهيم محمد';
  static const String ibrahimInitial = 'إ';

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
      'المطبخ والحمام الرئيسي لم يتم تنظيفهما بشكل جيد';

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
  static const String oneHundredEightyMinutes = '١٨٠ دقيقة';
  static const String roomsCompleted = 'تم إنجاز 4 غرف';

  // Example subscription name
  static const String weeklyCleaning = 'تنظيف منزلي أسبوعي';

  // Example nubmer of booking
  static const String twelveThousandBookings = '12,000 حجز';

  // Example Area
  static const String smallNumber100Number200 = 'صغيرة الحجم (100 * 200 م)';
  static const String mediumSize150By275 = 'متوسطة الحجم (150 * 275 م)';
  static const String largeSize250By345 = 'كبيرة الحجم (250 * 345 م)';

  static const String morning = 'ص';
  static const String tenTwentyEightAm = '10:28 ص';
}
