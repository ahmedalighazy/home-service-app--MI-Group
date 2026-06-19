# Setting Feature — Overview, Data & State Management

---

## طبقة البيانات (Data Layer)

### `MessageModel` — `data/models/message_model.dart`

الـ model الخاص برسائل المحادثة بين المستخدم والدعم الفني.

#### Enums

```dart
enum MessageType { text, image }
enum MessageSender { user, support }
```

#### Fields

| Field       | النوع           | الـ Default | الوصف                      |
| ----------- | --------------- | ----------- | -------------------------- |
| `id`        | `String`        | —           | معرف فريد للرسالة          |
| `content`   | `String`        | —           | نص الرسالة                 |
| `timestamp` | `DateTime`      | —           | وقت إرسال الرسالة          |
| `type`      | `MessageType`   | `text`      | نوع الرسالة (نص أو صورة)   |
| `sender`    | `MessageSender` | —           | المُرسِل (user أو support) |
| `isSent`    | `bool`          | `true`      | هل الرسالة اتبعتت؟         |

#### Methods

```dart
// نسخة معدلة من الـ model (immutable update)
MessageModel copyWith({ String? id, String? content, ... })
```

> ⚠️ **ملاحظة:** الـ model مش بيستخدم `Equatable` — لو محتاج مقارنة في الـ BLoC، يُضاف.

---

## طبقة الـ Logic (State Management)

### `ChatCubit` + `ChatState` — `logic/cubit/chat_cubit.dart`

> ⚠️ **ملاحظة تصميمية:** الـ `ChatState` والـ `ChatCubit` موجودين في **نفس الملف**. الأحسن نفصلهم لـ `chat_state.dart` منفصل.

---

### الـ States

| State                                     | المعنى               |
| ----------------------------------------- | -------------------- |
| `ChatInitial`                             | الحالة الافتراضية    |
| `ChatLoading`                             | جاري تحميل الرسائل   |
| `ChatLoaded(List<MessageModel> messages)` | الرسائل اتحملت بنجاح |
| `ChatError(String message)`               | حصل خطأ              |

---

### `ChatCubit`

```dart
class ChatCubit extends Cubit<ChatState>
```

**الميثودز:**

#### `loadMessages()`

```
ChatInitial
    ↓ loadMessages()
ChatLoading
    ↓ (after 1 second delay)
ChatLoaded([رسالتين هاردكود])
```

- بيعمل simulate لتحميل رسائل بعد delay ثانية واحدة.
- **حالياً:** بيرجع رسالتين dummy — رسالة من الـ support ورسالة من الـ user.

#### `sendMessage(String content)`

- بيضيف رسالة جديدة من الـ user للقائمة.
- بعد ثانيتين بيضيف رد تلقائي من الـ support: `'سأقوم بالتحقق من ذلك فوراً.'`
- الرد دايماً نفسه — مش بيتغير بناءً على محتوى الرسالة.

**Flow:**

```
sendMessage("نص")
    ↓ emit ChatLoaded([...messages, newMessage])
    ↓ after 2s
emit ChatLoaded([...messages, newMessage, supportResponse])
```

> ⚠️ **غير مكتمل:** مفيش API call حقيقي — الكل simulated بـ `Future.delayed`.
