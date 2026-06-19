# Settings Screen

**الملف:** `presentation/screens/settings_screen.dart`
**الـ Route:** يُفتح من الـ bottom navigation

---

## الوصف

الشاشة الرئيسية للإعدادات. بتعرض قائمة من الخيارات وكل خيار بيروح لشاشة فرعية أو بيعمل action معين.

---

## الـ State

`StatefulWidget` لأن فيه `bool _notificationsEnabled` للـ toggle.

```dart
bool _notificationsEnabled = true; // default: مفعّل
```

---

## محتوى الشاشة

```
┌─────────────────────────────────────┐
│  AppBar: "الإعدادات"                │
├─────────────────────────────────────┤
│  🔑  تغيير كلمة المرور    ›         │
│ ─────────────────────────────────── │
│  🌐  اللغة           عربي ›         │
│ ─────────────────────────────────── │
│  🔔  إشعارات الحجوزات    [Toggle]   │
│ ─────────────────────────────────── │
│  ❓  مركز المساعدة        ›         │
│ ─────────────────────────────────── │
│  📋  السياسات والأحكام    ›         │
│ ─────────────────────────────────── │
│  🚪  تسجيل الخروج (أحمر)  ›        │
└─────────────────────────────────────┘
```

---

## العناصر والـ Navigation

| العنصر            | الـ Widget                                 | الـ Action                                      |
| ----------------- | ------------------------------------------ | ----------------------------------------------- |
| تغيير كلمة المرور | `SettingListItem`                          | `context.pushNamed(AppRouter.updatePassword)`   |
| اللغة             | `SettingListItem` + `LanguageTrailingText` | `onTap: () {}` ⚠️ غير متوصل                     |
| إشعارات الحجوزات  | `SettingsToggleItem`                       | `setState(() => _notificationsEnabled = val)`   |
| مركز المساعدة     | `SettingListItem`                          | `context.pushNamed(AppRouter.helpCenter)`       |
| السياسات والأحكام | `SettingListItem`                          | `context.pushNamed(AppRouter.legalAndPolicies)` |
| تسجيل الخروج      | `SettingListItem`                          | `showCannotDeleteDialogred(...)` — Dialog تأكيد |

---

## الـ Divider بين العناصر

بيستخدم `SettingsDivider` — وهو `Divider` بلون `AppColors.whitecancel` بسُمك 1px.

---

## ⚠️ ملاحظات

- **اللغة:** الـ `onTap` فاضي — مش متوصل بأي language switching logic.
- **الإشعارات:** الـ toggle بيغير local state بس — مش بيتحفظ في أي persistent storage.
- **تسجيل الخروج:** بيعمل Confirmation Dialog، لكن الـ logic بعد التأكيد تابعة لـ `showCannotDeleteDialogred` في `core/utils/helpers/show_dialog.dart`.
