# Profile Feature — Data Models

جميع الموديلات موجودة في `data/models/` وبدون `Equatable` أو `fromJson/toJson`.

---

## `AddressModel`

**الملف:** `data/models/address_model.dart`

| Field       | النوع    | الـ Default | الوصف                               |
| ----------- | -------- | ----------- | ----------------------------------- |
| `id`        | `String` | —           | معرف فريد                           |
| `label`     | `String` | —           | اسم العنوان (مثل "المنزل"، "العمل") |
| `details`   | `String` | —           | التفاصيل الكاملة للعنوان            |
| `isDefault` | `bool`   | `false`     | هل هو العنوان الافتراضي؟            |
| `iconPath`  | `String` | —           | مسار أيقونة SVG                     |

---

## `PaymentMethodModel`

**الملف:** `data/models/payment_method_model.dart`

| Field            | النوع    | الـ Default | الوصف                                   |
| ---------------- | -------- | ----------- | --------------------------------------- |
| `id`             | `String` | —           | معرف فريد                               |
| `cardHolderName` | `String` | —           | اسم صاحب البطاقة                        |
| `lastFourDigits` | `String` | —           | آخر 4 أرقام من رقم البطاقة              |
| `expiryDate`     | `String` | —           | تاريخ الانتهاء (مثل `12/26`)            |
| `brand`          | `String` | —           | نوع البطاقة: `'Visa'` أو `'Mastercard'` |
| `isDefault`      | `bool`   | `false`     | هل هي وسيلة الدفع الافتراضية؟           |
| `iconPath`       | `String` | —           | مسار أيقونة الـ brand                   |

---

## `SubscriptionModel`

**الملف:** `data/models/subscription_model.dart`

| Field           | النوع                | الـ Default | الوصف                       |
| --------------- | -------------------- | ----------- | --------------------------- |
| `id`            | `String`             | —           | معرف فريد                   |
| `title`         | `String`             | —           | اسم الاشتراك                |
| `type`          | `String`             | —           | نوع الاشتراك (مثل "أسبوعي") |
| `nextVisitDate` | `String?`            | `null`      | تاريخ الزيارة القادمة       |
| `nextVisitTime` | `String?`            | `null`      | وقت الزيارة القادمة         |
| `expiryDate`    | `String?`            | `null`      | تاريخ انتهاء الاشتراك       |
| `price`         | `double`             | —           | السعر الشهري                |
| `status`        | `SubscriptionStatus` | —           | حالة الاشتراك               |

### `enum SubscriptionStatus`

| القيمة   | المعنى       | اللون             |
| -------- | ------------ | ----------------- |
| `active` | نشط          | أخضر `#059669`    |
| `paused` | موقوف مؤقتاً | برتقالي `#D97706` |
| `ended`  | منتهي        | أحمر `#DC2626`    |

---

## `VisitModel`

**الملف:** `data/models/visit_model.dart`

| Field    | النوع         | الوصف                                 |
| -------- | ------------- | ------------------------------------- |
| `id`     | `String`      | معرف فريد                             |
| `date`   | `String`      | تاريخ الزيارة                         |
| `time`   | `String`      | وقت الزيارة (مثل `08:00 ص - 09:00 ص`) |
| `status` | `VisitStatus` | حالة الزيارة                          |

### `enum VisitStatus`

| القيمة       | المعنى      | اللون             |
| ------------ | ----------- | ----------------- |
| `scheduled`  | مجدولة      | أزرق Primary      |
| `inProgress` | قيد التنفيذ | برتقالي `#D97706` |
| `completed`  | مكتملة      | أخضر `#059669`    |

---

## ⚠️ ملاحظات مشتركة على جميع الموديلات

- **لا يوجد `Equatable`** — المقارنة بين الكائنات ستعمل بـ reference وليس بـ value.
- **لا يوجد `fromJson` / `toJson`** — مستحيل serialize/deserialize الموديلات من API حالياً.
- **لا يوجد abstract repository interface** — التطبيق لا يفصل بين مصدر البيانات والـ presentation.
