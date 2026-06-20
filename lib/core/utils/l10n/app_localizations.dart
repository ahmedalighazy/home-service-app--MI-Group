import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @save.
  ///
  /// In ar, this message translates to:
  /// **'حفظ'**
  String get save;

  /// No description provided for @cancelBtn.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء'**
  String get cancelBtn;

  /// No description provided for @okBtn.
  ///
  /// In ar, this message translates to:
  /// **'حسناً'**
  String get okBtn;

  /// No description provided for @confirm.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد'**
  String get confirm;

  /// No description provided for @viewAll.
  ///
  /// In ar, this message translates to:
  /// **'عرض الكل'**
  String get viewAll;

  /// No description provided for @bookNow.
  ///
  /// In ar, this message translates to:
  /// **'احجز الآن'**
  String get bookNow;

  /// No description provided for @goBack.
  ///
  /// In ar, this message translates to:
  /// **'رجوع'**
  String get goBack;

  /// No description provided for @next.
  ///
  /// In ar, this message translates to:
  /// **'التالي'**
  String get next;

  /// No description provided for @currency.
  ///
  /// In ar, this message translates to:
  /// **'ر.ق'**
  String get currency;

  /// No description provided for @code.
  ///
  /// In ar, this message translates to:
  /// **'الكود'**
  String get code;

  /// No description provided for @copy.
  ///
  /// In ar, this message translates to:
  /// **'نسخ'**
  String get copy;

  /// No description provided for @share.
  ///
  /// In ar, this message translates to:
  /// **'مشاركة'**
  String get share;

  /// No description provided for @retry.
  ///
  /// In ar, this message translates to:
  /// **'إعادة المحاولة'**
  String get retry;

  /// No description provided for @send.
  ///
  /// In ar, this message translates to:
  /// **'إرسال'**
  String get send;

  /// No description provided for @regular.
  ///
  /// In ar, this message translates to:
  /// **'عادة'**
  String get regular;

  /// No description provided for @backToHome.
  ///
  /// In ar, this message translates to:
  /// **'العودة للرئيسية'**
  String get backToHome;

  /// No description provided for @unknownRoute.
  ///
  /// In ar, this message translates to:
  /// **'العنوان غير معروف'**
  String get unknownRoute;

  /// No description provided for @sendCode.
  ///
  /// In ar, this message translates to:
  /// **'أرسل الكود'**
  String get sendCode;

  /// No description provided for @emailPlaceholder.
  ///
  /// In ar, this message translates to:
  /// **'أدخل البريد الإلكتروني'**
  String get emailPlaceholder;

  /// No description provided for @passwordLabel.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور'**
  String get passwordLabel;

  /// No description provided for @passwordPlaceholder.
  ///
  /// In ar, this message translates to:
  /// **'أدخل كلمة المرور'**
  String get passwordPlaceholder;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد كلمة المرور'**
  String get confirmPasswordLabel;

  /// No description provided for @confirmPasswordPlaceholder.
  ///
  /// In ar, this message translates to:
  /// **'أعد إدخال كلمة المرور'**
  String get confirmPasswordPlaceholder;

  /// No description provided for @login.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول'**
  String get login;

  /// No description provided for @termsAndPrivacy.
  ///
  /// In ar, this message translates to:
  /// **'بتسجيل الدخول أنت توافق على الشروط والأحكام وسياسة الخصوصية'**
  String get termsAndPrivacy;

  /// No description provided for @orUsing.
  ///
  /// In ar, this message translates to:
  /// **'أو باستخدام'**
  String get orUsing;

  /// No description provided for @welcomeBack.
  ///
  /// In ar, this message translates to:
  /// **'أهلاً بعودتك'**
  String get welcomeBack;

  /// No description provided for @welcomeSignUp.
  ///
  /// In ar, this message translates to:
  /// **'أنشئ حساب جديد'**
  String get welcomeSignUp;

  /// No description provided for @signUpSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'أدخل رقم هاتفك للتسجيل والحصول على رمز التحقق'**
  String get signUpSubtitle;

  /// No description provided for @verificationMethodInfo.
  ///
  /// In ar, this message translates to:
  /// **'سنتصل بك أو سنرسل لك رمز التحقق لإكمال تسجيل الدخول'**
  String get verificationMethodInfo;

  /// No description provided for @signUpWithGoogle.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل عبر Google'**
  String get signUpWithGoogle;

  /// No description provided for @signUpWithApple.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل عبر Apple'**
  String get signUpWithApple;

  /// No description provided for @continueAsGuest.
  ///
  /// In ar, this message translates to:
  /// **'المتابعة كضيف'**
  String get continueAsGuest;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In ar, this message translates to:
  /// **'لديك حساب بالفعل؟ '**
  String get alreadyHaveAccount;

  /// No description provided for @signInAction.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول'**
  String get signInAction;

  /// No description provided for @dontHaveAccount.
  ///
  /// In ar, this message translates to:
  /// **'ليس لديك حساب ؟ '**
  String get dontHaveAccount;

  /// No description provided for @createAccount.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء حساب'**
  String get createAccount;

  /// No description provided for @forgotPassword.
  ///
  /// In ar, this message translates to:
  /// **'نسيت كلمة المرور؟'**
  String get forgotPassword;

  /// No description provided for @rememberMe.
  ///
  /// In ar, this message translates to:
  /// **'تذكرني'**
  String get rememberMe;

  /// No description provided for @phonePlaceholder.
  ///
  /// In ar, this message translates to:
  /// **'5123 4567'**
  String get phonePlaceholder;

  /// No description provided for @defaultCountryCode.
  ///
  /// In ar, this message translates to:
  /// **'+974'**
  String get defaultCountryCode;

  /// No description provided for @errorIncorrectPassword.
  ///
  /// In ar, this message translates to:
  /// **'كلمة مرور غير صحيحة'**
  String get errorIncorrectPassword;

  /// No description provided for @errorPasswordsDoNotMatch.
  ///
  /// In ar, this message translates to:
  /// **'كلمتا المرور غير متطابقتين'**
  String get errorPasswordsDoNotMatch;

  /// No description provided for @password.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور'**
  String get password;

  /// No description provided for @passwordNow.
  ///
  /// In ar, this message translates to:
  /// **' كلمة المرور الحالية'**
  String get passwordNow;

  /// No description provided for @enterPassword.
  ///
  /// In ar, this message translates to:
  /// **'أدخل كلمة المرور'**
  String get enterPassword;

  /// No description provided for @confirmCode.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد الرمز'**
  String get confirmCode;

  /// No description provided for @enterVerificationCode.
  ///
  /// In ar, this message translates to:
  /// **'أدخل رمز التحقق المكون من 6 أرقام المرسل إلى'**
  String get enterVerificationCode;

  /// No description provided for @resendCodePrompt.
  ///
  /// In ar, this message translates to:
  /// **'لم تتلقى الكود بعد؟ '**
  String get resendCodePrompt;

  /// No description provided for @resendCodeLink.
  ///
  /// In ar, this message translates to:
  /// **'إعادة إرسال الكود'**
  String get resendCodeLink;

  /// No description provided for @defaultOtpTimer.
  ///
  /// In ar, this message translates to:
  /// **'0:59'**
  String get defaultOtpTimer;

  /// No description provided for @completeProfile.
  ///
  /// In ar, this message translates to:
  /// **'أكمل ملفك الشخصي'**
  String get completeProfile;

  /// No description provided for @completeProfileSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'أضف بعض المعلومات لتخصيص تجربتك داخل التطبيق'**
  String get completeProfileSubtitle;

  /// No description provided for @namePlaceholder.
  ///
  /// In ar, this message translates to:
  /// **'أدخل اسمك بالكامل'**
  String get namePlaceholder;

  /// No description provided for @completeRegistration.
  ///
  /// In ar, this message translates to:
  /// **'إكمال التسجيل'**
  String get completeRegistration;

  /// No description provided for @resetPassword.
  ///
  /// In ar, this message translates to:
  /// **'إعادة تعيين كلمة المرور'**
  String get resetPassword;

  /// No description provided for @resetPasswordDescription.
  ///
  /// In ar, this message translates to:
  /// **'من فضلك أدخل بريدك الإلكتروني لإعادة تعيين كلمة السر'**
  String get resetPasswordDescription;

  /// No description provided for @checkEmail.
  ///
  /// In ar, this message translates to:
  /// **'تحقق من بريدك الإلكتروني'**
  String get checkEmail;

  /// No description provided for @emailSentDescription.
  ///
  /// In ar, this message translates to:
  /// **'تم إرسال رابط إعادة تعيين إلى ahmed...‌@gmail.com أدخل الرمز المتكون من 4 أرقام لتأكيد البريد الإلكتروني'**
  String get emailSentDescription;

  /// No description provided for @setNewPassword.
  ///
  /// In ar, this message translates to:
  /// **'تعيين كلمة مرور جديدة'**
  String get setNewPassword;

  /// No description provided for @setNewPasswordDescription.
  ///
  /// In ar, this message translates to:
  /// **'أنشئ كلمة مرور جديدة، وتأكد من أنها مختلفة عن كلمة المرور السابقة .'**
  String get setNewPasswordDescription;

  /// No description provided for @passwordChangedSuccessfully.
  ///
  /// In ar, this message translates to:
  /// **'تم تغيير كلمة المرور بنجاح'**
  String get passwordChangedSuccessfully;

  /// No description provided for @loginWithNewPassword.
  ///
  /// In ar, this message translates to:
  /// **'يمكنك الآن تسجيل الدخول بكلمة المرور الجديدة'**
  String get loginWithNewPassword;

  /// No description provided for @newPassword.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور الجديدة'**
  String get newPassword;

  /// No description provided for @setYourLocation.
  ///
  /// In ar, this message translates to:
  /// **'حدد موقعك'**
  String get setYourLocation;

  /// No description provided for @locationPermissionDescription.
  ///
  /// In ar, this message translates to:
  /// **'نحتاج إلى موقعك لعرض الخدمات المتاحة بالقرب منك'**
  String get locationPermissionDescription;

  /// No description provided for @setCurrentLocation.
  ///
  /// In ar, this message translates to:
  /// **'تحديد الموقع الحالي'**
  String get setCurrentLocation;

  /// No description provided for @chooseLocationManually.
  ///
  /// In ar, this message translates to:
  /// **'اختيار الموقع يدويا'**
  String get chooseLocationManually;

  /// No description provided for @searchLocationPlaceholder.
  ///
  /// In ar, this message translates to:
  /// **'ابحث عن منطقة أو عنوان...'**
  String get searchLocationPlaceholder;

  /// No description provided for @confirmLocation.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد الموقع'**
  String get confirmLocation;

  /// No description provided for @errorOutOfZone.
  ///
  /// In ar, this message translates to:
  /// **'عذراً لا نقدم خدمة في هذه المنطقة'**
  String get errorOutOfZone;

  /// No description provided for @mosque.
  ///
  /// In ar, this message translates to:
  /// **'مسجد'**
  String get mosque;

  /// No description provided for @company.
  ///
  /// In ar, this message translates to:
  /// **'شركة'**
  String get company;

  /// No description provided for @currentLocation.
  ///
  /// In ar, this message translates to:
  /// **'الموقع الحالي'**
  String get currentLocation;

  /// No description provided for @searchServiceOrProblem.
  ///
  /// In ar, this message translates to:
  /// **'ابحث عن خدمة أو مشكلة...'**
  String get searchServiceOrProblem;

  /// No description provided for @deepCleaning.
  ///
  /// In ar, this message translates to:
  /// **'تنظيف عميق'**
  String get deepCleaning;

  /// No description provided for @cleaningFull.
  ///
  /// In ar, this message translates to:
  /// **'تنظيف شامل'**
  String get cleaningFull;

  /// No description provided for @houseCleaning.
  ///
  /// In ar, this message translates to:
  /// **'تنظيف منزل'**
  String get houseCleaning;

  /// No description provided for @pestControl.
  ///
  /// In ar, this message translates to:
  /// **'مكافحة حشرات'**
  String get pestControl;

  /// No description provided for @corporateServices.
  ///
  /// In ar, this message translates to:
  /// **'خدمات المؤسسات'**
  String get corporateServices;

  /// No description provided for @mostRequested.
  ///
  /// In ar, this message translates to:
  /// **'الأكثر طلباً'**
  String get mostRequested;

  /// No description provided for @navHome.
  ///
  /// In ar, this message translates to:
  /// **'الرئيسية'**
  String get navHome;

  /// No description provided for @navBookings.
  ///
  /// In ar, this message translates to:
  /// **'حجوزاتي'**
  String get navBookings;

  /// No description provided for @navAccount.
  ///
  /// In ar, this message translates to:
  /// **'حسابي'**
  String get navAccount;

  /// No description provided for @specialOfferTitle.
  ///
  /// In ar, this message translates to:
  /// **'عروض مخصصة للشركات والمؤسسات'**
  String get specialOfferTitle;

  /// No description provided for @serviceAvailable24h.
  ///
  /// In ar, this message translates to:
  /// **'خدمة سريعة خلال 24 ساعة'**
  String get serviceAvailable24h;

  /// No description provided for @bestCleaningWork.
  ///
  /// In ar, this message translates to:
  /// **'أنس أعمال التنظيف بعد العمل'**
  String get bestCleaningWork;

  /// No description provided for @hourlyClean.
  ///
  /// In ar, this message translates to:
  /// **'تنظيف بالساعة'**
  String get hourlyClean;

  /// No description provided for @startingPrice.
  ///
  /// In ar, this message translates to:
  /// **'تبدأ الأسعار من 100 ريال'**
  String get startingPrice;

  /// No description provided for @recentSearches.
  ///
  /// In ar, this message translates to:
  /// **'عمليات البحث الأخيرة'**
  String get recentSearches;

  /// No description provided for @clearAll.
  ///
  /// In ar, this message translates to:
  /// **'مسح الكل'**
  String get clearAll;

  /// No description provided for @popularServices.
  ///
  /// In ar, this message translates to:
  /// **'خدمات شائعة'**
  String get popularServices;

  /// No description provided for @youMightBeLookingFor.
  ///
  /// In ar, this message translates to:
  /// **'ربما تبحث عن'**
  String get youMightBeLookingFor;

  /// No description provided for @categories.
  ///
  /// In ar, this message translates to:
  /// **'تصنيفات'**
  String get categories;

  /// No description provided for @noResultsFound.
  ///
  /// In ar, this message translates to:
  /// **'لم يتم العثور على نتائج'**
  String get noResultsFound;

  /// No description provided for @noResultsFoundDescription.
  ///
  /// In ar, this message translates to:
  /// **'لم نتمكن من العثور على أي خدمات تطابق ببحثك عن'**
  String get noResultsFoundDescription;

  /// No description provided for @browseServices.
  ///
  /// In ar, this message translates to:
  /// **'تصفح الخدمات'**
  String get browseServices;

  /// No description provided for @tryOtherWords.
  ///
  /// In ar, this message translates to:
  /// **'جرب كلمات أخرى'**
  String get tryOtherWords;

  /// No description provided for @insectsInHouse.
  ///
  /// In ar, this message translates to:
  /// **' وجود حشرات في المنزل'**
  String get insectsInHouse;

  /// No description provided for @insectsInHouseDis.
  ///
  /// In ar, this message translates to:
  /// **'حلول فورية لمكافحة الآفات'**
  String get insectsInHouseDis;

  /// No description provided for @chooseYourAddress.
  ///
  /// In ar, this message translates to:
  /// **'اختر عنوانك'**
  String get chooseYourAddress;

  /// No description provided for @addNewAddress.
  ///
  /// In ar, this message translates to:
  /// **'+ إضافة عنوان جديد'**
  String get addNewAddress;

  /// No description provided for @streetNameOrNumber.
  ///
  /// In ar, this message translates to:
  /// **'اسم الشارع/الرقم'**
  String get streetNameOrNumber;

  /// No description provided for @companyName.
  ///
  /// In ar, this message translates to:
  /// **'اسم الشركة'**
  String get companyName;

  /// No description provided for @buildingNumber.
  ///
  /// In ar, this message translates to:
  /// **'رقم المبنى'**
  String get buildingNumber;

  /// No description provided for @floorNumber.
  ///
  /// In ar, this message translates to:
  /// **'الدور'**
  String get floorNumber;

  /// No description provided for @officeOrFloorNumber.
  ///
  /// In ar, this message translates to:
  /// **'رقم المكتب / الدور'**
  String get officeOrFloorNumber;

  /// No description provided for @apartmentNumber.
  ///
  /// In ar, this message translates to:
  /// **'رقم الشقة'**
  String get apartmentNumber;

  /// No description provided for @additionalNotes.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظات إضافية'**
  String get additionalNotes;

  /// No description provided for @saveAddress.
  ///
  /// In ar, this message translates to:
  /// **'حفظ العنوان'**
  String get saveAddress;

  /// No description provided for @editAddressHint.
  ///
  /// In ar, this message translates to:
  /// **'لتعديل عنوان، اذهب إلى حسابي -> العناوين .'**
  String get editAddressHint;

  /// No description provided for @savedAddresses.
  ///
  /// In ar, this message translates to:
  /// **'عناويني المحفوظة'**
  String get savedAddresses;

  /// No description provided for @noAddressesYet.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد عناوين أخرى'**
  String get noAddressesYet;

  /// No description provided for @addFavoriteAddressesDesc.
  ///
  /// In ar, this message translates to:
  /// **'أضف عناوينك المفضلة للوصول السريع إليها أثناء الحجز.'**
  String get addFavoriteAddressesDesc;

  /// No description provided for @homeAddress.
  ///
  /// In ar, this message translates to:
  /// **'المنزل'**
  String get homeAddress;

  /// No description provided for @workAddress.
  ///
  /// In ar, this message translates to:
  /// **'العمل'**
  String get workAddress;

  /// No description provided for @addressLocation.
  ///
  /// In ar, this message translates to:
  /// **'عنوان الموقع'**
  String get addressLocation;

  /// No description provided for @writeLocationInDetail.
  ///
  /// In ar, this message translates to:
  /// **'اكتب الموقع بالتفصيل'**
  String get writeLocationInDetail;

  /// No description provided for @writeNameCompanyOrMosque.
  ///
  /// In ar, this message translates to:
  /// **'اكتب اسم الشركة أو المسجد'**
  String get writeNameCompanyOrMosque;

  /// No description provided for @deleteAddressTitle.
  ///
  /// In ar, this message translates to:
  /// **'حذف العنوان'**
  String get deleteAddressTitle;

  /// No description provided for @deleteDefaultAddressDesc.
  ///
  /// In ar, this message translates to:
  /// **'هذا هو العنوان الافتراضي الحالي. سيتم اختيار عنوان آخر كافتراضي تلقائيًا.'**
  String get deleteDefaultAddressDesc;

  /// No description provided for @notifications.
  ///
  /// In ar, this message translates to:
  /// **'الإشعارات'**
  String get notifications;

  /// No description provided for @noNewNotifications.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد تنبيهات جديدة'**
  String get noNewNotifications;

  /// No description provided for @newNotifications.
  ///
  /// In ar, this message translates to:
  /// **'جديد'**
  String get newNotifications;

  /// No description provided for @today.
  ///
  /// In ar, this message translates to:
  /// **'اليوم'**
  String get today;

  /// No description provided for @earlier.
  ///
  /// In ar, this message translates to:
  /// **'سابقا'**
  String get earlier;

  /// No description provided for @serviceCompletedDesc.
  ///
  /// In ar, this message translates to:
  /// **'نأمل أن تكون قد استمتعت بخدمة تنظيف السجاد، رأيك يهمنا، يرجى تقييم الفريق.'**
  String get serviceCompletedDesc;

  /// No description provided for @serviceStarted.
  ///
  /// In ar, this message translates to:
  /// **'بدء الخدمة'**
  String get serviceStarted;

  /// No description provided for @serviceStartedDesc.
  ///
  /// In ar, this message translates to:
  /// **'يعمل فريقنا الآن على تنفيذ خدمتك المطلوبة بأعلى جودة.'**
  String get serviceStartedDesc;

  /// No description provided for @serviceReminder.
  ///
  /// In ar, this message translates to:
  /// **'تذكير بموعد الخدمة'**
  String get serviceReminder;

  /// No description provided for @serviceReminderDesc.
  ///
  /// In ar, this message translates to:
  /// **'موعد خدمتك اليوم الساعة 5:00 مساءً'**
  String get serviceReminderDesc;

  /// No description provided for @bookingConfirmed.
  ///
  /// In ar, this message translates to:
  /// **'تم تأكيد حجزك بنجاح'**
  String get bookingConfirmed;

  /// No description provided for @bookingConfirmedDesc.
  ///
  /// In ar, this message translates to:
  /// **'تم تأكيد موعد الخدمة يوم الثلاثاء الساعة 4:00 مساءً.'**
  String get bookingConfirmedDesc;

  /// No description provided for @appointmentModified.
  ///
  /// In ar, this message translates to:
  /// **'تم تعديل موعد الخدمة'**
  String get appointmentModified;

  /// No description provided for @appointmentModifiedDesc.
  ///
  /// In ar, this message translates to:
  /// **'تم تحديث موعد الحجز إلى الساعة 6:00 مساءً بناءً على طلبك.'**
  String get appointmentModifiedDesc;

  /// No description provided for @rebookPrompt.
  ///
  /// In ar, this message translates to:
  /// **'هل ترغب بإعادة الحجز؟'**
  String get rebookPrompt;

  /// No description provided for @rebookPromptDesc.
  ///
  /// In ar, this message translates to:
  /// **'احجز نفس الخدمة مرة أخرى خلال ثواني.'**
  String get rebookPromptDesc;

  /// No description provided for @specialDiscount.
  ///
  /// In ar, this message translates to:
  /// **'خصم خاص لفترة محدودة'**
  String get specialDiscount;

  /// No description provided for @specialDiscountDesc.
  ///
  /// In ar, this message translates to:
  /// **'استمتع بخصم 20٪ على خدمات تنظيف الكنب كود الخصم clean20.'**
  String get specialDiscountDesc;

  /// No description provided for @reviewsCount.
  ///
  /// In ar, this message translates to:
  /// **'تقييم'**
  String get reviewsCount;

  /// No description provided for @discount.
  ///
  /// In ar, this message translates to:
  /// **'خصم'**
  String get discount;

  /// No description provided for @applyCode.
  ///
  /// In ar, this message translates to:
  /// **'تطبيق الكود'**
  String get applyCode;

  /// No description provided for @viewServiceDetails.
  ///
  /// In ar, this message translates to:
  /// **'عرض تفاصيل الخدمة'**
  String get viewServiceDetails;

  /// No description provided for @serviceIncludes.
  ///
  /// In ar, this message translates to:
  /// **'تشمل الخدمة:'**
  String get serviceIncludes;

  /// No description provided for @notesBeforeBooking.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظات قبل الحجز:'**
  String get notesBeforeBooking;

  /// No description provided for @add.
  ///
  /// In ar, this message translates to:
  /// **'أضف +'**
  String get add;

  /// No description provided for @codePrefix.
  ///
  /// In ar, this message translates to:
  /// **'الكود'**
  String get codePrefix;

  /// No description provided for @addCard.
  ///
  /// In ar, this message translates to:
  /// **'+ إضافة بطاقة جديدة'**
  String get addCard;

  /// No description provided for @furniture.
  ///
  /// In ar, this message translates to:
  /// **'الأثاث'**
  String get furniture;

  /// No description provided for @deepFurnitureCleaning.
  ///
  /// In ar, this message translates to:
  /// **'تنظيف أثاث عميق'**
  String get deepFurnitureCleaning;

  /// No description provided for @pestControlService.
  ///
  /// In ar, this message translates to:
  /// **'القضاء على الحشرات'**
  String get pestControlService;

  /// No description provided for @glassCleaning.
  ///
  /// In ar, this message translates to:
  /// **'تنظيف الزجاج'**
  String get glassCleaning;

  /// No description provided for @pestControlAntsApartment.
  ///
  /// In ar, this message translates to:
  /// **'مكافحة نمل - شقة'**
  String get pestControlAntsApartment;

  /// No description provided for @pestControlAntsVilla.
  ///
  /// In ar, this message translates to:
  /// **'مكافحة نمل - فيلا'**
  String get pestControlAntsVilla;

  /// No description provided for @pestControlApartment.
  ///
  /// In ar, this message translates to:
  /// **'مكافحة الصراصير - شقة'**
  String get pestControlApartment;

  /// No description provided for @pestControlBedbugsApartment.
  ///
  /// In ar, this message translates to:
  /// **'مكافحة بق - شقة'**
  String get pestControlBedbugsApartment;

  /// No description provided for @pestControlBedbugsVilla.
  ///
  /// In ar, this message translates to:
  /// **'مكافحة بق - فيلا'**
  String get pestControlBedbugsVilla;

  /// No description provided for @pestControlMiceApartment.
  ///
  /// In ar, this message translates to:
  /// **'مكافحة فئران - شقة'**
  String get pestControlMiceApartment;

  /// No description provided for @pestControlMiceVilla.
  ///
  /// In ar, this message translates to:
  /// **'مكافحة فئران - فيلا'**
  String get pestControlMiceVilla;

  /// No description provided for @pestControlPests.
  ///
  /// In ar, this message translates to:
  /// **'مكافحة حشرات'**
  String get pestControlPests;

  /// No description provided for @pestControlVilla.
  ///
  /// In ar, this message translates to:
  /// **'مكافحة الصراصير - فيلا'**
  String get pestControlVilla;

  /// No description provided for @sprayFullAntsInApartment.
  ///
  /// In ar, this message translates to:
  /// **'رش شامل لمكافحة نمل في الشقة'**
  String get sprayFullAntsInApartment;

  /// No description provided for @sprayFullAntsInVilla.
  ///
  /// In ar, this message translates to:
  /// **'رش شامل لمكافحة نمل في الفيلا'**
  String get sprayFullAntsInVilla;

  /// No description provided for @sprayFullBedbugsInApartment.
  ///
  /// In ar, this message translates to:
  /// **'رش شامل لمكافحة بق في الشقة'**
  String get sprayFullBedbugsInApartment;

  /// No description provided for @sprayFullBedbugsInVilla.
  ///
  /// In ar, this message translates to:
  /// **'رش شامل لمكافحة بق في الفيلا'**
  String get sprayFullBedbugsInVilla;

  /// No description provided for @sprayFullInApartment.
  ///
  /// In ar, this message translates to:
  /// **'رش شامل لمكافحة الصراصير في الشقة'**
  String get sprayFullInApartment;

  /// No description provided for @sprayFullInVilla.
  ///
  /// In ar, this message translates to:
  /// **'رش شامل لمكافحة الصراصير في الفيلا'**
  String get sprayFullInVilla;

  /// No description provided for @sprayFullMiceInApartment.
  ///
  /// In ar, this message translates to:
  /// **'رش شامل لمكافحة فئران في الشقة'**
  String get sprayFullMiceInApartment;

  /// No description provided for @sprayFullMiceInVilla.
  ///
  /// In ar, this message translates to:
  /// **'رش شامل لمكافحة فئران في الفيلا'**
  String get sprayFullMiceInVilla;

  /// No description provided for @sofaDeepCleaningTagline.
  ///
  /// In ar, this message translates to:
  /// **'التنظيف العميق الذي كانت تنتظره كنبتك'**
  String get sofaDeepCleaningTagline;

  /// No description provided for @sofaCleaningDetailedDescription.
  ///
  /// In ar, this message translates to:
  /// **'تنظيف بسيط للكنبة بالمكنسة شيء، لكن الغبار وحبيبات الرمل والبقع المخفية التي تتراكم داخل نسيج الكنبة شيء مختلف تماماً.\n\nيقوم متخصصو التنظيف المعتمدون لدينا بالوصول إليك مجهزين بالكامل والعمل على كل طبقة من الكنبة لإعادة الانتعاش واللون والراحة إليها.'**
  String get sofaCleaningDetailedDescription;

  /// No description provided for @inspectionFreeFully.
  ///
  /// In ar, this message translates to:
  /// **'معاينة مجانية بالكامل'**
  String get inspectionFreeFully;

  /// No description provided for @sofaInspectionSteps.
  ///
  /// In ar, this message translates to:
  /// **'فحص الكنبة لتحديد نوع القماش\nتحديد احتياجات التنظيف\nفحص الكنبة لتحديد نوع القماش\nتنظيف جاف بالمكنسة لإزالة الغبار والشعر والمخلفات\nتنظيف رطب بالشامبو باستخدام مواد متخصصة\nاستخراج البقع أثناء عملية الشامبو لمعالجتها\nمعالجة موضعية لاستخراج البقع العنيدة'**
  String get sofaInspectionSteps;

  /// No description provided for @postCleaningSofaDryingNotes.
  ///
  /// In ar, this message translates to:
  /// **'قد تظل الكنبة رطبة لمدة تصل إلى 12 ساعة بعد التنظيف.\nيعتمد وقت التجفيف على نوع القماش ودرجة التهوية في المكان.\nقد يصعب إزالة بعض البقع العنيدة جداً مثل بقع الحيوانات أو الدم أو الزيوت.\nسيقوم المختص بإرشادك إذا كانت بعض طرق التنظيف غير مناسبة لبعض أنواع الأقمشة.\nيرجى تغطية العناصر التي لا تشملها الخدمة أو لا يمكن تنظيفها.'**
  String get postCleaningSofaDryingNotes;

  /// No description provided for @noCommitmentAfterInspection.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد أي التزام بعد المعاينة'**
  String get noCommitmentAfterInspection;

  /// No description provided for @notSureGetFreeInspection.
  ///
  /// In ar, this message translates to:
  /// **'لست واثقاً! احصل على معاينة مجانية'**
  String get notSureGetFreeInspection;

  /// No description provided for @doneReceivedRequest.
  ///
  /// In ar, this message translates to:
  /// **'تم استلام طلب المعاينة'**
  String get doneReceivedRequest;

  /// No description provided for @companiesMosques.
  ///
  /// In ar, this message translates to:
  /// **'خدمات الشركات والمساجد'**
  String get companiesMosques;

  /// No description provided for @provideCleaningSanitizationOfficesMosquesDetermine.
  ///
  /// In ar, this message translates to:
  /// **'نقدم خدمات تنظيف وتعقيم للمكاتب والمساجد وفقاً لتحديد احتياجك بدقة وتقديم عرض سعر واضح بدون التزام.'**
  String get provideCleaningSanitizationOfficesMosquesDetermine;

  /// No description provided for @determineFinalAfterOnly.
  ///
  /// In ar, this message translates to:
  /// **'يتم تحديد السعر النهائي بعد المعاينة فقط'**
  String get determineFinalAfterOnly;

  /// No description provided for @upcoming.
  ///
  /// In ar, this message translates to:
  /// **'القادمة'**
  String get upcoming;

  /// No description provided for @previous.
  ///
  /// In ar, this message translates to:
  /// **'السابقة'**
  String get previous;

  /// No description provided for @scheduled.
  ///
  /// In ar, this message translates to:
  /// **'مجدولة'**
  String get scheduled;

  /// No description provided for @inProgress.
  ///
  /// In ar, this message translates to:
  /// **'قيد التنفيذ'**
  String get inProgress;

  /// No description provided for @completed.
  ///
  /// In ar, this message translates to:
  /// **'مكتملة'**
  String get completed;

  /// No description provided for @cancelled.
  ///
  /// In ar, this message translates to:
  /// **'ملغاة'**
  String get cancelled;

  /// No description provided for @viewDetails.
  ///
  /// In ar, this message translates to:
  /// **'عرض التفاصيل'**
  String get viewDetails;

  /// No description provided for @reschedule.
  ///
  /// In ar, this message translates to:
  /// **'إعادة جدولة'**
  String get reschedule;

  /// No description provided for @cancelBooking.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء الحجز'**
  String get cancelBooking;

  /// No description provided for @confirmCancel.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد الإلغاء'**
  String get confirmCancel;

  /// No description provided for @noUpcomingBookings.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد حجوزات قادمة'**
  String get noUpcomingBookings;

  /// No description provided for @noUpcomingBookingsDescription.
  ///
  /// In ar, this message translates to:
  /// **'احجز خدمتك الآن وحدد الموعد المناسب لك بكل سهولة.'**
  String get noUpcomingBookingsDescription;

  /// No description provided for @rebookNow.
  ///
  /// In ar, this message translates to:
  /// **'إعادة حجز'**
  String get rebookNow;

  /// No description provided for @confirmReschedule.
  ///
  /// In ar, this message translates to:
  /// **'إعادة الجدولة'**
  String get confirmReschedule;

  /// No description provided for @specialNotesOptional.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظات أو تعليمات خاصة (اختياري)'**
  String get specialNotesOptional;

  /// No description provided for @exampleHomeLocation.
  ///
  /// In ar, this message translates to:
  /// **'مثال : المنزل أمام المسجد..'**
  String get exampleHomeLocation;

  /// No description provided for @areYouSureCancel.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد من إلغاء الحجز؟'**
  String get areYouSureCancel;

  /// No description provided for @cancelWarning.
  ///
  /// In ar, this message translates to:
  /// **'سيتم إلغاء الحجز ولن يتم تنفيذ الخدمة في الوقت المحدد لها'**
  String get cancelWarning;

  /// No description provided for @cancelReasonOptional.
  ///
  /// In ar, this message translates to:
  /// **'سبب الإلغاء'**
  String get cancelReasonOptional;

  /// No description provided for @mentionCancelReason.
  ///
  /// In ar, this message translates to:
  /// **'اذكر سبب إلغاء الحجز'**
  String get mentionCancelReason;

  /// No description provided for @step.
  ///
  /// In ar, this message translates to:
  /// **'الخطوة'**
  String get step;

  /// No description provided for @ofText.
  ///
  /// In ar, this message translates to:
  /// **'من'**
  String get ofText;

  /// No description provided for @currentTotal.
  ///
  /// In ar, this message translates to:
  /// **'المجموع الحالي'**
  String get currentTotal;

  /// No description provided for @sharingUnavailable.
  ///
  /// In ar, this message translates to:
  /// **'المشاركة غير متاحة حالياً'**
  String get sharingUnavailable;

  /// No description provided for @addonsTitle.
  ///
  /// In ar, this message translates to:
  /// **'الإضافات'**
  String get addonsTitle;

  /// No description provided for @inspectionDescription.
  ///
  /// In ar, this message translates to:
  /// **'فريقنا جاهز لمساعدتك في اختيار الخدمة المناسبة بسهولة'**
  String get inspectionDescription;

  /// No description provided for @requestInspection.
  ///
  /// In ar, this message translates to:
  /// **'اطلب معاينة'**
  String get requestInspection;

  /// No description provided for @dateAndTimeTitle.
  ///
  /// In ar, this message translates to:
  /// **'التاريخ والوقت'**
  String get dateAndTimeTitle;

  /// No description provided for @chooseDay.
  ///
  /// In ar, this message translates to:
  /// **'اختر اليوم'**
  String get chooseDay;

  /// No description provided for @chooseTime.
  ///
  /// In ar, this message translates to:
  /// **'اختر وقت'**
  String get chooseTime;

  /// No description provided for @advancePaymentLabel.
  ///
  /// In ar, this message translates to:
  /// **'مقدمة'**
  String get advancePaymentLabel;

  /// No description provided for @cancellationPolicy.
  ///
  /// In ar, this message translates to:
  /// **'يمكنك إلغاء الحجز أو تعديله مجاناً قبل 5 ساعة من الموعد المقرر. في حال الإلغاء خلال أقل من 5 ساعة، سيتم تطبيق رسوم إلغاء بنسبة 25٪. عرض التفاصيل'**
  String get cancellationPolicy;

  /// No description provided for @saturday.
  ///
  /// In ar, this message translates to:
  /// **'السبت'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In ar, this message translates to:
  /// **'الأحد'**
  String get sunday;

  /// No description provided for @monday.
  ///
  /// In ar, this message translates to:
  /// **'الاثنين'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In ar, this message translates to:
  /// **'الثلاثاء'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In ar, this message translates to:
  /// **'الأربعاء'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In ar, this message translates to:
  /// **'الخميس'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In ar, this message translates to:
  /// **'الجمعة'**
  String get friday;

  /// No description provided for @addressTitle.
  ///
  /// In ar, this message translates to:
  /// **'العنوان'**
  String get addressTitle;

  /// No description provided for @specialInstructions.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظات أو تعليمات خاصة (اختياري)'**
  String get specialInstructions;

  /// No description provided for @savedAddressesTitle.
  ///
  /// In ar, this message translates to:
  /// **'عناويني المحفوظة'**
  String get savedAddressesTitle;

  /// No description provided for @detailsAdditionalOptional.
  ///
  /// In ar, this message translates to:
  /// **'تفاصيل إضافية (اختياري)'**
  String get detailsAdditionalOptional;

  /// No description provided for @specialInstructionsHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: اتصل أمام المسجد..'**
  String get specialInstructionsHint;

  /// No description provided for @bookingSummary.
  ///
  /// In ar, this message translates to:
  /// **'ملخص الحجز'**
  String get bookingSummary;

  /// No description provided for @houseCleaningTitle.
  ///
  /// In ar, this message translates to:
  /// **'تنظيف المنزل'**
  String get houseCleaningTitle;

  /// No description provided for @howManyHours.
  ///
  /// In ar, this message translates to:
  /// **'كم ساعة تريد عاملة / عاملة التنظيف؟'**
  String get howManyHours;

  /// No description provided for @regularWithCleaningAddOn.
  ///
  /// In ar, this message translates to:
  /// **'عادة + إضافة التنظيف'**
  String get regularWithCleaningAddOn;

  /// No description provided for @oneHour.
  ///
  /// In ar, this message translates to:
  /// **'ساعة'**
  String get oneHour;

  /// No description provided for @hours.
  ///
  /// In ar, this message translates to:
  /// **'ساعات'**
  String get hours;

  /// No description provided for @twoHours.
  ///
  /// In ar, this message translates to:
  /// **'ساعتين'**
  String get twoHours;

  /// No description provided for @hours3.
  ///
  /// In ar, this message translates to:
  /// **'3 ساعات'**
  String get hours3;

  /// No description provided for @hours4.
  ///
  /// In ar, this message translates to:
  /// **'4 ساعات'**
  String get hours4;

  /// No description provided for @hours5.
  ///
  /// In ar, this message translates to:
  /// **'5 ساعات'**
  String get hours5;

  /// No description provided for @howManyWorkers.
  ///
  /// In ar, this message translates to:
  /// **'كم عدد العاملات /العمال؟'**
  String get howManyWorkers;

  /// No description provided for @countRoomsKitchens.
  ///
  /// In ar, this message translates to:
  /// **'كم عدد الغرف / المطابخ؟'**
  String get countRoomsKitchens;

  /// No description provided for @oneRoom.
  ///
  /// In ar, this message translates to:
  /// **' غرفة ١'**
  String get oneRoom;

  /// No description provided for @twoRooms.
  ///
  /// In ar, this message translates to:
  /// **'غرفة ٢'**
  String get twoRooms;

  /// No description provided for @threeRooms.
  ///
  /// In ar, this message translates to:
  /// **'غرفة ٣'**
  String get threeRooms;

  /// No description provided for @fourRooms.
  ///
  /// In ar, this message translates to:
  /// **'غرفة ٤'**
  String get fourRooms;

  /// No description provided for @worker.
  ///
  /// In ar, this message translates to:
  /// **'عامل'**
  String get worker;

  /// No description provided for @placeSize.
  ///
  /// In ar, this message translates to:
  /// **'حجم المكان ؟'**
  String get placeSize;

  /// No description provided for @smallApartment.
  ///
  /// In ar, this message translates to:
  /// **'شقة صغيرة'**
  String get smallApartment;

  /// No description provided for @mediumApartment.
  ///
  /// In ar, this message translates to:
  /// **'شقة متوسطة'**
  String get mediumApartment;

  /// No description provided for @largeApartment.
  ///
  /// In ar, this message translates to:
  /// **'شقة كبيرة'**
  String get largeApartment;

  /// No description provided for @villa.
  ///
  /// In ar, this message translates to:
  /// **'فيلا'**
  String get villa;

  /// No description provided for @studio.
  ///
  /// In ar, this message translates to:
  /// **'استوديو'**
  String get studio;

  /// No description provided for @teamPreference.
  ///
  /// In ar, this message translates to:
  /// **'تفضيل الفريق؟'**
  String get teamPreference;

  /// No description provided for @femaleTeam.
  ///
  /// In ar, this message translates to:
  /// **'نسائي'**
  String get femaleTeam;

  /// No description provided for @maleTeam.
  ///
  /// In ar, this message translates to:
  /// **'رجالي'**
  String get maleTeam;

  /// No description provided for @noPreference.
  ///
  /// In ar, this message translates to:
  /// **'لا يهم'**
  String get noPreference;

  /// No description provided for @detailsFloors.
  ///
  /// In ar, this message translates to:
  /// **'تفاصيل الطوابق؟'**
  String get detailsFloors;

  /// No description provided for @ground.
  ///
  /// In ar, this message translates to:
  /// **'أرضي'**
  String get ground;

  /// No description provided for @first.
  ///
  /// In ar, this message translates to:
  /// **'أول'**
  String get first;

  /// No description provided for @second.
  ///
  /// In ar, this message translates to:
  /// **'ثاني'**
  String get second;

  /// No description provided for @sports.
  ///
  /// In ar, this message translates to:
  /// **'رياضي'**
  String get sports;

  /// No description provided for @cleaningKitchen.
  ///
  /// In ar, this message translates to:
  /// **'تنظيف مطبخ'**
  String get cleaningKitchen;

  /// No description provided for @cleaningWindows.
  ///
  /// In ar, this message translates to:
  /// **'تنظيف نوافذ'**
  String get cleaningWindows;

  /// No description provided for @cleaningBathroom.
  ///
  /// In ar, this message translates to:
  /// **'تنظيف حمام'**
  String get cleaningBathroom;

  /// No description provided for @polishingFloors.
  ///
  /// In ar, this message translates to:
  /// **'تلميع أرضيات'**
  String get polishingFloors;

  /// No description provided for @washingCurtains.
  ///
  /// In ar, this message translates to:
  /// **'غسيل ستائر'**
  String get washingCurtains;

  /// No description provided for @cleaningOven.
  ///
  /// In ar, this message translates to:
  /// **'تنظيف فرن'**
  String get cleaningOven;

  /// No description provided for @pillowsSleeping.
  ///
  /// In ar, this message translates to:
  /// **'وسادات نوم'**
  String get pillowsSleeping;

  /// No description provided for @chairsDining.
  ///
  /// In ar, this message translates to:
  /// **'كراسي طعام'**
  String get chairsDining;

  /// No description provided for @pillowsDecorative.
  ///
  /// In ar, this message translates to:
  /// **'وسادات للزينة'**
  String get pillowsDecorative;

  /// No description provided for @cockroaches.
  ///
  /// In ar, this message translates to:
  /// **'صراصير'**
  String get cockroaches;

  /// No description provided for @ants.
  ///
  /// In ar, this message translates to:
  /// **'نمل'**
  String get ants;

  /// No description provided for @bedbugs.
  ///
  /// In ar, this message translates to:
  /// **'بق'**
  String get bedbugs;

  /// No description provided for @mice.
  ///
  /// In ar, this message translates to:
  /// **'فئران'**
  String get mice;

  /// No description provided for @sofas.
  ///
  /// In ar, this message translates to:
  /// **'الكنب'**
  String get sofas;

  /// No description provided for @carpets.
  ///
  /// In ar, this message translates to:
  /// **'سجاد'**
  String get carpets;

  /// No description provided for @cleaningSofa.
  ///
  /// In ar, this message translates to:
  /// **'تنظيف الكنب'**
  String get cleaningSofa;

  /// No description provided for @cleaningSofaOnL.
  ///
  /// In ar, this message translates to:
  /// **'تنظيف الكنب على شكل حرف L'**
  String get cleaningSofaOnL;

  /// No description provided for @cleaningInsideHomeForCarpets.
  ///
  /// In ar, this message translates to:
  /// **'تنظيف احترافي للسجاد داخل المنزل'**
  String get cleaningInsideHomeForCarpets;

  /// No description provided for @cleaningInsideHomeForSofas.
  ///
  /// In ar, this message translates to:
  /// **'تنظيف احترافي للكنب داخل المنزل'**
  String get cleaningInsideHomeForSofas;

  /// No description provided for @serviceFrequency.
  ///
  /// In ar, this message translates to:
  /// **'تكرار الخدمة'**
  String get serviceFrequency;

  /// No description provided for @once.
  ///
  /// In ar, this message translates to:
  /// **'مرة واحدة'**
  String get once;

  /// No description provided for @weekly.
  ///
  /// In ar, this message translates to:
  /// **'أسبوعياً'**
  String get weekly;

  /// No description provided for @twoWeeks.
  ///
  /// In ar, this message translates to:
  /// **'أسبوعين'**
  String get twoWeeks;

  /// No description provided for @monthly.
  ///
  /// In ar, this message translates to:
  /// **'شهرياً'**
  String get monthly;

  /// No description provided for @countTimesInWeek.
  ///
  /// In ar, this message translates to:
  /// **'عدد مرات في الأسبوع'**
  String get countTimesInWeek;

  /// No description provided for @discountUpTo10.
  ///
  /// In ar, this message translates to:
  /// **'خصم يصل الى 10%'**
  String get discountUpTo10;

  /// No description provided for @discountUpTo20.
  ///
  /// In ar, this message translates to:
  /// **'خصم يصل الى 20%'**
  String get discountUpTo20;

  /// No description provided for @discountUpTo70.
  ///
  /// In ar, this message translates to:
  /// **'خصم يصل لـ %70'**
  String get discountUpTo70;

  /// No description provided for @fivePercentDiscount.
  ///
  /// In ar, this message translates to:
  /// **'خصم 5٪'**
  String get fivePercentDiscount;

  /// No description provided for @sevenPercentDiscount.
  ///
  /// In ar, this message translates to:
  /// **'خصم 7%'**
  String get sevenPercentDiscount;

  /// No description provided for @discountUpToTwelvePercent.
  ///
  /// In ar, this message translates to:
  /// **'خصم يصل إلى 12%'**
  String get discountUpToTwelvePercent;

  /// No description provided for @discountUpToTwentyFivePercent.
  ///
  /// In ar, this message translates to:
  /// **'خصم يصل إلى 25%'**
  String get discountUpToTwentyFivePercent;

  /// No description provided for @noAppointmentsAvailable.
  ///
  /// In ar, this message translates to:
  /// **'لا تتوفر مواعيد'**
  String get noAppointmentsAvailable;

  /// No description provided for @noAppointmentsDesc.
  ///
  /// In ar, this message translates to:
  /// **'عذراً، جميع المواعيد محجوزة لليوم المختار، إليك بعض الاقتراحات البديلة:'**
  String get noAppointmentsDesc;

  /// No description provided for @viewAllAppointments.
  ///
  /// In ar, this message translates to:
  /// **'عرض جميع المواعيد'**
  String get viewAllAppointments;

  /// No description provided for @bookingConfirmedPopupDesc.
  ///
  /// In ar, this message translates to:
  /// **'تم تأكيد حجزك وسيتم تذكيرك قبل موعد الزيارة بساعة'**
  String get bookingConfirmedPopupDesc;

  /// No description provided for @bookingNumber.
  ///
  /// In ar, this message translates to:
  /// **'رقم الحجز'**
  String get bookingNumber;

  /// No description provided for @bookingDetails.
  ///
  /// In ar, this message translates to:
  /// **'تفاصيل الحجز'**
  String get bookingDetails;

  /// No description provided for @doneConfirmBooking.
  ///
  /// In ar, this message translates to:
  /// **'تم تأكيد الحجز'**
  String get doneConfirmBooking;

  /// No description provided for @doneCopyNumberBooking.
  ///
  /// In ar, this message translates to:
  /// **'تم نسخ رقم الحجز'**
  String get doneCopyNumberBooking;

  /// No description provided for @payment.
  ///
  /// In ar, this message translates to:
  /// **'الدفع'**
  String get payment;

  /// No description provided for @discountCode.
  ///
  /// In ar, this message translates to:
  /// **'كود الخصم'**
  String get discountCode;

  /// No description provided for @enterDiscountCode.
  ///
  /// In ar, this message translates to:
  /// **'أدخل كود الخصم'**
  String get enterDiscountCode;

  /// No description provided for @securePaymentNote.
  ///
  /// In ar, this message translates to:
  /// **'جميع المدفوعات مشفرة لضمان أعلى مستويات الأمان والخصوصية.'**
  String get securePaymentNote;

  /// No description provided for @defaultCard.
  ///
  /// In ar, this message translates to:
  /// **'افتراضي'**
  String get defaultCard;

  /// No description provided for @addNewCard.
  ///
  /// In ar, this message translates to:
  /// **'+ إضافة بطاقة جديدة'**
  String get addNewCard;

  /// No description provided for @paymentSummary.
  ///
  /// In ar, this message translates to:
  /// **'ملخص الدفع'**
  String get paymentSummary;

  /// No description provided for @totalIncludingVat.
  ///
  /// In ar, this message translates to:
  /// **'المجموع (شامل الضريبة المضافة)'**
  String get totalIncludingVat;

  /// No description provided for @totalLabel.
  ///
  /// In ar, this message translates to:
  /// **'المجموع'**
  String get totalLabel;

  /// No description provided for @totalPrice.
  ///
  /// In ar, this message translates to:
  /// **'السعر الاجمالي'**
  String get totalPrice;

  /// No description provided for @afterCompletionService.
  ///
  /// In ar, this message translates to:
  /// **'ادفع نقداً بعد إتمام الخدمة'**
  String get afterCompletionService;

  /// No description provided for @cardCreditMada.
  ///
  /// In ar, this message translates to:
  /// **'بطاقة الائتمان / مدى'**
  String get cardCreditMada;

  /// No description provided for @cardsSaved.
  ///
  /// In ar, this message translates to:
  /// **'البطاقات المحفوظة'**
  String get cardsSaved;

  /// No description provided for @mada.
  ///
  /// In ar, this message translates to:
  /// **'مدى'**
  String get mada;

  /// No description provided for @paymentOnService.
  ///
  /// In ar, this message translates to:
  /// **'الدفع عند الخدمة'**
  String get paymentOnService;

  /// No description provided for @changeMethodPayment.
  ///
  /// In ar, this message translates to:
  /// **'تغيير طريقة الدفع'**
  String get changeMethodPayment;

  /// No description provided for @paymentFailedDescriptionAlt.
  ///
  /// In ar, this message translates to:
  /// **'نعتذر، لم نتمكن من معالجة عملية الدفع الخاصة بك. يرجى التحقق من بيانات البطاقة أو المحاولة مرة أخرى.'**
  String get paymentFailedDescriptionAlt;

  /// No description provided for @noSavedPaymentMethods.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد طرق دفع محفوظة'**
  String get noSavedPaymentMethods;

  /// No description provided for @addPaymentMethodDesc.
  ///
  /// In ar, this message translates to:
  /// **'قم بإضافة وسيلة دفع لتسهيل إتمام الطلبات بسرعة وأمان.'**
  String get addPaymentMethodDesc;

  /// No description provided for @addPaymentMethodBtn.
  ///
  /// In ar, this message translates to:
  /// **'إضافة وسيلة دفع'**
  String get addPaymentMethodBtn;

  /// No description provided for @defaultPaymentNotice.
  ///
  /// In ar, this message translates to:
  /// **'سيتم استخدام وسيلة الدفع الافتراضية تلقائياً لجميع الحجوزات القادمة. يمكنك تغيير هذا الإعداد في أي وقت قبل إتمام عملية الدفع.'**
  String get defaultPaymentNotice;

  /// No description provided for @cardNumberLabel.
  ///
  /// In ar, this message translates to:
  /// **'رقم البطاقة'**
  String get cardNumberLabel;

  /// No description provided for @cardHolderLabel.
  ///
  /// In ar, this message translates to:
  /// **'اسم حامل البطاقة'**
  String get cardHolderLabel;

  /// No description provided for @cardHolderPlaceholder.
  ///
  /// In ar, this message translates to:
  /// **'ادخل الاسم كما هو على البطاقة'**
  String get cardHolderPlaceholder;

  /// No description provided for @expiryDateLabel.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ الانتهاء'**
  String get expiryDateLabel;

  /// No description provided for @cvvLabel.
  ///
  /// In ar, this message translates to:
  /// **'رمز الأمان'**
  String get cvvLabel;

  /// No description provided for @saveCardForLater.
  ///
  /// In ar, this message translates to:
  /// **'حفظ البطاقة لاستخدامها لاحقاً'**
  String get saveCardForLater;

  /// No description provided for @paymentFailed.
  ///
  /// In ar, this message translates to:
  /// **'فشل الدفع'**
  String get paymentFailed;

  /// No description provided for @trackOrder.
  ///
  /// In ar, this message translates to:
  /// **'تتبع الطلب'**
  String get trackOrder;

  /// No description provided for @onTheWay.
  ///
  /// In ar, this message translates to:
  /// **'في الطريق'**
  String get onTheWay;

  /// No description provided for @eta5Mins.
  ///
  /// In ar, this message translates to:
  /// **'الوصول المتوقع خلال 5 دقائق'**
  String get eta5Mins;

  /// No description provided for @serviceStatus.
  ///
  /// In ar, this message translates to:
  /// **'حالة الخدمة'**
  String get serviceStatus;

  /// No description provided for @bookingConfirmedStatus.
  ///
  /// In ar, this message translates to:
  /// **'تم تأكيد الحجز'**
  String get bookingConfirmedStatus;

  /// No description provided for @teamOnTheWay.
  ///
  /// In ar, this message translates to:
  /// **'الفريق في الطريق إليك'**
  String get teamOnTheWay;

  /// No description provided for @serviceInProgress.
  ///
  /// In ar, this message translates to:
  /// **'الخدمة قيد التنفيذ'**
  String get serviceInProgress;

  /// No description provided for @serviceCompletedStatus.
  ///
  /// In ar, this message translates to:
  /// **'تم الانتهاء'**
  String get serviceCompletedStatus;

  /// No description provided for @teamLeader.
  ///
  /// In ar, this message translates to:
  /// **'قائد الفريق'**
  String get teamLeader;

  /// No description provided for @completedService.
  ///
  /// In ar, this message translates to:
  /// **'اكتملت الخدمة'**
  String get completedService;

  /// No description provided for @summaryWorkCompleted.
  ///
  /// In ar, this message translates to:
  /// **'ملخص العمل المنجز'**
  String get summaryWorkCompleted;

  /// No description provided for @timeSpent.
  ///
  /// In ar, this message translates to:
  /// **'الوقت المستغرق'**
  String get timeSpent;

  /// No description provided for @expectedArrival.
  ///
  /// In ar, this message translates to:
  /// **'الوصول المتوقع'**
  String get expectedArrival;

  /// No description provided for @thankYouForChoosingUs.
  ///
  /// In ar, this message translates to:
  /// **'شكراً لاختيارك لنا'**
  String get thankYouForChoosingUs;

  /// No description provided for @serviceExecutedSuccessfully.
  ///
  /// In ar, this message translates to:
  /// **'تم تنفيذ خدمة التنظيف العميق لمنزلك بنجاح ونتمنى رضاك وجودة الخدمة المقدمة.'**
  String get serviceExecutedSuccessfully;

  /// No description provided for @serviceType.
  ///
  /// In ar, this message translates to:
  /// **'نوع الخدمة'**
  String get serviceType;

  /// No description provided for @typePlace.
  ///
  /// In ar, this message translates to:
  /// **'نوع المكان'**
  String get typePlace;

  /// No description provided for @namePlace.
  ///
  /// In ar, this message translates to:
  /// **'اسم المكان'**
  String get namePlace;

  /// No description provided for @areaPlace.
  ///
  /// In ar, this message translates to:
  /// **'مساحة المكان'**
  String get areaPlace;

  /// No description provided for @roomsCompletedDesc.
  ///
  /// In ar, this message translates to:
  /// **'شامل الصالة، المطبخ، وغرف النوم مع التعقيم الكامل.'**
  String get roomsCompletedDesc;

  /// No description provided for @trackBooking.
  ///
  /// In ar, this message translates to:
  /// **'تتبع الحجز'**
  String get trackBooking;

  /// No description provided for @rateExperience.
  ///
  /// In ar, this message translates to:
  /// **'قيم تجربتك'**
  String get rateExperience;

  /// No description provided for @serviceRating.
  ///
  /// In ar, this message translates to:
  /// **'تقييم الخدمة'**
  String get serviceRating;

  /// No description provided for @teamRating.
  ///
  /// In ar, this message translates to:
  /// **'تقييم الفريق'**
  String get teamRating;

  /// No description provided for @rating.
  ///
  /// In ar, this message translates to:
  /// **' ملاحظاتك'**
  String get rating;

  /// No description provided for @teamRatingQuestion.
  ///
  /// In ar, this message translates to:
  /// **'كيف كانت تجربتك مع فريق \"ابراهيم محمد\" اليوم؟'**
  String get teamRatingQuestion;

  /// No description provided for @addYourNotesHere.
  ///
  /// In ar, this message translates to:
  /// **'أضف ملاحظاتك هنا...'**
  String get addYourNotesHere;

  /// No description provided for @levelOfServiceRatingQuestion.
  ///
  /// In ar, this message translates to:
  /// **'كيف كانت تجربتك مع مستوى الخدمة اليوم؟'**
  String get levelOfServiceRatingQuestion;

  /// No description provided for @submitRating.
  ///
  /// In ar, this message translates to:
  /// **'إرسال التقييم'**
  String get submitRating;

  /// No description provided for @forRating.
  ///
  /// In ar, this message translates to:
  /// **'شكراً لتقييمك'**
  String get forRating;

  /// No description provided for @ratingHelpsImprove.
  ///
  /// In ar, this message translates to:
  /// **'رأيك يساعدنا على تحسين الخدمة'**
  String get ratingHelpsImprove;

  /// No description provided for @favorites.
  ///
  /// In ar, this message translates to:
  /// **'المفضلات'**
  String get favorites;

  /// No description provided for @noFavoritesYet.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد خدمات مفضلة حتى الآن'**
  String get noFavoritesYet;

  /// No description provided for @saveServicesToAccessLater.
  ///
  /// In ar, this message translates to:
  /// **'قم بحفظ الخدمات التي تعجبك للوصول إليها بسرعة لاحقًا.'**
  String get saveServicesToAccessLater;

  /// No description provided for @editProfile.
  ///
  /// In ar, this message translates to:
  /// **' الملف الشخصي'**
  String get editProfile;

  /// No description provided for @nameLabel.
  ///
  /// In ar, this message translates to:
  /// **'الاسم'**
  String get nameLabel;

  /// No description provided for @phoneLabel.
  ///
  /// In ar, this message translates to:
  /// **'الهاتف'**
  String get phoneLabel;

  /// No description provided for @emailLabel.
  ///
  /// In ar, this message translates to:
  /// **'البريد الإلكتروني'**
  String get emailLabel;

  /// No description provided for @deleteAccountBtn.
  ///
  /// In ar, this message translates to:
  /// **'حذف الحساب'**
  String get deleteAccountBtn;

  /// No description provided for @footerHint.
  ///
  /// In ar, this message translates to:
  /// **'سيتم استخدام هذه المعلومات للتواصل معك بشأن حجوزاتك والخدمات المتاحة، ولن يتم مشاركتها بشكل عام.'**
  String get footerHint;

  /// No description provided for @deleteAccountHeader.
  ///
  /// In ar, this message translates to:
  /// **'حذف الحساب'**
  String get deleteAccountHeader;

  /// No description provided for @deleteWarningTitle.
  ///
  /// In ar, this message translates to:
  /// **'حذف الحساب نهائياً!'**
  String get deleteWarningTitle;

  /// No description provided for @deleteWarningDesc.
  ///
  /// In ar, this message translates to:
  /// **'سيؤدي حذف حسابك إلى إزالة بياناتك الشخصية والعناوين المحفوظة وسجل الطلبات والإحصاءات بشكل نهائي.'**
  String get deleteWarningDesc;

  /// No description provided for @rule1Title.
  ///
  /// In ar, this message translates to:
  /// **'لا يمكن التراجع عن هذا الإجراء بعد التأكيد'**
  String get rule1Title;

  /// No description provided for @rule1Desc.
  ///
  /// In ar, this message translates to:
  /// **'سيتم حذف حسابك وجميع بياناتك بشكل دائم.'**
  String get rule1Desc;

  /// No description provided for @rule2Title.
  ///
  /// In ar, this message translates to:
  /// **'يجب إنهاء أو إلغاء جميع الطلبات النشطة'**
  String get rule2Title;

  /// No description provided for @rule2Desc.
  ///
  /// In ar, this message translates to:
  /// **'لا يمكنك حذف الحساب ولديك طلبات قيد التنفيذ.'**
  String get rule2Desc;

  /// No description provided for @rule3Title.
  ///
  /// In ar, this message translates to:
  /// **'سيتم إلغاء أي اشتراكات أو باقات مفعولة'**
  String get rule3Title;

  /// No description provided for @rule3Desc.
  ///
  /// In ar, this message translates to:
  /// **'جميع الاشتراكات أو الباقات المدفوعة المرتبطة بحسابك سيتم إلغاؤها.'**
  String get rule3Desc;

  /// No description provided for @rule4Title.
  ///
  /// In ar, this message translates to:
  /// **'قد يتم الاحتفاظ ببعض البيانات لأغراض قانونية'**
  String get rule4Title;

  /// No description provided for @rule4Desc.
  ///
  /// In ar, this message translates to:
  /// **'مثل بيانات الفواتير والمعاملات وفقاً للأنظمة واللوائح المعمول بها.'**
  String get rule4Desc;

  /// No description provided for @confirmDeleteHint.
  ///
  /// In ar, this message translates to:
  /// **'لتأكيد حذف الحساب يرجى كتابة كلمة ('**
  String get confirmDeleteHint;

  /// No description provided for @deleteConfirmWord.
  ///
  /// In ar, this message translates to:
  /// **'حذف'**
  String get deleteConfirmWord;

  /// No description provided for @confirmFieldHint.
  ///
  /// In ar, this message translates to:
  /// **'كلمة التأكيد غير صحيحة'**
  String get confirmFieldHint;

  /// No description provided for @deleteConfirmBtn.
  ///
  /// In ar, this message translates to:
  /// **'حذف الحساب نهائياً'**
  String get deleteConfirmBtn;

  /// No description provided for @cannotDeleteTitle.
  ///
  /// In ar, this message translates to:
  /// **'لا يمكن حذف الحساب'**
  String get cannotDeleteTitle;

  /// No description provided for @cannotDeleteDesc.
  ///
  /// In ar, this message translates to:
  /// **'لديك طلبات أو باقات نشطة، يرجى إنهاء أو إلغاء المعاملات النشطة أولاً ثم إعادة المحاولة.'**
  String get cannotDeleteDesc;

  /// No description provided for @myAddresses.
  ///
  /// In ar, this message translates to:
  /// **'العناوين'**
  String get myAddresses;

  /// No description provided for @mySubscriptions.
  ///
  /// In ar, this message translates to:
  /// **'اشتراكاتي'**
  String get mySubscriptions;

  /// No description provided for @paymentMethods.
  ///
  /// In ar, this message translates to:
  /// **'طرق الدفع'**
  String get paymentMethods;

  /// No description provided for @settings.
  ///
  /// In ar, this message translates to:
  /// **'الإعدادات'**
  String get settings;

  /// No description provided for @contactUs.
  ///
  /// In ar, this message translates to:
  /// **'تواصل معنا'**
  String get contactUs;

  /// No description provided for @changePassword.
  ///
  /// In ar, this message translates to:
  /// **'تغيير كلمة المرور'**
  String get changePassword;

  /// No description provided for @privacy.
  ///
  /// In ar, this message translates to:
  /// **'الخصوصية'**
  String get privacy;

  /// No description provided for @help.
  ///
  /// In ar, this message translates to:
  /// **'المساعدة'**
  String get help;

  /// No description provided for @language.
  ///
  /// In ar, this message translates to:
  /// **'اللغة'**
  String get language;

  /// No description provided for @arabic.
  ///
  /// In ar, this message translates to:
  /// **'العربية'**
  String get arabic;

  /// No description provided for @bookingNotifications.
  ///
  /// In ar, this message translates to:
  /// **'إشعارات الحجز'**
  String get bookingNotifications;

  /// No description provided for @logout.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الخروج'**
  String get logout;

  /// No description provided for @logoutContent.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد أنك تريد تسجيل الخروج من حسابك؟ '**
  String get logoutContent;

  /// No description provided for @helpCenter.
  ///
  /// In ar, this message translates to:
  /// **'مركز المساعدة'**
  String get helpCenter;

  /// No description provided for @faq.
  ///
  /// In ar, this message translates to:
  /// **'الأسئلة الشائعة'**
  String get faq;

  /// No description provided for @technicalSupport.
  ///
  /// In ar, this message translates to:
  /// **'الدعم الفني'**
  String get technicalSupport;

  /// No description provided for @newIssue.
  ///
  /// In ar, this message translates to:
  /// **'مشكلة جديدة  +'**
  String get newIssue;

  /// No description provided for @open.
  ///
  /// In ar, this message translates to:
  /// **'مفتوح'**
  String get open;

  /// No description provided for @resolved.
  ///
  /// In ar, this message translates to:
  /// **'تم الحل'**
  String get resolved;

  /// No description provided for @ticketPrefix.
  ///
  /// In ar, this message translates to:
  /// **'TKT.'**
  String get ticketPrefix;

  /// No description provided for @careTechnician.
  ///
  /// In ar, this message translates to:
  /// **'فني العناية'**
  String get careTechnician;

  /// No description provided for @faqIntro.
  ///
  /// In ar, this message translates to:
  /// **'يمكنك اختيار الخدمة المناسبة، تحديد العنوان والموعد، ثم تأكيد الطلب والدفع مباشرة من التطبيق أو اطلب معاينة وسيتواصل معك الفريق المختص مجاناً.'**
  String get faqIntro;

  /// No description provided for @faqModifyBooking.
  ///
  /// In ar, this message translates to:
  /// **'هل يمكن تعديل أو إلغاء الحجز؟'**
  String get faqModifyBooking;

  /// No description provided for @faqOrderStatus.
  ///
  /// In ar, this message translates to:
  /// **'كيف أعرف حالة طلبي؟'**
  String get faqOrderStatus;

  /// No description provided for @faqPaymentMethods.
  ///
  /// In ar, this message translates to:
  /// **'ما طرق الدفع المتوفرة؟'**
  String get faqPaymentMethods;

  /// No description provided for @faqProblemDuringService.
  ///
  /// In ar, this message translates to:
  /// **'ماذا أفعل إذا واجهت مشكلة أثناء الخدمة؟'**
  String get faqProblemDuringService;

  /// No description provided for @faqQ1.
  ///
  /// In ar, this message translates to:
  /// **'كيف يمكنني حجز خدمة؟'**
  String get faqQ1;

  /// No description provided for @faqQ4.
  ///
  /// In ar, this message translates to:
  /// **'كيف يمكنني التواصل مع الدعم الفني؟'**
  String get faqQ4;

  /// No description provided for @readOnlyChat.
  ///
  /// In ar, this message translates to:
  /// **'هذه المحادثة للقراءة فقط'**
  String get readOnlyChat;

  /// No description provided for @reopenTicket.
  ///
  /// In ar, this message translates to:
  /// **'إعادة فتح التذكرة'**
  String get reopenTicket;

  /// No description provided for @writeYourMessage.
  ///
  /// In ar, this message translates to:
  /// **'اكتب رسالتك...'**
  String get writeYourMessage;

  /// No description provided for @newIssueTitle.
  ///
  /// In ar, this message translates to:
  /// **'مشكلة جديدة'**
  String get newIssueTitle;

  /// No description provided for @issueTitleLabel.
  ///
  /// In ar, this message translates to:
  /// **'عنوان المشكلة*'**
  String get issueTitleLabel;

  /// No description provided for @issueTitleHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال : مشكلة في خدمة التنظيف'**
  String get issueTitleHint;

  /// No description provided for @orderNumberLabel.
  ///
  /// In ar, this message translates to:
  /// **'رقم الطلب (اختياري)'**
  String get orderNumberLabel;

  /// No description provided for @issueDescLabel.
  ///
  /// In ar, this message translates to:
  /// **'وصف المشكلة *'**
  String get issueDescLabel;

  /// No description provided for @issueDescHint.
  ///
  /// In ar, this message translates to:
  /// **'اشرح مشكلتك بالتفصيل.....'**
  String get issueDescHint;

  /// No description provided for @writeAnyNotesHelpUsUnderstandYourNeed.
  ///
  /// In ar, this message translates to:
  /// **'اكتب أي ملاحظات تساعدنا نفهم احتياجك...'**
  String get writeAnyNotesHelpUsUnderstandYourNeed;

  /// No description provided for @active.
  ///
  /// In ar, this message translates to:
  /// **'نشط'**
  String get active;

  /// No description provided for @online.
  ///
  /// In ar, this message translates to:
  /// **'متصل'**
  String get online;

  /// No description provided for @contactInfoLabel.
  ///
  /// In ar, this message translates to:
  /// **'معلومات التواصل'**
  String get contactInfoLabel;

  /// No description provided for @customerServiceNumberLabel.
  ///
  /// In ar, this message translates to:
  /// **'رقم خدمة العملاء'**
  String get customerServiceNumberLabel;

  /// No description provided for @emailAddressLabel.
  ///
  /// In ar, this message translates to:
  /// **'البريد الإلكتروني'**
  String get emailAddressLabel;

  /// No description provided for @privacyConfidentialityNote.
  ///
  /// In ar, this message translates to:
  /// **'جميع بياناتك وآراؤك تُعامل بسرية تامة ولا تُشارك مع أي طرف ثالث.'**
  String get privacyConfidentialityNote;

  /// No description provided for @currentSubscriptions.
  ///
  /// In ar, this message translates to:
  /// **'الحالية'**
  String get currentSubscriptions;

  /// No description provided for @previousSubscriptions.
  ///
  /// In ar, this message translates to:
  /// **'السابقة'**
  String get previousSubscriptions;

  /// No description provided for @noActiveSubscriptions.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد اشتراكات نشطة'**
  String get noActiveSubscriptions;

  /// No description provided for @subscribePackagesDesc.
  ///
  /// In ar, this message translates to:
  /// **'اشترك في إحدى الباقات لتوفير الوقت والحصول على زيارات منتظمة بسهولة.'**
  String get subscribePackagesDesc;

  /// No description provided for @browsePackagesBtn.
  ///
  /// In ar, this message translates to:
  /// **'استعراض الباقات'**
  String get browsePackagesBtn;

  /// No description provided for @manageSubscription.
  ///
  /// In ar, this message translates to:
  /// **'إدارة الاشتراك'**
  String get manageSubscription;

  /// No description provided for @activeStatus.
  ///
  /// In ar, this message translates to:
  /// **'نشط'**
  String get activeStatus;

  /// No description provided for @pausedStatus.
  ///
  /// In ar, this message translates to:
  /// **'موقوف'**
  String get pausedStatus;

  /// No description provided for @endedStatus.
  ///
  /// In ar, this message translates to:
  /// **'منتهي'**
  String get endedStatus;

  /// No description provided for @subscriptionTypeLabel.
  ///
  /// In ar, this message translates to:
  /// **'نوع الاشتراك'**
  String get subscriptionTypeLabel;

  /// No description provided for @nextVisitLabel.
  ///
  /// In ar, this message translates to:
  /// **'الزيارة القادمة'**
  String get nextVisitLabel;

  /// No description provided for @timeLabel.
  ///
  /// In ar, this message translates to:
  /// **'الوقت'**
  String get timeLabel;

  /// No description provided for @priceLabel.
  ///
  /// In ar, this message translates to:
  /// **'السعر'**
  String get priceLabel;

  /// No description provided for @monthlyPriceSuffix.
  ///
  /// In ar, this message translates to:
  /// **'ر.ق / شهرياً'**
  String get monthlyPriceSuffix;

  /// No description provided for @viewVisits.
  ///
  /// In ar, this message translates to:
  /// **'عرض الزيارات'**
  String get viewVisits;

  /// No description provided for @viewVisitsDesc.
  ///
  /// In ar, this message translates to:
  /// **'عرض المواعيد القادمة وسجل الزيارات'**
  String get viewVisitsDesc;

  /// No description provided for @pauseTemporarily.
  ///
  /// In ar, this message translates to:
  /// **'إيقاف مؤقت'**
  String get pauseTemporarily;

  /// No description provided for @pauseTemporarilyDesc.
  ///
  /// In ar, this message translates to:
  /// **'إيقاف الاشتراك لفترة مؤقتة'**
  String get pauseTemporarilyDesc;

  /// No description provided for @changePackage.
  ///
  /// In ar, this message translates to:
  /// **'تغيير الباقة'**
  String get changePackage;

  /// No description provided for @changePackageDesc.
  ///
  /// In ar, this message translates to:
  /// **'تغيير الباقة الحالية لباقة أخرى'**
  String get changePackageDesc;

  /// No description provided for @cancelSubscription.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء الاشتراك'**
  String get cancelSubscription;

  /// No description provided for @cancelSubscriptionDesc.
  ///
  /// In ar, this message translates to:
  /// **'إيقاف الاشتراك نهائياً'**
  String get cancelSubscriptionDesc;

  /// No description provided for @reactivateBtn.
  ///
  /// In ar, this message translates to:
  /// **'إعادة التفعيل'**
  String get reactivateBtn;

  /// No description provided for @subscribeAgainBtn.
  ///
  /// In ar, this message translates to:
  /// **'اشترك مرة أخرى'**
  String get subscribeAgainBtn;

  /// No description provided for @subscriptionPausedMsg.
  ///
  /// In ar, this message translates to:
  /// **'تم إيقاف الاشتراك مؤقتاً'**
  String get subscriptionPausedMsg;

  /// No description provided for @pausePopupTitle.
  ///
  /// In ar, this message translates to:
  /// **'إيقاف الاشتراك مؤقتاً'**
  String get pausePopupTitle;

  /// No description provided for @pausePopupDesc.
  ///
  /// In ar, this message translates to:
  /// **'لن يتم جدولة أي زيارات أثناء فترة الإيقاف يمكنك إعادة تفعيلة في أي وقت'**
  String get pausePopupDesc;

  /// No description provided for @confirmPauseBtn.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد الإيقاف'**
  String get confirmPauseBtn;

  /// No description provided for @cancelPopupTitle.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء الاشتراك'**
  String get cancelPopupTitle;

  /// No description provided for @cancelPopupDesc.
  ///
  /// In ar, this message translates to:
  /// **'سيتم إلغاء جميع الزيارات القادمة لن تتمكن من استئناف الاشتراك بعد إلغائه'**
  String get cancelPopupDesc;

  /// No description provided for @myVisits.
  ///
  /// In ar, this message translates to:
  /// **'زياراتي'**
  String get myVisits;

  /// No description provided for @policiesAndRules.
  ///
  /// In ar, this message translates to:
  /// **'القوانين والسياسات'**
  String get policiesAndRules;

  /// No description provided for @privacyPolicyLabel.
  ///
  /// In ar, this message translates to:
  /// **'سياسة الخصوصية'**
  String get privacyPolicyLabel;

  /// No description provided for @termsAndConditionsLabel.
  ///
  /// In ar, this message translates to:
  /// **'الشروط والأحكام'**
  String get termsAndConditionsLabel;

  /// No description provided for @privacyPolicyIntro.
  ///
  /// In ar, this message translates to:
  /// **'في خدمتنا، خصوصيتك تأتي أولًا. توضح هذه السياسة كيفية جمع بياناتك الشخصية واستخدامها وحمايتها عند استخدامك لتطبيق حجز الخدمات المنزلية. نلتزم بحماية خصوصيتك والشفافية الكاملة حول بياناتك.'**
  String get privacyPolicyIntro;

  /// No description provided for @collectedData.
  ///
  /// In ar, this message translates to:
  /// **'البيانات التي نجمعها'**
  String get collectedData;

  /// No description provided for @dataUsage.
  ///
  /// In ar, this message translates to:
  /// **'كيفية استخدام البيانات'**
  String get dataUsage;

  /// No description provided for @dataProtection.
  ///
  /// In ar, this message translates to:
  /// **'حماية البيانات'**
  String get dataProtection;

  /// No description provided for @dataSharing.
  ///
  /// In ar, this message translates to:
  /// **'مشاركة البيانات'**
  String get dataSharing;

  /// No description provided for @acceptanceOfTerms.
  ///
  /// In ar, this message translates to:
  /// **'القبول بالشروط'**
  String get acceptanceOfTerms;

  /// No description provided for @policyModifications.
  ///
  /// In ar, this message translates to:
  /// **'التعديلات على السياسة'**
  String get policyModifications;

  /// No description provided for @termsIntro.
  ///
  /// In ar, this message translates to:
  /// **'باستخدامك لتطبيق وخدمات منصة الخدمات المنزلية، فإنك تقر وتوافق على الالتزام بهذه الشروط والأحكام. إذا كنت لا توافق على أي جزء من هذه الشروط، يرجى عدم استخدام الخدمة.'**
  String get termsIntro;

  /// No description provided for @services.
  ///
  /// In ar, this message translates to:
  /// **'الخدمات'**
  String get services;

  /// No description provided for @bookings.
  ///
  /// In ar, this message translates to:
  /// **'الحجوزات'**
  String get bookings;

  /// No description provided for @serviceCancellation.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء الخدمة'**
  String get serviceCancellation;

  /// No description provided for @responsibility.
  ///
  /// In ar, this message translates to:
  /// **'المسؤولية'**
  String get responsibility;

  /// No description provided for @companyResponsibilities.
  ///
  /// In ar, this message translates to:
  /// **'مسؤوليات الشركة'**
  String get companyResponsibilities;

  /// No description provided for @accounts.
  ///
  /// In ar, this message translates to:
  /// **'الحسابات'**
  String get accounts;

  /// No description provided for @modifications.
  ///
  /// In ar, this message translates to:
  /// **'التعديلات'**
  String get modifications;

  /// No description provided for @profileName.
  ///
  /// In ar, this message translates to:
  /// **'Ahmed Ibrahim'**
  String get profileName;

  /// No description provided for @phoneNumber.
  ///
  /// In ar, this message translates to:
  /// **'+974 5123 4567'**
  String get phoneNumber;

  /// No description provided for @emailValue.
  ///
  /// In ar, this message translates to:
  /// **'ahmed.m@gmail.com'**
  String get emailValue;

  /// No description provided for @ibrahimMohamed.
  ///
  /// In ar, this message translates to:
  /// **'إبراهيم محمد'**
  String get ibrahimMohamed;

  /// No description provided for @ibrahimInitial.
  ///
  /// In ar, this message translates to:
  /// **'إ'**
  String get ibrahimInitial;

  /// No description provided for @promoCode.
  ///
  /// In ar, this message translates to:
  /// **'CLEAN15'**
  String get promoCode;

  /// No description provided for @price120.
  ///
  /// In ar, this message translates to:
  /// **'120'**
  String get price120;

  /// No description provided for @customerServiceNumber.
  ///
  /// In ar, this message translates to:
  /// **'+974 3000 0000'**
  String get customerServiceNumber;

  /// No description provided for @supportEmailAddress.
  ///
  /// In ar, this message translates to:
  /// **'support@migroup.com'**
  String get supportEmailAddress;

  /// No description provided for @ticketTitle1.
  ///
  /// In ar, this message translates to:
  /// **'مشكلة في خدمه التنظيف'**
  String get ticketTitle1;

  /// No description provided for @ticketDesc1.
  ///
  /// In ar, this message translates to:
  /// **'المطبخ والحمام الرئيسي لم يتم تنظيفهما بشكل جيد'**
  String get ticketDesc1;

  /// No description provided for @ticketTitle2.
  ///
  /// In ar, this message translates to:
  /// **'سعر خدمة مكافحة الحشرات'**
  String get ticketTitle2;

  /// No description provided for @ticketDesc2.
  ///
  /// In ar, this message translates to:
  /// **'شكرا لكم هذا واضح'**
  String get ticketDesc2;

  /// No description provided for @timeOneDayAgo.
  ///
  /// In ar, this message translates to:
  /// **'منذ ١ يوم'**
  String get timeOneDayAgo;

  /// No description provided for @supportMsg1.
  ///
  /// In ar, this message translates to:
  /// **'مرحباً أحمد، كيف يمكننا مساعدتك اليوم؟'**
  String get supportMsg1;

  /// No description provided for @userMsg1.
  ///
  /// In ar, this message translates to:
  /// **'أريد الاستفسار عن موعد الزيارة القادم.'**
  String get userMsg1;

  /// No description provided for @exampleHomeFrontMosque.
  ///
  /// In ar, this message translates to:
  /// **'مثال: المنزل أمام المسجد'**
  String get exampleHomeFrontMosque;

  /// No description provided for @homeAddressSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'18، شارع النغيب، الدوحة، الدوحة'**
  String get homeAddressSubtitle;

  /// No description provided for @workAddressSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'برج المراقب - الطابق الثامن'**
  String get workAddressSubtitle;

  /// No description provided for @eightRoomsCompleted.
  ///
  /// In ar, this message translates to:
  /// **'تم العمل ٨ غرف'**
  String get eightRoomsCompleted;

  /// No description provided for @within18Minutes.
  ///
  /// In ar, this message translates to:
  /// **'خلال 18د'**
  String get within18Minutes;

  /// No description provided for @minutes45.
  ///
  /// In ar, this message translates to:
  /// **'45 دقيقة'**
  String get minutes45;

  /// No description provided for @oneHundredEightyMinutes.
  ///
  /// In ar, this message translates to:
  /// **'١٨٠ دقيقة'**
  String get oneHundredEightyMinutes;

  /// No description provided for @roomsCompleted.
  ///
  /// In ar, this message translates to:
  /// **'تم إنجاز 4 غرف'**
  String get roomsCompleted;

  /// No description provided for @weeklyCleaning.
  ///
  /// In ar, this message translates to:
  /// **'تنظيف منزلي أسبوعي'**
  String get weeklyCleaning;

  /// No description provided for @twelveThousandBookings.
  ///
  /// In ar, this message translates to:
  /// **'12,000 حجز'**
  String get twelveThousandBookings;

  /// No description provided for @smallNumber100Number200.
  ///
  /// In ar, this message translates to:
  /// **'صغيرة الحجم (100 * 200 م)'**
  String get smallNumber100Number200;

  /// No description provided for @mediumSize150By275.
  ///
  /// In ar, this message translates to:
  /// **'متوسطة الحجم (150 * 275 م)'**
  String get mediumSize150By275;

  /// No description provided for @largeSize250By345.
  ///
  /// In ar, this message translates to:
  /// **'كبيرة الحجم (250 * 345 م)'**
  String get largeSize250By345;

  /// No description provided for @morning.
  ///
  /// In ar, this message translates to:
  /// **'ص'**
  String get morning;

  /// No description provided for @tenTwentyEightAm.
  ///
  /// In ar, this message translates to:
  /// **'10:28 ص'**
  String get tenTwentyEightAm;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
