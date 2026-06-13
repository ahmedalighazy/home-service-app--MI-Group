# Edit Profile & Delete Account Screens

---

## `EditProfileScreen` — تعديل الملف الشخصي

**الملف:** `presentation/screens/edit_profile_screen.dart`
**الـ Route:** `AppRouter.editProfile`

### الوصف

بتسمح للمستخدم تعديل صورته واسمه ورقم هاتفه وإيميله.

### هيكل الشاشة

```
┌──────────────────────────────────────┐
│  AppBar: "تعديل الملف الشخصي"        │
├──────────────────────────────────────┤
│        [ProfileImageEditWidget]      │
│         صورة دائرية + أيقونة تعديل  │
│                                      │
│  [EditProfileForm]                   │
│  الاسم:     [أحمد إبراهيم      ]    │
│  الهاتف:    [+974 5555 5555    ]    │
│  الإيميل:   [ahmed@example.com ]    │
│                                      │
│  [      حفظ التعديلات       ]  ← 🔘 │
│                                      │
│  [      حذف الحساب          ]  ← 🔴 │
│                                      │
│  [ProfileFooterHintWidget]           │
└──────────────────────────────────────┘
```

### الـ Widgets المستخدمة

| Widget                    | الوصف                                             |
| ------------------------- | ------------------------------------------------- |
| `ProfileImageEditWidget`  | صورة دائرية مع زر تعديل في الأسفل                 |
| `EditProfileForm`         | الحقول الثلاثة (الاسم، الهاتف، الإيميل)           |
| `CustomButton` (حفظ)      | زر رمادي — `onPressed: () {}` فاضي                |
| `CustomButton` (حذف)      | زر outlined أحمر → ينتقل لـ `DeleteAccountScreen` |
| `ProfileFooterHintWidget` | نص تحذيري صغير في الأسفل                          |

### `ProfileImageEditWidget`

- صورة دائرية ثابتة (`AppAssets.cleaningGuy`).
- زر تعديل (أيقونة قلم) في الأسفل يمين الصورة.
- **لا يفتح أي image picker** — الزر بدون action.

### `EditProfileForm`

- 3 حقول بـ `CustomTextField` من core.
- القيم الافتراضية هاردكود من `AppStrings`.
- مفيش `TextEditingController` أو validation.

### ⚠️ ملاحظات

- **زر "حفظ" معطّل:** لونه `AppColors.bgDisabled` ولا يفعل شيئاً.
- **مفيش validation** لأي حقل.
- **البيانات هاردكود** من `AppStrings` — مش بتيجي من user state.

---

## `DeleteAccountScreen` — حذف الحساب

**الملف:** `presentation/screens/delete_account_screen.dart`
**الـ Route:** `AppRouter.deleteAccount`

### الوصف

شاشة تأكيد حذف الحساب بشكل آمن — بتطلب من المستخدم كتابة كلمة تأكيد معينة قبل تفعيل زر الحذف.

### هيكل الشاشة

```
┌──────────────────────────────────────┐
│  AppBar: "حذف الحساب"                │
├──────────────────────────────────────┤
│  [DeleteAccountWarning]              │
│  🗑️ عنوان التحذير + وصف             │
│                                      │
│  [DeleteRulesList]                   │
│  ⚠️ قاعدة 1 ...                      │
│  📅 قاعدة 2 ...                      │
│  🔄 قاعدة 3 ...                      │
│  📄 قاعدة 4 ...                      │
│                                      │
│  [CustomWidgetDelete]                │
│  "اكتب كلمة التأكيد أدناه:"          │
│                                      │
│  [DeleteConfirmTextField]            │
│  [ اكتب هنا...              ]        │
│  ← error message إذا كانت غلط       │
│                                      │
│  [ تأكيد حذف الحساب ]  ← يُفعَّل    │
│  [ إلغاء             ]              │
└──────────────────────────────────────┘
```

### الـ State

`StatefulWidget` مع:

- `TextEditingController _confirmController`
- `bool _isTextCorrect` — يتحدث عند كل keystroke

```dart
void _onTextChanged() {
  _isTextCorrect = _confirmController.text.trim() == AppStrings.deleteConfirmWord;
}
```

### سلوك زر التأكيد

| الحالة           | اللون                 | الـ Action                         |
| ---------------- | --------------------- | ---------------------------------- |
| النص غلط أو فاضي | `AppColors.red`       | `onPressed: () {}`                 |
| النص صح          | `AppColors.redDanger` | يفتح `showCannotDeleteDialog(...)` |

> ⚠️ **ملاحظة:** الـ dialog اللي بيفتح عند التأكيد (`showCannotDeleteDialog`) بيقول "لا يمكن الحذف" — يبدو إنه placeholder وليس الـ flow الحقيقي.

### `DeleteConfirmTextField`

- حقل نص مع `controller` من الشاشة.
- بيعرض error text أحمر لو الكتابة غلط ومش فاضية.
- البوردر بيتحول لأحمر عند الخطأ.

### `DeleteRulesList`

خلفية حمراء فاتحة بتحتوي 4 قواعد، كل قاعدة بـ:

- أيقونة
- عنوان
- وصف

القواعد من `AppStrings`: `rule1Title/Desc`, `rule2Title/Desc`, إلخ.
