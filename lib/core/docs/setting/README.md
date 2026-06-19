# Setting Feature — Documentation Index

> **الغرض:** الـ feature دي بتغطي كل الإعدادات والخدمات الثانوية في التطبيق — من تغيير الباسورد، للغة، للإشعارات، ومركز المساعدة بالكامل.

---

## 📁 هيكل المجلدات

```
lib/features/setting/
├── data/
│   └── models/
│       └── message_model.dart          # Model لرسائل الـ Chat
│
├── logic/
│   └── cubit/
│       └── chat_cubit.dart             # ChatCubit + ChatState (في نفس الملف)
│
└── presentation/
    ├── screens/
    │   ├── settings_screen.dart            # الشاشة الرئيسية للإعدادات
    │   ├── set_new_password_screen.dart    # تغيير كلمة المرور
    │   ├── help_center_screen.dart         # مركز المساعدة
    │   ├── chat_detail_screen.dart         # شاشة المحادثة (Support Ticket)
    │   ├── faq_screen.dart                 # الأسئلة الشائعة
    │   ├── legal_and_policies_screen.dart  # السياسات والقوانين
    │   ├── privacy_policy_screen.dart      # سياسة الخصوصية
    │   └── terms_and_conditions_screen.dart # الشروط والأحكام
    │
    └── widgets/
        ├── [Shared Settings Widgets]
        ├── [Help Center Widgets]
        └── [Chat Widgets]
```

---

## 📄 ملفات الـ Docs

| الملف                                                  | يغطي                                            |
| ------------------------------------------------------ | ----------------------------------------------- |
| [01_overview_and_data.md](./01_overview_and_data.md)   | هيكل الـ feature، الـ Data Model، الـ ChatCubit |
| [02_settings_screen.md](./02_settings_screen.md)       | الشاشة الرئيسية للإعدادات                       |
| [03_password_screen.md](./03_password_screen.md)       | شاشة تغيير كلمة المرور                          |
| [04_help_center_screen.md](./04_help_center_screen.md) | مركز المساعدة والـ Tickets                      |
| [05_chat_detail_screen.md](./05_chat_detail_screen.md) | شاشة المحادثة مع الدعم الفني                    |
| [06_legal_screens.md](./06_legal_screens.md)           | الشاشات القانونية (FAQ, Privacy, Terms)         |
| [07_widgets_reference.md](./07_widgets_reference.md)   | مرجع كل الـ Widgets                             |

---

## 🔀 خريطة التنقل الكاملة

```
SettingsScreen
├── تغيير كلمة المرور  ──→ UpdatePasswordScreen
├── اللغة               ──→ (⚠️ غير متوصل)
├── الإشعارات           ──→ Toggle (local state)
├── مركز المساعدة       ──→ HelpCenterScreen
│                              ├── الأسئلة الشائعة ──→ FAQScreen
│                              └── [Ticket Card]   ──→ ChatDetailScreen
├── السياسات والقوانين  ──→ LegalAndPoliciesScreen
│                              ├── سياسة الخصوصية ──→ PrivacyPolicyScreen
│                              └── الشروط والأحكام ──→ TermsAndConditionsScreen
└── تسجيل الخروج        ──→ Confirmation Dialog
```

---

## ⚠️ مشاكل معروفة (ملخص)

| #   | المشكلة                                                   | الملف                          |
| --- | --------------------------------------------------------- | ------------------------------ |
| 1   | اللغة مش متوصلة بأي logic                                 | `settings_screen.dart`         |
| 2   | زر تأكيد تغيير الباسورد فاضي                              | `set_new_password_screen.dart` |
| 3   | `ChatState` معرف جوا نفس ملف الـ Cubit                    | `chat_cubit.dart`              |
| 4   | Chat messages هاردكود (dummy data)                        | `chat_cubit.dart`              |
| 5   | `bool = true` هاردكود في ChatDetailScreen                 | `chat_detail_screen.dart`      |
| 6   | `CancelChat` و `verticalSpace` dead code                  | `chat_detail_screen.dart`      |
| 7   | `ChatAppBarTitle` بيعرض ticket name هاردكود               | `chat_app_bar_title.dart`      |
| 8   | `ForgetPasswordLink` فيها typo في النص                    | `forget_password_link.dart`    |
| 9   | محتوى الـ FAQ والـ Privacy والـ Terms كله نفس placeholder | عدة شاشات                      |
