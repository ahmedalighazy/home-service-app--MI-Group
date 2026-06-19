# Legal Screens — FAQ, Privacy Policy, Terms & Conditions

---

## `LegalAndPoliciesScreen` — بوابة الشاشات القانونية

**الملف:** `presentation/screens/legal_and_policies_screen.dart`
**الـ Route:** `AppRouter.legalAndPolicies`

### الوصف

شاشة وسيطة بتعرض قائمة بالوثائق القانونية وبتوجه المستخدم لكل وثيقة.

### المحتوى

```
┌────────────────────────────────────┐
│  AppBar: "السياسات والأحكام"       │
├────────────────────────────────────┤
│  📄  سياسة الخصوصية           ›   │
│ ────────────────────────────────── │
│  📋  الشروط والأحكام           ›   │
│ ────────────────────────────────── │
└────────────────────────────────────┘
```

### التنقل

| العنصر          | الـ Route                      |
| --------------- | ------------------------------ |
| سياسة الخصوصية  | `AppRouter.privacyPolicy`      |
| الشروط والأحكام | `AppRouter.termsAndConditions` |

---

## `FAQScreen` — الأسئلة الشائعة

**الملف:** `presentation/screens/faq_screen.dart`
**الـ Route:** `AppRouter.faq`

### الوصف

بتعرض قائمة من الأسئلة الشائعة في شكل Accordion قابل للتوسيع.

### المحتوى

5 أسئلة، كلهم بيستخدموا `CustomExpansionTile` من core:

| السؤال             |
| ------------------ |
| `AppStrings.faqQ1` |
| `AppStrings.faqQ2` |
| `AppStrings.faqQ3` |
| `AppStrings.faqQ4` |
| `AppStrings.faqQ5` |

### الـ Widget المستخدم

`CustomExpansionTile(title, content)` — من `core/widgets/custom_expansion_tile.dart`

> ⚠️ **غير مكتمل:** كل الأسئلة بيعرضوا نفس الـ content: `AppStrings.faqIntro` — placeholder لم يتم استبداله بمحتوى حقيقي.

---

## `PrivacyPolicyScreen` — سياسة الخصوصية

**الملف:** `presentation/screens/privacy_policy_screen.dart`
**الـ Route:** `AppRouter.privacyPolicy`

### الوصف

بتعرض سياسة الخصوصية مقسمة لأقسام في Accordion.

### الأقسام (6 أقسام)

| العنوان              | الـ AppString                    |
| -------------------- | -------------------------------- |
| المقدمة              | `AppStrings.start`               |
| البيانات التي نجمعها | `AppStrings.collectedData`       |
| كيف نستخدم بياناتك   | `AppStrings.dataUsage`           |
| حماية البيانات       | `AppStrings.dataProtection`      |
| مشاركة البيانات      | `AppStrings.dataSharing`         |
| تعديلات السياسة      | `AppStrings.policyModifications` |

> ⚠️ **غير مكتمل:** كل الأقسام بتعرض نفس الـ content: `AppStrings.privacyPolicyIntro` — placeholder.

---

## `TermsAndConditionsScreen` — الشروط والأحكام

**الملف:** `presentation/screens/terms_and_conditions_screen.dart`
**الـ Route:** `AppRouter.termsAndConditions`

### الوصف

بتعرض الشروط والأحكام مقسمة لأقسام في Accordion.

### الأقسام (8 أقسام)

| العنوان         | الـ AppString                        |
| --------------- | ------------------------------------ |
| البيانات        | `AppStrings.data`                    |
| الخدمات         | `AppStrings.services`                |
| الحجوزات        | `AppStrings.bookings`                |
| إلغاء الخدمة    | `AppStrings.serviceCancellation`     |
| المسؤولية       | `AppStrings.responsibility`          |
| مسؤوليات الشركة | `AppStrings.companyResponsibilities` |
| الحسابات        | `AppStrings.accounts`                |
| التعديلات       | `AppStrings.modifications`           |

> ⚠️ **غير مكتمل:** كل الأقسام بتعرض نفس الـ content: `AppStrings.termsIntro` — placeholder.

---

## ملاحظة مشتركة على الشاشات القانونية الثلاثة

كل الشاشات (FAQ, Privacy, Terms) بتستخدم نفس الـ `CustomExpansionTile` من core، وكلها حالياً بتعرض نص placeholder بدل المحتوى الحقيقي. المحتوى الفعلي محدد في `AppStrings` لكن كل الـ content fields بترجع نفس القيمة.
