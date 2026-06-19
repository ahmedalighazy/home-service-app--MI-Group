# Profile Screen — الشاشة الرئيسية

**الملف:** `presentation/screens/profile_screen.dart`
**الـ Route:** يُعرض في الـ bottom navigation (tab "حسابي")

---

## الوصف

الشاشة الرئيسية لحساب المستخدم. بتعرض هيدر ملوّن بالأعلى وكارت بيانات المستخدم وقوائم الإعدادات.

---

## هيكل الشاشة

```
┌──────────────────────────────────────────┐
│  [ProfileHeader] — خلفية خضراء منحنية    │
│  "حسابي"                    [🔔]          │
├──────────────────────────────────────────┤
│  ┌─────────────────────────────────────┐ │
│  │  [صورة]  أحمد إبراهيم              │ │  ← ProfileCard
│  │          +974 5555 5555             │ │
│  └─────────────────────────────────────┘ │
│                                          │
│  [SettingGroupWidget — المجموعة الأولى]  │
│  👤  تعديل الملف الشخصي           ›      │
│  ❤️  المفضلة                      ›      │
│  📍  عناويني                      ›      │
│  🔄  اشتراكاتي                    ›      │
│  💳  طرق الدفع                    ›      │
│  ─────────────────────────────────────── │
│  [SettingGroupWidget — المجموعة الثانية] │
│  ⚙️  الإعدادات                    ›      │
│  📞  تواصل معنا                   ›      │
└──────────────────────────────────────────┘
```

---

## الـ Widgets الرئيسية

| Widget               | الوصف                                                  |
| -------------------- | ------------------------------------------------------ |
| `ProfileHeader`      | الهيدر الأخضر المنحني في الأعلى (28% من ارتفاع الشاشة) |
| `ProfileCard`        | كارت بيانات المستخدم (الاسم + رقم الهاتف + الصورة)     |
| `SettingGroupWidget` | wrapper بيلف قائمة من `SettingListItem`                |

---

## `ProfileHeader`

- خلفية بـ gradient من أخضر لأبيض.
- شكل منحني في الأسفل بـ `BottomCurveClipper` من core.
- بيعرض العنوان "حسابي" + أيقونة إشعارات.
- الأيقونة مش متوصلة بأي navigation.

---

## `ProfileCard`

- كارت أبيض بظل بيعرض:
  - صورة المستخدم (`AppAssets.cleaningGuy` — **هاردكود**).
  - اسم المستخدم (`AppStrings.profileName` — **هاردكود**).
  - رقم الهاتف (`AppStrings.phoneNumber` — **هاردكود**).
- **مفيش BLoC** — البيانات ثابتة من `AppStrings`.

---

## التنقل من الشاشة

| العنصر             | الـ Route                  |
| ------------------ | -------------------------- |
| تعديل الملف الشخصي | `AppRouter.editProfile`    |
| المفضلة            | `AppRouter.favorites`      |
| عناويني            | `AppRouter.savedAddresses` |
| اشتراكاتي          | `AppRouter.subscriptions`  |
| طرق الدفع          | `AppRouter.paymentMethods` |
| الإعدادات          | `AppRouter.setting`        |
| تواصل معنا         | `AppRouter.contactUs`      |

---

## التقنيات المستخدمة

- `CustomScrollView` + `SliverToBoxAdapter` للـ layout.
- `Stack` + `Positioned` عشان الـ `ProfileCard` يتداخل فوق الـ header.
- `SettingListItem` مستورد من `features/setting/presentation/widgets` — cross-feature dependency.

> ⚠️ **ملاحظة:** `SettingListItem` موجودة في الـ setting feature لكن بتتستخدم هنا في profile. الأحسن تنقل لـ `core/widgets`.
