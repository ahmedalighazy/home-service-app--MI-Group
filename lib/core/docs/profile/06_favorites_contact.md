# Favorites & Contact Us Screens

---

## `FavoritesScreen` — المفضلة

**الملف:** `presentation/screens/favorites_screen.dart`
**الـ Route:** `AppRouter.favorites`

### الوصف

بتعرض الخدمات اللي حفظها المستخدم في المفضلة.

### الـ State

`StatelessWidget` مع:

```dart
const bool hasFavorites = true; // هاردكود
```

### هيكل الشاشة

```
┌────────────────────────────────────────┐
│  AppBar: "المفضلة"                     │
├────────────────────────────────────────┤
│  ┌──────────────────────────────────┐  │
│  │  [صورة]  تنظيف عميق             │  │
│  │          تنظيف المنازل           │  │
│  │          ٥٠ ريال           [❤️]  │  │
│  └──────────────────────────────────┘  │
│  (× 3 — كلهم نفس البيانات)            │
└────────────────────────────────────────┘
```

### الـ Widgets المستخدمة

| Widget                | الوصف                                             |
| --------------------- | ------------------------------------------------- |
| `FavoritesListWidget` | قائمة من `FavoriteItemCard`                       |
| `EmptyStateWidget`    | يظهر لو `hasFavorites = false` — dead code حالياً |

### `FavoritesListWidget`

- `ListView.separated` بـ 3 عناصر ثابتة.
- كل العناصر نفس البيانات الهاردكود:
  - العنوان: "تنظيف عميق"
  - الفئة: "تنظيف المنازل"
  - السعر: "٥٠ ر.ق"

### `FavoriteItemCard`

**Props:** `String title`, `String category`, `String price`

```
┌─────────────────────────────────────┐
│  [صورة]   العنوان              [❤️] │
│           الفئة                     │
│           السعر                     │
└─────────────────────────────────────┘
```

- الصورة placeholder بأيقونة `Icons.cleaning_services`.
- زر القلب أحمر ثابت — مش بيحذف من المفضلة.

### ⚠️ ملاحظات

- `hasFavorites = true` هاردكود — الـ `EmptyStateWidget` dead code ومحذّر منه بالـ analyzer.
- البيانات كلها placeholder — مفيش API أو state management.
- زر المفضلة (القلب) مش متوصل بأي action.

---

## `ContactUsScreen` — تواصل معنا

**الملف:** `presentation/screens/contact_us_screen.dart`
**الـ Route:** `AppRouter.contactUs`

### الوصف

بتعرض معلومات التواصل مع الشركة — رقم الهاتف والبريد الإلكتروني — مع إمكانية نسخ كل منهما.

### هيكل الشاشة

```
┌────────────────────────────────────────┐
│  AppBar: "مركز المساعدة"               │
│          ← (عنوان الـ AppBar غلط!)    │
├────────────────────────────────────────┤
│  معلومات التواصل                       │
│  ─────                                  │
│                                        │
│  ┌──────────────────────────────────┐  │
│  │  📞  خدمة العملاء               │  │
│  │      +974 XXXX XXXX    [نسخ]    │  │
│  └──────────────────────────────────┘  │
│                                        │
│  ┌──────────────────────────────────┐  │
│  │  ✉️  البريد الإلكتروني           │  │
│  │      support@...       [نسخ]    │  │
│  └──────────────────────────────────┘  │
│                                        │
│  [ContactUsFooterNote]                 │
└────────────────────────────────────────┘
```

### الـ Widgets المستخدمة

| Widget                | الوصف                                           |
| --------------------- | ----------------------------------------------- |
| `ContactCard`         | كارد معلومات تواصل واحد (عنوان + قيمة + زر نسخ) |
| `ContactUsFooterNote` | نص توضيحي في الأسفل                             |

### `ContactCard`

**Props:** `String title`, `String value`, `String icon`, `VoidCallback onCopy`

- بيعرض أيقونة + عنوان + قيمة + زر "نسخ".
- `onCopy: () {}` — **فاضي حالياً** — مش بينسخ للـ clipboard.

### ⚠️ ملاحظات

- **عنوان الـ AppBar غلط:** بيعرض "مركز المساعدة" بدل "تواصل معنا" — يحتاج تصحيح.
  ```dart
  appBar: const CustomAppBar(title: AppStrings.helpCenter) // يجب AppStrings.contactUs
  ```
- **`onCopy` فاضية** — مش بتنسخ للـ clipboard. يحتاج `Clipboard.setData(ClipboardData(text: value))`.
