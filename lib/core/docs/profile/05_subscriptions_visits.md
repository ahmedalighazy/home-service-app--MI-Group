# Subscriptions & My Visits Screens

---

## `SubscriptionsScreen` — الاشتراكات

**الملف:** `presentation/screens/subscriptions_screen.dart`
**الـ Route:** `AppRouter.subscriptions`

### الوصف

بتعرض اشتراكات المستخدم في تبيين — الحالية والسابقة.

### الـ State

`StatefulWidget` مع قائمتين هاردكود:

**الاشتراكات الحالية:**

- تنظيف أسبوعي — نشط — 350 ريال

**الاشتراكات السابقة:**

- تنظيف أسبوعي — منتهي — 350 ريال

### هيكل الشاشة

```
┌────────────────────────────────────────┐
│  AppBar: "اشتراكاتي"                   │
│  [الحالية]  [السابقة]  ← TabBar        │
├────────────────────────────────────────┤
│  ┌──────────────────────────────────┐  │
│  │  [هيدر سماوي] 🧹 تنظيف أسبوعي  │  │
│  │                         [نشط]   │  │
│  │  نوع الاشتراك:     أسبوعي       │  │
│  │  الزيارة القادمة: الأحد 15 مايو │  │
│  │  الوقت:            9:00 ص       │  │
│  │  السعر:      350 ر.ق / شهرياً   │  │
│  │  [   إدارة الاشتراك         ]   │  │
│  └──────────────────────────────────┘  │
└────────────────────────────────────────┘
```

### `SubscriptionListWidget`

**Props:** `List<SubscriptionModel> subscriptions`, `bool isCurrent`

- لو القائمة فاضية → `EmptyStateWidget`.
- لو فيه اشتراكات → `ListView` من `SubscriptionCardWidget`.
- الضغط على كارد نشط → ينتقل لـ `SubscriptionDetailScreen`.
- الاشتراكات المنتهية/الموقوفة **مش قابلة للضغط** لشاشة التفاصيل.

### `SubscriptionCardWidget`

**Props:** `SubscriptionModel subscription`, `VoidCallback onTap`

**هيكل الكارد:**

```
┌─────────────────────────────────────┐
│ [هيدر سماوي] 🧹 العنوان    [Badge] │
├─────────────────────────────────────┤
│ نوع الاشتراك:    أسبوعي            │
│ الزيارة القادمة: ...               │
│ الوقت:           ...               │
│ السعر:           ... ر.ق / شهرياً  │
│ [      زر الإجراء الرئيسي       ]  │
└─────────────────────────────────────┘
```

**الزر حسب الحالة:**
| الحالة | نص الزر |
|---|---|
| `active` | إدارة الاشتراك |
| `paused` | إعادة التفعيل |
| `ended` | الاشتراك مجدداً |

---

## `SubscriptionDetailScreen` — تفاصيل الاشتراك

**الملف:** `presentation/screens/subscription_detail_screen.dart`
**الـ Route:** `AppRouter.subscriptionDetail`
**المدخلات:** `SubscriptionModel subscription` (عبر `arguments` في go_router)

### الوصف

شاشة إدارة اشتراك واحد — إيقاف أو إلغاء أو عرض الزيارات.

### هيكل الشاشة

```
┌────────────────────────────────────────┐
│  AppBar: "إدارة الاشتراك"              │
├────────────────────────────────────────┤
│  [SubscriptionStatusCard]              │
│  🧹 تنظيف أسبوعي         [نشط]        │
│                                        │
│  [SubscriptionActionList]              │
│  📅  عرض الزيارات                  ›  │
│  ⏸️  إيقاف مؤقت                    ›  │
│  🔄  تغيير الباقة                  ›  │
│  🗑️  إلغاء الاشتراك  (أحمر)       ›  │
└────────────────────────────────────────┘
```

### `SubscriptionStatusCard`

- بيعرض اسم الاشتراك + badge "نشط" دائماً (**هاردكود**).
- مش بيتغير حسب الـ `subscription.status`.

### `SubscriptionActionList`

قائمة إجراءات بـ 4 عناصر:

| الإجراء        | الـ Action                              |
| -------------- | --------------------------------------- |
| عرض الزيارات   | `context.pushNamed(AppRouter.myVisits)` |
| إيقاف مؤقت     | `onPauseTap` → Dialog تأكيد             |
| تغيير الباقة   | `onTap: () {}` **فاضي**                 |
| إلغاء الاشتراك | `onCancelTap` → Dialog تأكيد            |

---

## `MyVisitsScreen` — زياراتي

**الملف:** `presentation/screens/my_visits_screen.dart`
**الـ Route:** `AppRouter.myVisits`

### الوصف

بتعرض زيارات المستخدم في تبيين — القادمة والسابقة.

### الـ State

`StatelessWidget` مع بيانات هاردكود مباشرة في الـ `build` method (تعليق في الكود: `// Replace with real data from Cubit`).

### ⚠️ Bug — الـ Tabs مقلوبة

```dart
TabBarView(
  children: [
    const Center(child: Text('لا توجد زيارات سابقة')), // Tab "القادمة" !!
    ListView.builder(/* upcomingVisits */),             // Tab "السابقة" !!
  ],
)
```

الـ Tab الأول "الزيارات القادمة" بيعرض "لا توجد زيارات سابقة"، والـ Tab الثاني "السابقة" بيعرض قائمة الزيارات القادمة. **المحتوى مقلوب.**

### `VisitCard`

**Props:** `VisitModel visit`

```
┌──────────────────────────────────────┐
│  📅  الأحد، 15 مايو 2026  [مجدولة]  │
│      08:00 ص - 09:00 ص              │
└──────────────────────────────────────┘
```

**Badge الحالة:**
| `VisitStatus` | النص | اللون |
|---|---|---|
| `scheduled` | مجدولة | أزرق Primary (أبيض) |
| `inProgress` | قيد التنفيذ | برتقالي |
| `completed` | تم الحل | أخضر |

> ⚠️ **ملاحظة:** `completed` بيستخدم `AppStrings.resolved` ("تم الحل") بدل نص مناسب للزيارة.
