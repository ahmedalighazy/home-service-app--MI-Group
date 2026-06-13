# Booking Feature — Documentation

> **الغرض:** هذه الـ feature بتتحكم في كل حاجه خاصة بالحجوزات — عرض الحجوزات، تفاصيلها، إعادة الجدولة، وإلغاؤها.

---

## 📁 هيكل المجلدات

```
lib/features/booking/
├── data/
│   ├── models/
│   │   └── booking_model.dart          # Data model للحجز
│   └── repositories/
│       └── booking_repository.dart     # مصدر البيانات (API / dummy data)
│
├── logic/
│   └── cubit/
│       ├── booking_cubit.dart          # Business logic (BLoC Cubit)
│       └── booking_state.dart          # كل الـ states الممكنة
│
└── presentation/
    ├── screens/
    │   ├── booking_screen.dart             # الشاشة الرئيسية - قائمة الحجوزات
    │   ├── booking_details_screen.dart     # شاشة تفاصيل الحجز
    │   ├── cancel_booking_screen.dart      # شاشة إلغاء الحجز
    │   └── reschedule_booking_screen.dart  # شاشة إعادة الجدولة
    │
    └── widgets/
        ├── booking_card.dart               # كارد عرض الحجز في القائمة
        ├── booking_details_header.dart     # هيدر صفحة التفاصيل
        ├── booking_details_row.dart        # صف تفصيلي (label + icon + value)
        ├── booking_status_badge.dart       # Badge لحالة الحجز
        ├── booking_tab_bar.dart            # Tab bar مخصص (غير مستخدم حالياً)
        ├── custom_text_cancel_booking.dart # نص "سبب الإلغاء (اختياري)"
        ├── day_selector.dart               # انتقاء اليوم في إعادة الجدولة
        ├── popup_menu_button.dart          # قائمة الـ 3 نقاط في التفاصيل
        └── time_selector.dart              # انتقاء الوقت في إعادة الجدولة
```

---

## 🗄️ طبقة البيانات (Data Layer)

### `BookingModel` — `data/models/booking_model.dart`

الـ model الأساسي اللي بيمثّل حجز واحد في التطبيق.

| Field           | النوع     | إلزامي؟ | الوصف                                  |
| --------------- | --------- | ------- | -------------------------------------- |
| `id`            | `String`  | ✅      | رقم الحجز مثل `LMS-125846`             |
| `serviceName`   | `String`  | ✅      | اسم الخدمة مثل "تنظيف اثاث (كنب)"      |
| `status`        | `String`  | ✅      | حالة الحجز (راجع قسم الـ Status أدناه) |
| `address`       | `String`  | ✅      | عنوان موقع الخدمة                      |
| `date`          | `String`  | ✅      | تاريخ الحجز بالعربي                    |
| `time`          | `String`  | ✅      | وقت الحجز                              |
| `price`         | `String`  | ✅      | السعر الإجمالي                         |
| `imageUrl`      | `String?` | ❌      | مسار صورة الخدمة                       |
| `paymentMethod` | `String?` | ❌      | طريقة الدفع                            |
| `notes`         | `String?` | ❌      | ملاحظات خاصة / تقييم                   |

```dart
// إنشاء من JSON
BookingModel.fromJson(Map<String, dynamic> json)

// تحويل لـ JSON
Map<String, dynamic> toJson()
```

> ⚠️ **ملاحظة:** `status` حالياً `String` خام بالعربي. الأحسن يبقى `enum` علشان نتجنب مشاكل الـ typo.

---

### قيم الـ Status

| القيمة العربية  | المعنى      | اللون في الـ badge |
| --------------- | ----------- | ------------------ |
| `'مجدولة'`      | Scheduled   | أزرق (Primary)     |
| `'قيد التنفيذ'` | In Progress | برتقالي (Warning)  |
| `'مكتمله'`      | Completed   | أخضر               |
| `'ملغاة'`       | Cancelled   | أحمر (Error)       |

---

### `BookingRepository` — `data/repositories/booking_repository.dart`

```dart
class BookingRepository {
  Future<List<BookingModel>> getBookings() async { ... }
}
```

- بيرجع قائمة الحجوزات.
- **حالياً:** بيرجع **dummy data ثابتة** (حجزين هاردكود).
- **المستقبل:** المفروض يتوصل بـ API أو Firebase.

> ⚠️ **ملاحظة:** مفيش abstract interface للـ repository، اللي بيصعّب الـ unit testing. ينصح بإضافة `abstract class IBookingRepository`.

---

## 🧠 طبقة الـ Logic (State Management)

### `BookingState` — `logic/cubit/booking_state.dart`

كل الـ states ترث من `BookingState extends Equatable`:

| State                                         | متى بتحصل                                |
| --------------------------------------------- | ---------------------------------------- |
| `BookingInitial`                              | الحالة الافتراضية عند إنشاء الـ Cubit    |
| `BookingLoading`                              | جاري تحميل الحجوزات                      |
| `BookingSuccess(List<BookingModel> bookings)` | تم تحميل البيانات بنجاح                  |
| `BookingEmpty`                                | لا توجد حجوزات                           |
| `BookingError(String message)`                | حصل خطأ أثناء التحميل                    |
| `BookingDaySelected(int index)`               | المستخدم اختار يوم في شاشة إعادة الجدولة |
| `BookingTimeSelected(int index)`              | المستخدم اختار وقت في شاشة إعادة الجدولة |

---

### `BookingCubit` — `logic/cubit/booking_cubit.dart`

```dart
class BookingCubit extends Cubit<BookingState> {
  BookingCubit(BookingRepository repository)
}
```

**المتغيرات:**

- `selectedDayIndex` — اليوم المختار حالياً (default: 0)
- `selectedTimeIndex` — الوقت المختار حالياً (default: 0)

**الميثودز:**

| Method                  | الوصف                                                           |
| ----------------------- | --------------------------------------------------------------- |
| `fetchBookings()`       | يجيب الحجوزات من الـ repository، ويعمل emit للـ states المناسبة |
| `selectDay(int index)`  | يحفظ اليوم المختار ويعمل emit لـ `BookingDaySelected`           |
| `selectTime(int index)` | يحفظ الوقت المختار ويعمل emit لـ `BookingTimeSelected`          |

**Flow الـ fetchBookings:**

```
BookingInitial
    ↓ fetchBookings()
BookingLoading
    ↓
BookingSuccess(bookings)  ← لو في بيانات
BookingEmpty              ← لو القائمة فاضية
BookingError(message)     ← لو حصل exception
```

> ⚠️ **ملاحظة تصميمية:** `selectedDayIndex` و `selectedTimeIndex` متغيرات mutable على الـ Cubit مباشرة، مش موجودة داخل الـ state — ده بيكسر pattern الـ immutable state. الأحسن تنتقل جوا state منفصلة.

---

## 🖥️ الشاشات (Screens)

### 1. `BookingScreen` — الشاشة الرئيسية

**المسار:** `presentation/screens/booking_screen.dart`  
**الـ Route:** يُعرض في الـ bottom navigation (ثاني tab "الحجوزات")

**الوصف:** بتعرض كل حجوزات المستخدم في تبيين — الحالية والسابقة.

**التفاصيل:**

- بتعمل `BlocProvider` لـ `BookingCubit` وبتستدعي `fetchBookings()` تلقائياً.
- بتعرض `CircularProgressIndicator` أثناء الـ loading.
- لو الـ state `BookingSuccess` → بتعرض `_BookingContent`:
  - **Tab 1 "الاشتراكات الحالية":** قائمة `BookingCard` لو في حجوزات، أو `EmptyStateWidget` لو مفيش.
  - **Tab 2 "الاشتراكات السابقة":** حالياً بيعرض `EmptyStateWidget` دايماً.
- الضغط على "عرض التفاصيل" في أي كارد بيروح لـ `BookingDetailsScreen` وبيبعت الـ `BookingModel` عبر `extra` في go_router.

> 🐛 **Bug موجود:** الـ condition في Tab 2 معكوسة — بيعرض list لما القائمة فاضية والعكس. يحتاج إصلاح.

---

### 2. `BookingDetailsScreen` — شاشة التفاصيل

**المسار:** `presentation/screens/booking_details_screen.dart`  
**الـ Route:** `AppRouter.bookingDetails`  
**المدخلات:** `BookingModel booking` (يجيلها عبر go_router `extra`)

**الوصف:** بتعرض كل تفاصيل حجز معين.

**محتوى الشاشة:**

- `CustomAppBar` بعنوان "تفاصيل الحجز" + قائمة الـ 3 نقاط (`CustomPopupMenuBooking`).
- `BookingDetailsHeader` → اسم الخدمة + status badge + صورة.
- `Divider`
- جدول تفاصيل يحتوي على:
  - التاريخ والوقت
  - العنوان
  - الملاحظات / التقييم
  - طريقة الدفع
  - رقم الحجز
  - الإجمالي

**ملاحظة:** مفيش BLoC هنا — الشاشة pure presentational بتشتغل على الـ model اللي جالها.

---

### 3. `CancelBookingScreen` — شاشة الإلغاء

**المسار:** `presentation/screens/cancel_booking_screen.dart`  
**الـ Route:** `AppRouter.cancelBooking`

**الوصف:** بتأكد من رغبة المستخدم في إلغاء الحجز وبتطلب سبب اختياري.

**محتوى الشاشة:**

- أيقونة دائرة حمراء بيها delete icon.
- عنوان "هل أنت متأكد من إلغاء الحجز؟" + وصف تحذيري.
- حقل نص اختياري لكتابة سبب الإلغاء.
- زرين: "تأكيد الإلغاء" (أحمر) + "الرجوع" (أبيض).

> ⚠️ **غير مكتمل:** الأزرار `onPressed: () {}` فاضية — الإلغاء مش متوصل بأي logic.  
> ⚠️ **مشكلة:** بتستورد `CustomButton` من `features/profile` — cross-feature dependency يجب نقله لـ `core/widgets`.

---

### 4. `RescheduleBookingScreen` — شاشة إعادة الجدولة

**المسار:** `presentation/screens/reschedule_booking_screen.dart`  
**الـ Route:** `AppRouter.rescheduleBooking`

**الوصف:** تتيح للمستخدم اختيار يوم ووقت جديد للحجز.

**محتوى الشاشة:**

- عنوان "اختر اليوم" + `DaySelector` (7 أيام أفقي).
- عنوان "اختر وقت" + `TimeSelector` (6 slots أفقي).
- حقل ملاحظات اختياري مع عداد حروف (300/0).
- زر "تأكيد إعادة الجدولة".
- بتعمل `BlocProvider` خاص بها لـ `BookingCubit`.

> ⚠️ **غير مكتمل:** زر التأكيد `onTap: () {}` فاضي — مش متوصل بأي API call.

---

## 🧩 الـ Widgets

### `BookingCard`

بيعرض ملخص حجز واحد في القائمة.

```
┌─────────────────────────────────────┐
│ [صورة]  اسم الخدمة      [مجدولة]   │
│         📍 العنوان                  │
│         📅 التاريخ       [تفاصيل]  │
│         🕐 الوقت                    │
└─────────────────────────────────────┘
```

- **Props:** `BookingModel booking`, `VoidCallback onViewDetails`
- الضغط على "عرض التفاصيل" بيستدعي `onViewDetails` callback.

---

### `BookingStatusBadge`

Pill صغير ملوّن بيعرض حالة الحجز.

- **Props:** `String status`
- بيحدد اللون تلقائياً بناءً على قيمة الـ status (Arabic string matching).

---

### `BookingDetailsHeader`

هيدر شاشة التفاصيل.

- **Props:** `String serviceName`, `String status`, `String? imageUrl`
- اسم الخدمة يسار + status badge يمين + صورة اختيارية.

---

### `BookingDetailsRow`

صف تفصيلي واحد داخل `_DetailsCard`.

- **Props:** `String label`, `String value`, `String icon`, `String? value2`, `String? icon2`
- بيدعم صفين من القيم (زي التاريخ والوقت مع بعض).

---

### `DaySelector`

قائمة أفقية لاختيار يوم من 7 أيام.

- 7 أيام ثابتة: السبت → الجمعة.
- بيستخدم `BookingCubit.selectDay(index)`.
- بيتفاعل مع state `BookingDaySelected`.

---

### `TimeSelector`

قائمة أفقية لاختيار slot زمني.

- 6 slots (كلهم حالياً placeholder `'08:00 ص\n-09:00 ص'`).
- بيستخدم `BookingCubit.selectTime(index)`.
- بيتفاعل مع state `BookingTimeSelected`.

> ⚠️ **غير مكتمل:** الـ slots هاردكود ومش dynamic.

---

### `CustomPopupMenuBooking`

قائمة الـ 3 نقاط في شاشة التفاصيل.

- خيارين:
  - **إعادة جدولة** → ينتقل لـ `AppRouter.rescheduleBooking`
  - **حذف/إلغاء** → ينتقل لـ `AppRouter.cancelBooking`
- يستخدم `enum MenuAction { reschedule, delete }`.

---

### `BookingTabBar` (⚠️ غير مستخدم)

Tab bar مخصص بنفس شكل الـ segmented control. موجود في الكود لكن `BookingScreen` بيستخدم Flutter's built-in `TabBar` بدلاً منه.

---

## 🔀 التنقل (Navigation)

التطبيق بيستخدم **go_router**.

| من                              | إلى                       | الطريقة                                                  | البيانات المُمررة |
| ------------------------------- | ------------------------- | -------------------------------------------------------- | ----------------- |
| `BookingScreen`                 | `BookingDetailsScreen`    | `context.push(AppRouter.bookingDetails, extra: booking)` | `BookingModel`    |
| `BookingDetailsScreen` (3 dots) | `RescheduleBookingScreen` | `context.pushNamed(AppRouter.rescheduleBooking)`         | لا شيء            |
| `BookingDetailsScreen` (3 dots) | `CancelBookingScreen`     | `context.pushNamed(AppRouter.cancelBooking)`             | لا شيء            |

---

## 📦 الـ Dependencies الخارجية

| Package              | الاستخدام                                         |
| -------------------- | ------------------------------------------------- |
| `flutter_bloc`       | State management (Cubit/BlocBuilder/BlocProvider) |
| `equatable`          | مقارنة الـ states والـ models                     |
| `go_router`          | التنقل بين الشاشات                                |
| `flutter_svg`        | عرض أيقونات SVG                                   |
| `flutter_screenutil` | Responsive sizing (`.w`, `.h`, `.r`, `.sp`)       |

---

## ⚠️ مشاكل معروفة & نقاط للتحسين

| #   | المشكلة                                                                                    | الملف                                             |
| --- | ------------------------------------------------------------------------------------------ | ------------------------------------------------- |
| 1   | 🐛 **Bug:** الـ condition في Tab 1 و Tab 2 معكوسة                                          | `booking_screen.dart`                             |
| 2   | 🔌 **غير مكتمل:** Repository بيرجع dummy data بس                                           | `booking_repository.dart`                         |
| 3   | 🏗️ **تصميم:** مفيش abstract interface للـ repository                                       | `booking_repository.dart`                         |
| 4   | 🔌 **غير مكتمل:** أزرار شاشة الإلغاء فاضية                                                 | `cancel_booking_screen.dart`                      |
| 5   | 🔌 **غير مكتمل:** زر شاشة إعادة الجدولة فاضي                                               | `reschedule_booking_screen.dart`                  |
| 6   | 🔌 **غير مكتمل:** Slots الوقت هاردكود                                                      | `time_selector.dart`                              |
| 7   | ♻️ **تصميم:** `selectedDayIndex`/`selectedTimeIndex` mutable على الـ Cubit                 | `booking_cubit.dart`                              |
| 8   | 🏷️ **تصميم:** Status كـ raw Arabic string بدل enum                                         | `booking_status_badge.dart`, `booking_model.dart` |
| 9   | ❌ **Deprecated:** `SvgPicture.asset(color:)` يجب استخدام `colorFilter:`                   | عدة widgets                                       |
| 10  | 🔗 **Cross-feature:** `CancelBookingScreen` بتستورد من features/profile                    | `cancel_booking_screen.dart`                      |
| 11  | 💀 **Dead code:** `BookingTabBar` مش مستخدم، `empty_bookings_state.dart` كله commented out | `booking_tab_bar.dart`                            |

---

## 🗺️ خريطة الـ Flow الكاملة

```
BookingScreen
│
├─ [Loading] → CircularProgressIndicator
├─ [Error]   → Text(error message)
└─ [Success] → _BookingContent
               │
               ├─ Tab: "الاشتراكات الحالية"
               │   ├─ [فيه حجوزات] → ListView<BookingCard>
               │   │                     └─ onViewDetails → BookingDetailsScreen
               │   └─ [فاضي] → EmptyStateWidget
               │
               └─ Tab: "الاشتراكات السابقة"
                   └─ EmptyStateWidget (حالياً دايماً)

BookingDetailsScreen
│
├─ BookingDetailsHeader (اسم + status + صورة)
├─ تفاصيل الحجز (date, address, payment, price...)
└─ PopupMenu (3 dots)
    ├─ إعادة جدولة → RescheduleBookingScreen
    └─ إلغاء → CancelBookingScreen

RescheduleBookingScreen
├─ DaySelector (7 أيام)
├─ TimeSelector (6 slots)
├─ Notes field
└─ [تأكيد] → ⚠️ غير متوصل

CancelBookingScreen
├─ Warning UI
├─ Reason field (اختياري)
├─ [تأكيد الإلغاء] → ⚠️ غير متوصل
└─ [الرجوع] → ⚠️ غير متوصل
```
