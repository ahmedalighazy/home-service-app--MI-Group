# Widgets Reference — Profile Feature

---

## Profile Widgets

### `ProfileHeader`

هيدر الـ gradient الأخضر المنحني في أعلى `ProfileScreen`.

- لا props.
- يستخدم `BottomCurveClipper` من core.
- يأخذ 28% من ارتفاع الشاشة.

---

### `ProfileCard`

كارد بيانات المستخدم (صورة + اسم + هاتف).

- لا props — البيانات هاردكود من `AppStrings`.
- الصورة: `AppAssets.cleaningGuy` ثابتة.

---

### `SettingGroupWidget`

Wrapper بسيط يلف قائمة من الـ widgets.

**Props:** `List<Widget> items`

- يضيف `padding: EdgeInsets.all(2)` لكل عنصر.

---

### `CustomButton`

**الملف:** `widgets/custom_buttom.dart`

زر قابل للتخصيص.

| Prop              | النوع          | الـ Default | الوصف                                           |
| ----------------- | -------------- | ----------- | ----------------------------------------------- |
| `text`            | `String`       | —           | النص                                            |
| `onPressed`       | `VoidCallback` | —           | الـ action                                      |
| `backgroundColor` | `Color`        | —           | لون الخلفية                                     |
| `textColor`       | `Color`        | —           | لون النص                                        |
| `isOutlined`      | `bool`         | `false`     | لو `true`: خلفية بيضاء + بوردر                  |
| `flex`            | `double?`      | —           | (موجود في الـ props لكن مش مستخدم في الـ build) |
| `porderRed`       | `bool?`        | —           | (موجود لكن مش مستخدم)                           |

> ⚠️ **ملاحظة:** هذا الـ `CustomButton` موجود هنا في profile وتاني في `features/setting/screens/cancel_booking_screen.dart` بيستورده. يجب نقله لـ `core/widgets`.

---

### `ProfileImageEditWidget`

صورة المستخدم الدائرية مع زر تعديل.

- لا props.
- صورة ثابتة (`AppAssets.cleaningGuy`).
- زر التعديل بدون action.

---

### `EditProfileForm`

الحقول الثلاثة في شاشة تعديل البروفايل.

- لا props.
- قيم مبدئية هاردكود من `AppStrings`.
- مفيش `TextEditingController`.

---

### `ProfileFooterHintWidget`

نص توضيحي صغير في أسفل شاشة تعديل البروفايل.

- لا props.

---

## Address Widgets

### `AddressCardWidget`

**Props:** `AddressModel address`, `VoidCallback onEdit`, `VoidCallback onDelete`

- يعرض: أيقونة + label + details + badge "افتراضي" (لو isDefault).
- زران: تعديل (أزرق) + حذف (أحمر).

---

### `AddAddressDashedButton`

**Props:** `VoidCallback onTap`, `String label`

- زر دائري بحدود + أيقونة `+`.
- الـ border مش dashed حقيقي (solid بتعتيم منخفض).

---

## Payment Widgets

### `PaymentCardWidget`

**Props:** `PaymentMethodModel paymentMethod`, `VoidCallback onMoreTap`

- يعرض: popup menu + آخر 4 أرقام + badge افتراضي + انتهاء + اسم + أيقونة brand.

---

### `AddCardButtonWidget`

زر "إضافة بطاقة جديدة".

- لا props.
- يفتح `AddNewCardBottomSheet` بـ `showModalBottomSheet`.

---

## Subscription Widgets

### `SubscriptionCardWidget`

**Props:** `SubscriptionModel subscription`, `VoidCallback onTap`

- يعرض هيدر سماوي + تفاصيل + زر إجراء رئيسي.
- Badge الحالة يتغير بناءً على `subscription.status`.

---

### `SubscriptionListWidget`

**Props:** `List<SubscriptionModel> subscriptions`, `bool isCurrent`

- لو فاضية → `EmptyStateWidget`.
- لو فيه بيانات → `ListView` من `SubscriptionCardWidget`.
- الضغط على نشط فقط يروح لـ `SubscriptionDetailScreen`.

---

### `SubscriptionStatusCard`

**Props:** `SubscriptionModel subscription`

- يعرض اسم الاشتراك + badge "نشط" **هاردكود دايماً**.

---

### `SubscriptionActionList`

**Props:** `VoidCallback onPauseTap`, `VoidCallback onCancelTap`

- قائمة من `SubscriptionActionTile` بـ 4 إجراءات.
- "تغيير الباقة" فاضي.

---

## Visit Widgets

### `VisitCard`

**Props:** `VisitModel visit`

- يعرض: تاريخ + وقت + badge حالة.
- Badge يتحدد بـ `VisitStatus` enum.

---

## Favorites Widgets

### `FavoritesListWidget`

- لا props.
- قائمة ثابتة بـ 3 عناصر placeholder.

---

### `FavoriteItemCard`

**Props:** `String title`, `String category`, `String price`

- يعرض: صورة placeholder + العنوان + الفئة + السعر + زر قلب أحمر.
- الزر بدون action.

---

## Contact Widgets

### `ContactCard`

**Props:** `String title`, `String value`, `String icon`, `VoidCallback onCopy`

- يعرض: أيقونة + عنوان + قيمة + زر نسخ.
- `onCopy` فاضي.

---

### `ContactUsFooterNote`

نص توضيحي في أسفل `ContactUsScreen`. لا props.

---

## Delete Account Widgets

### `DeleteAccountWarning`

هيدر تحذيري مع أيقونة حذف. لا props.

---

### `DeleteRulesList`

خلفية حمراء فاتحة بـ 4 قواعد (`DeleteRuleItem`). لا props.

---

### `DeleteConfirmTextField`

**Props:** `TextEditingController controller`

- يعرض error text لو الكتابة غلط ومش فاضية.
- البوردر يتحول أحمر عند الخطأ.

---

### `CustomWidgetDelete`

نص تعليمي "اكتب كلمة التأكيد أدناه". لا props.
