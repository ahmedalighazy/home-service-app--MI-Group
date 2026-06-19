# Saved Addresses & Payment Methods Screens

---

## `SavedAddressesScreen` — العناوين المحفوظة

**الملف:** `presentation/screens/saved_addresses_screen.dart`
**الـ Route:** `AppRouter.savedAddresses`

### الوصف

بتعرض قائمة بعناوين المستخدم المحفوظة مع إمكانية إضافة أو حذف أو تعديل.

### الـ State

`StatefulWidget` مع:

```dart
final List<AddressModel> _addresses = [ /* عنوانين هاردكود */ ];
```

البيانات الهاردكود:

- **المنزل:** شارع اللؤلؤة، فيلا 42، الدوحة
- **العمل:** برج المرقاب، الطابق الثامن

### هيكل الشاشة

```
┌────────────────────────────────────────┐
│  AppBar: "العناوين"                    │
├────────────────────────────────────────┤
│  عناويني المحفوظة                      │
│                                        │
│  ┌──────────────────────────────────┐  │
│  │  🏠  المنزل          [افتراضي]   │  │
│  │  شارع اللؤلؤة، فيلا 42...       │  │
│  │  [✏️ تعديل]    [🗑️ حذف]          │  │
│  └──────────────────────────────────┘  │
│  ┌──────────────────────────────────┐  │
│  │  💼  العمل                       │  │
│  │  برج المرقاب...                  │  │
│  │  [✏️ تعديل]    [🗑️ حذف]          │  │
│  └──────────────────────────────────┘  │
│                                        │
│  [+ إضافة عنوان جديد]                  │
└────────────────────────────────────────┘
```

### الـ Widgets المستخدمة

| Widget                   | الوصف                               |
| ------------------------ | ----------------------------------- |
| `AddressCardWidget`      | كارد عنوان واحد مع أزرار تعديل وحذف |
| `AddAddressDashedButton` | زر إضافة عنوان بحدود منقطة          |
| `EmptyStateWidget`       | بيظهر لو `_addresses` فاضية         |

### `AddressCardWidget`

**Props:** `AddressModel address`, `VoidCallback onEdit`, `VoidCallback onDelete`

- بيعرض: أيقونة + label + badge "افتراضي" (لو `isDefault`) + تفاصيل العنوان.
- زر "تعديل" → `onEdit` callback — **فاضي حالياً**.
- زر "حذف" → `onDelete` callback → بيفتح `showCannotDeleteDialogred`.

### `AddAddressDashedButton`

**Props:** `VoidCallback onTap`, `String label`

- زر دائري بحدود خفيفة + أيقونة `+`.
- `onTap: () {}` — **فاضي حالياً**.

> ⚠️ **ملاحظة في الكود:** التعليق بيوضح إن الـ border مش dashed حقيقي، لو المصمم يريد dashed border محتاج `dotted_border` package أو `CustomPainter`.

---

## `PaymentMethodsScreen` — طرق الدفع

**الملف:** `presentation/screens/payment_methods_screen.dart`
**الـ Route:** `AppRouter.paymentMethods`

### الوصف

بتعرض قائمة بطاقات الدفع المحفوظة مع إمكانية إضافة بطاقة جديدة.

### الـ State

`StatefulWidget` مع بطاقتين هاردكود:

- Visa تنتهي `12/26` — افتراضية
- Mastercard تنتهي `09/25`

### هيكل الشاشة

```
┌────────────────────────────────────────┐
│  AppBar: "طرق الدفع"                   │
├────────────────────────────────────────┤
│  ┌──────────────────────────────────┐  │
│  │  [⋮]          **** 1234          │  │
│  │      [افتراضي]   تنتهي 12/26    │  │
│  │                  Ahmed Ibrahim   │  │
│  └──────────────────────────────────┘  │
│  ┌──────────────────────────────────┐  │
│  │  [⋮]          **** 5678          │  │
│  │               تنتهي 09/25        │  │
│  └──────────────────────────────────┘  │
│  [+ إضافة بطاقة جديدة]                 │
├────────────────────────────────────────┤
│  [PaymentFooterInfoWidget]             │
└────────────────────────────────────────┘
```

### الـ Widgets المستخدمة

| Widget                    | الوصف                                               |
| ------------------------- | --------------------------------------------------- |
| `PaymentCardWidget`       | كارد بطاقة دفع واحدة مع قائمة 3 نقاط                |
| `AddCardButtonWidget`     | زر إضافة بطاقة جديدة → يفتح `AddNewCardBottomSheet` |
| `PaymentFooterInfoWidget` | نص تحذيري في أسفل الشاشة                            |
| `EmptyStateWidget`        | بيظهر لو `_paymentMethods` فاضية                    |

### `PaymentCardWidget`

**Props:** `PaymentMethodModel paymentMethod`, `VoidCallback onMoreTap`

- بيعرض: popup menu (3 نقاط) + آخر 4 أرقام + badge "افتراضي" + تاريخ الانتهاء + اسم الحامل + أيقونة الـ brand.
- الـ popup menu بيه 3 خيارات: `favorite`, `edit`, `delete` — كلهم **فاضيين**.

### `AddNewCardBottomSheet`

Bottom sheet لإضافة بطاقة جديدة — يُفتح من `AddCardButtonWidget`.

> ⚠️ **ملاحظة:** محتوى الـ bottom sheet للبطاقة الجديدة غير موثق لأن الملف `add_new_card_bottom_sheet.dart` لم يُقرأ — يحتاج مراجعة.

### `CustomPopupMenu` في `PaymentCardWidget`

الـ enum المستخدم:

```dart
enum MenuAction { favorite, edit, delete }
```

كل الـ actions عندها `// TODO` — لا يوجد logic مكتوب.
