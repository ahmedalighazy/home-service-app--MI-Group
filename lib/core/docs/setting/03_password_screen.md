# Update Password Screen

**الملف:** `presentation/screens/set_new_password_screen.dart`
**الـ Route:** `AppRouter.updatePassword`
**الـ Class:** `UpdatePasswordScreen`

---

## الوصف

شاشة تغيير كلمة المرور. بتطلب من المستخدم إدخال كلمة المرور الحالية والجديدة وتأكيدها.

---

## محتوى الشاشة

```
┌──────────────────────────────────────┐
│  AppBar: (فاضي — بدون عنوان)         │
├──────────────────────────────────────┤
│                                      │
│  تعيين كلمة مرور جديدة              │
│  [وصف توضيحي صغير]                  │
│                                      │
│  كلمة المرور الحالية                │
│  [••••••••••]  [👁 toggle]           │
│                         نسيت كلمة   │
│                         المرور؟     │
│                                      │
│  كلمة المرور الجديدة                │
│  [••••••••••]  [👁 toggle]           │
│                                      │
│  تأكيد كلمة المرور                  │
│  [••••••••••]  [👁 toggle]           │
│                                      │
│  [         تأكيد         ]  ← معطّل │
└──────────────────────────────────────┘
```

---

## الـ Widgets المستخدمة

| Widget               | الملف                               | الوصف                                |
| -------------------- | ----------------------------------- | ------------------------------------ |
| `PasswordTextField`  | `widgets/password_text_field.dart`  | حقل باسورد مع toggle الإظهار/الإخفاء |
| `ForgetPasswordLink` | `widgets/forget_password_link.dart` | رابط "نسيت كلمة المرور؟"             |
| `CustomButtom`       | `core/widgets/custom_buttom.dart`   | زر التأكيد                           |

---

## `PasswordTextField` — التفاصيل

`StatefulWidget` بيدير `bool _obscureText` محلياً.

**Props:**

| Prop       | النوع    | الوصف           |
| ---------- | -------- | --------------- |
| `label`    | `String` | عنوان الحقل     |
| `hintText` | `String` | الـ placeholder |

- بيستخدم `CustomTextField` من core.
- الـ toggle بيقلب `_obscureText` بين `true` و `false`.

---

## `ForgetPasswordLink` — التفاصيل

- بيعرض نص "نسيت كلمة المرور؟" مع خط تحته بلون أزرق.
- مش بيتنقل لأي شاشة — `onTap` غير موجود.

> ⚠️ **Bug:** النص فيه typo: `'نسيت كلمة المرورو؟'` (حرف واو زيادة).

---

## ⚠️ ملاحظات

- **زر التأكيد:** `onTap: () {}` فاضي تماماً — مش متوصل بأي API أو validation.
- **الزر شكله معطّل:** لونه `AppColors.bgDisabled` بدل اللون الـ primary — حتى لو المستخدم ملى الحقول.
- **مفيش validation:** مش بيتحقق من تطابق الباسورد الجديد مع التأكيد.
- **`ForgetPasswordLink`:** مش بتروح لأي شاشة.
