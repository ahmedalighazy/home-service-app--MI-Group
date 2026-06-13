# Chat Detail Screen

**الملف:** `presentation/screens/chat_detail_screen.dart`
**الـ Route:** `AppRouter.chatDetail`
**الـ Class:** `ChatDetailScreen`

---

## الوصف

شاشة المحادثة بين المستخدم والدعم الفني داخل تذكرة معينة. بتعرض تاريخ المحادثة وبتسمح للمستخدم يبعت رسائل جديدة.

---

## محتوى الشاشة

```
┌──────────────────────────────────────────┐
│  AppBar: [ChatAppBarTitle]               │
│  (اسم التذكرة | [مفتوح] | TKT.1001)     │
├──────────────────────────────────────────┤
│                                          │
│           مرحباً أحمد، كيف يمكننا...    │
│                           (Support) ←   │
│                                          │
│   → (User) أريد الاستفسار عن موعد...    │
│                                          │
│              [Loading indicator]         │
│                                          │
├──────────────────────────────────────────┤
│  [📤]  [ اكتب رسالتك...          ]       │
└──────────────────────────────────────────┘
```

---

## الـ State Management

- بتعمل `BlocProvider` لـ `ChatCubit` وبتستدعي `loadMessages()` في الـ `create`.
- `ChatMessagesList` بتستخدم `BlocConsumer` لعرض الرسائل.

---

## الـ Widgets المستخدمة

| Widget             | الوصف                                                     |
| ------------------ | --------------------------------------------------------- |
| `ChatAppBarTitle`  | هيدر الـ AppBar: اسم التذكرة + status badge + كود التذكرة |
| `ChatMessagesList` | قائمة الرسائل (بتستخدم الـ Cubit)                         |
| `ChatInputBar`     | حقل الإدخال + زر الإرسال                                  |
| `CancelChat`       | شريط "هذه المحادثة للقراءة فقط" + زر "إعادة فتح التذكرة"  |

---

## `ChatAppBarTitle`

```
[اسم التذكرة (مقطوع)]  [مفتوح]  TKT.1001
```

- اسم التذكرة هاردكود: `AppStrings.ticketTitle1` — مش بيجي من الـ route params.
- `ChatStatusBadge`: pill أخضر بيعرض "مفتوح" دايماً (هاردكود).

> ⚠️ **مشكلة:** الـ AppBar مش بيتغير بناءً على التذكرة المختارة.

---

## `ChatMessagesList`

`StatefulWidget` مع `ScrollController`.

**الـ behavior:**

- عند كل `ChatLoaded` state بيعمل scroll تلقائي للأسفل (`_scrollToBottom`).
- أثناء الـ loading → `CircularProgressIndicator`.
- عند الخطأ → `Text(error)`.

---

## `ChatMessageBubble`

بيعرض رسالة واحدة.

**التصميم حسب الـ Sender:**

|          | User                     | Support                 |
| -------- | ------------------------ | ----------------------- |
| الاتجاه  | يسار                     | يمين                    |
| اللون    | `AppColors.greenPrimary` | `AppColors.darkHover2`  |
| لون النص | `AppColors.bgPrimary`    | `AppColors.primaryText` |
| الزوايا  | شمال يمين = مربعة        | شمال يسار = مربعة       |

بيعرض الوقت أسفل كل رسالة بالصيغة `HH:MM`.

---

## `ChatInputBar`

`StatefulWidget` مع `TextEditingController`.

**الـ behavior:**

- الضغط على زر الإرسال → بيستدعي `ChatCubit.sendMessage(text)`.
- لو الحقل فاضي، مش بيبعت.
- بعد الإرسال بيعمل `_controller.clear()`.

---

## `CancelChat`

بيعرض شريط في أسفل الشاشة لما التذكرة تكون مغلقة:

- نص "هذه المحادثة للقراءة فقط" يمين.
- زر "إعادة فتح التذكرة" يسار.

> ⚠️ **Dead Code:** حالياً `ChatDetailScreen` عندها `var bool = true` هاردكود، فـ `CancelChat` مش بيظهر أبداً والـ analyzer بيحذر من ده.

---

## ⚠️ ملاحظات وإشكاليات

| المشكلة                   | التفاصيل                                                      |
| ------------------------- | ------------------------------------------------------------- |
| `var bool = true` هاردكود | بيحدد هل الـ ticket مفتوح أو لأ — يجب يجي من الـ route params |
| `CancelChat` dead code    | بيتحذر منه الـ analyzer لأنه مش هيظهر أبداً                   |
| اسم التذكرة هاردكود       | `ChatAppBarTitle` بيعرض `ticketTitle1` دايماً                 |
| Status badge هاردكود      | `ChatStatusBadge` بيعرض "مفتوح" دايماً                        |
| مفيش route params         | الشاشة مش بتستلم أي معلومات عن التذكرة المختارة               |
