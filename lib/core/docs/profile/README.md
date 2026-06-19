# Profile Feature — Documentation Index

> **الغرض:** الـ feature دي بتغطي كل حاجة خاصة بحساب المستخدم — من عرض وتعديل البروفايل، للمفضلة، العناوين، طرق الدفع، الاشتراكات، الزيارات، التواصل، وحذف الحساب.

---

## 📁 هيكل المجلدات

```
lib/features/profile/
├── data/
│   └── models/
│       ├── address_model.dart          # موديل العناوين
│       ├── payment_method_model.dart   # موديل طرق الدفع
│       ├── subscription_model.dart     # موديل الاشتراكات + enum
│       └── visit_model.dart            # موديل الزيارات + enum
│
└── presentation/
    ├── screens/
    │   ├── profile_screen.dart             # الشاشة الرئيسية للبروفايل
    │   ├── edit_profile_screen.dart        # تعديل بيانات الحساب
    │   ├── favorites_screen.dart           # المفضلة
    │   ├── saved_addresses_screen.dart     # العناوين المحفوظة
    │   ├── payment_methods_screen.dart     # طرق الدفع
    │   ├── subscriptions_screen.dart       # الاشتراكات
    │   ├── subscription_detail_screen.dart # تفاصيل اشتراك واحد
    │   ├── my_visits_screen.dart           # زياراتي
    │   ├── contact_us_screen.dart          # تواصل معنا
    │   └── delete_account_screen.dart      # حذف الحساب
    │
    └── widgets/
        └── [32 widget — مقسّمة في الملفات أدناه]
```

---

## 📄 ملفات الـ Docs

| الملف                                                      | يغطي                         |
| ---------------------------------------------------------- | ---------------------------- |
| [01_data_models.md](./01_data_models.md)                   | الـ 4 Data Models            |
| [02_profile_screen.md](./02_profile_screen.md)             | الشاشة الرئيسية للبروفايل    |
| [03_edit_profile_screen.md](./03_edit_profile_screen.md)   | تعديل البروفايل + حذف الحساب |
| [04_addresses_payments.md](./04_addresses_payments.md)     | العناوين وطرق الدفع          |
| [05_subscriptions_visits.md](./05_subscriptions_visits.md) | الاشتراكات والزيارات         |
| [06_favorites_contact.md](./06_favorites_contact.md)       | المفضلة والتواصل             |
| [07_widgets_reference.md](./07_widgets_reference.md)       | مرجع كل الـ Widgets          |

---

## 🔀 خريطة التنقل الكاملة

```
ProfileScreen
├── تعديل الملف الشخصي  ──→ EditProfileScreen
│                               └── حذف الحساب ──→ DeleteAccountScreen
├── المفضلة             ──→ FavoritesScreen
├── عناويني             ──→ SavedAddressesScreen
├── اشتراكاتي           ──→ SubscriptionsScreen
│                               └── [Subscription Card] ──→ SubscriptionDetailScreen
│                                                              └── زياراتي ──→ MyVisitsScreen
├── طرق الدفع           ──→ PaymentMethodsScreen
├── الإعدادات           ──→ SettingsScreen (features/setting)
└── تواصل معنا          ──→ ContactUsScreen
```

---

## ⚠️ مشاكل معروفة (ملخص)

| #   | المشكلة                                                                  | الملف                                         |
| --- | ------------------------------------------------------------------------ | --------------------------------------------- |
| 1   | بيانات البروفايل هاردكود (الاسم، الهاتف)                                 | `profile_card.dart`, `edit_profile_form.dart` |
| 2   | مفيش BLoC/Cubit — كل البيانات dummy في الشاشات                           | جميع الشاشات                                  |
| 3   | زر "حفظ" في تعديل البروفايل فاضي                                         | `edit_profile_screen.dart`                    |
| 4   | `hasFavorites = true` هاردكود                                            | `favorites_screen.dart`                       |
| 5   | `EmptyStateWidget` في المفضلة dead code                                  | `favorites_screen.dart`                       |
| 6   | Tabs في `MyVisitsScreen` مقلوبة (بيانات في الـ Tab الغلط)                | `my_visits_screen.dart`                       |
| 7   | `onCopy` في `ContactCard` فاضية                                          | `contact_us_screen.dart`                      |
| 8   | `CustomButton` في هذه الـ feature يجب نقله لـ core                       | `widgets/custom_buttom.dart`                  |
| 9   | `SubscriptionStatusCard` بيعرض "نشط" دايماً (هاردكود)                    | `subscription_status_card.dart`               |
| 10  | `AddAddressDashedButton` تعليق في الكود بيقول الـ border مش dashed حقيقي | `add_address_dashed_button.dart`              |
