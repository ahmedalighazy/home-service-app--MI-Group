# Widgets Reference — Setting Feature

مرجع لكل الـ widgets الموجودة في `presentation/widgets/`.

---

## Shared Settings Widgets

### `SettingListItem`

**الملف:** `widgets/setting_list_item.dart`

Row قابل للضغط بيستخدم في قوائم الإعدادات.

**Props:**

| Prop               | النوع          | الـ Default              | الوصف                         |
| ------------------ | -------------- | ------------------------ | ----------------------------- |
| `icon`             | `String`       | —                        | مسار أيقونة SVG               |
| `title`            | `String`       | —                        | عنوان العنصر                  |
| `onTap`            | `VoidCallback` | —                        | action عند الضغط              |
| `titleColor`       | `Color?`       | `AppColors.primaryText`  | لون العنوان                   |
| `settingColorIcon` | `Color?`       | `AppColors.greenPrimary` | لون الأيقونة الرئيسية         |
| `trailing`         | `Widget?`      | `Icon(chevron)`          | widget بديل في اليمين         |
| `logout`           | `bool?`        | `false`                  | لو `true` الأيقونة تبقى حمراء |
| `seetingScreen`    | `bool?`        | `false`                  | بيحدد اتجاه السهم (يمين/يسار) |

> ⚠️ **Typo:** اسم الـ prop `seetingScreen` مكتوبة غلط (يجب `settingScreen`).

---

### `SettingsToggleItem`

**الملف:** `widgets/settings_toggle_item.dart`

Row بـ Switch للإعدادات اللي عندها toggle.

**Props:**

| Prop        | النوع                | الوصف                |
| ----------- | -------------------- | -------------------- |
| `icon`      | `IconData`           | أيقونة Material      |
| `title`     | `String`             | عنوان الإعداد        |
| `value`     | `bool`               | الحالة الحالية       |
| `onChanged` | `ValueChanged<bool>` | callback عند التغيير |

- الـ Switch: أخضر لما مفعّل، رمادي لما معطّل.

---

### `SettingsDivider`

**الملف:** `widgets/settings_divider.dart`

خط فاصل بين عناصر الإعدادات.

```dart
Divider(height: 1, thickness: 1, color: AppColors.whitecancel)
```

بدون props — مجرد `const SettingsDivider()`.

---

### `LanguageTrailingText`

**الملف:** `widgets/language_trailing_text.dart`

بيعرض اللغة الحالية ("عربي") مع سهم للجانب — بيُستخدم كـ `trailing` في إعداد اللغة.

- اللغة هاردكود: `AppStrings.arabic`.
- بدون props.

---

## Help Center Widgets

### `HelpCenterItem`

**الملف:** `widgets/help_center_item.dart`

بطاقة للضغط عليها بتمثل قسم في مركز المساعدة.

**Props:**

| Prop    | النوع          | الوصف                              |
| ------- | -------------- | ---------------------------------- |
| `title` | `String`       | عنوان القسم                        |
| `icon`  | `String`       | مسار الأيقونة (مش بيتستخدم حالياً) |
| `onTap` | `VoidCallback` | action عند الضغط                   |

> ⚠️ **ملاحظة:** الـ `icon` prop موجود لكن الكود بيستخدم `IconsPath.vectorBook` هاردكود بدلاً منه. الجزء اللي بيستخدم الـ `icon` موجود في comment.

---

### `TechnicalSupportHeader`

**الملف:** `widgets/technical_support_header.dart`

هيدر قسم الدعم الفني.

- عنوان "الدعم الفني" يسار.
- زر "مشكلة جديدة" يمين — بيفتح `NewIssueBottomSheet`.
- بدون props.

---

### `HelpCenterContactInfo`

**الملف:** `widgets/help_center_contact_info.dart`

بيعرض معلومات التواصل (رقم الهاتف + البريد الإلكتروني).

- بدون props — البيانات من `AppStrings`.
- غير مستخدم في أي شاشة حالياً.

---

### `HelpCenterPrivacyNote`

**الملف:** `widgets/help_center_privacy_note.dart`

نص صغير في المنتصف عن سرية المحادثات.

- بدون props.
- غير مستخدم في أي شاشة حالياً.

---

### `TicketCard`

**الملف:** `widgets/ticket_card.dart`

كارد يعرض تذكرة دعم فني.

**Props:**

| Prop          | النوع           | الوصف            |
| ------------- | --------------- | ---------------- |
| `title`       | `String`        | عنوان التذكرة    |
| `status`      | `String`        | نص الحالة        |
| `statusColor` | `Color`         | لون الـ badge    |
| `ticketCode`  | `String`        | رقم التذكرة      |
| `time`        | `String`        | وقت الإنشاء      |
| `description` | `String`        | ملخص المشكلة     |
| `onTap`       | `VoidCallback?` | action عند الضغط |

---

### `NewIssueBottomSheet`

**الملف:** `widgets/new_issue_bottom_sheet.dart`

Bottom sheet لإنشاء تذكرة جديدة.

**الحقول:**

- عنوان المشكلة
- رقم الطلب
- وصف المشكلة (maxLines: 4)

> ⚠️ **غير مكتمل:** زر "إرسال" بيعمل `context.pop()` فقط بدون أي API call.

---

## Chat Widgets

### `ChatAppBarTitle`

**الملف:** `widgets/chat_app_bar_title.dart`

بيعرض في الـ AppBar: اسم التذكرة + status badge + رقم التذكرة.

- كل البيانات هاردكود — مش بتيجي من الـ route params.

---

### `ChatStatusBadge`

**الملف:** `widgets/chat_status_badge.dart`

Pill أخضر بيعرض "مفتوح" دايماً.

- بدون props — الـ status هاردكود.

---

### `ChatMessagesList`

**الملف:** `widgets/chat_messages_list.dart`

`StatefulWidget` بيعرض قائمة الرسائل.

- بيستخدم `BlocConsumer<ChatCubit>`.
- بيعمل auto-scroll للأسفل عند كل رسالة جديدة.
- يعرض `CircularProgressIndicator` أثناء الـ loading.

---

### `ChatMessageBubble`

**الملف:** `widgets/chat_message_bubble.dart`

Bubble لرسالة واحدة.

**Props:** `MessageModel message`

- لو `sender == user`: bubble يسار، أخضر.
- لو `sender == support`: bubble يمين، رمادي داكن.
- بيعرض الوقت أسفل كل bubble.

---

### `ChatInputBar`

**الملف:** `widgets/chat_input_bar.dart`

شريط إدخال الرسائل.

`StatefulWidget` مع `TextEditingController`.

- زر إرسال دائري على اليسار.
- حقل نص على اليمين.
- عند الضغط → `ChatCubit.sendMessage(text)`.

---

### `CancelChat`

**الملف:** `widgets/cancel_chat.dart`

شريط بيظهر لما التذكرة تكون مغلقة.

- نص "هذه المحادثة للقراءة فقط".
- زر "إعادة فتح التذكرة" — بدون logic.

> ⚠️ **Dead Code:** حالياً مش ظاهر أبداً في `ChatDetailScreen` (راجع الملف 05).

> ⚠️ **Lint issue:** يستخدم `Key? key` بدل `super.key` — constructor قديم الأسلوب.

---

## Password Widgets

### `PasswordTextField`

**الملف:** `widgets/password_text_field.dart`

حقل باسورد مع زر إظهار/إخفاء.

**Props:**

| Prop       | النوع    | الوصف           |
| ---------- | -------- | --------------- |
| `label`    | `String` | عنوان الحقل     |
| `hintText` | `String` | الـ placeholder |

- `StatefulWidget` بيدير `bool _obscureText`.
- بيستخدم `CustomTextField` من core.

---

### `ForgetPasswordLink`

**الملف:** `widgets/forget_password_link.dart`

رابط "نسيت كلمة المرور؟" مع خط تحته.

- بدون props.
- بدون navigation — مجرد UI.

> ⚠️ **Typo في النص:** `'نسيت كلمة المرورو؟'` (واو زيادة في النهاية).
