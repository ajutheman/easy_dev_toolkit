# Easy Dev Toolkit

Easy Dev Toolkit is a Flutter helper package designed to speed up UI development with responsive layout utilities, reusable UI components, and common helper functions. It helps developers build clean, consistent, and adaptive Flutter apps faster with less boilerplate code.
[![pub package](https://img.shields.io/pub/v/easy_dev_toolkit.svg)](https://pub.dev/packages/easy_dev_toolkit)
![GitHub stars](https://img.shields.io/github/stars/ajmalm/easy_dev_toolkit)
![License](https://img.shields.io/badge/license-MIT-blue.svg)

---

## 🚀 Features

- 🔹 **Responsive Design**: Screen size & font scaling extensions (`.w`, `.h`, `.sp`).
- 🔹 **Adaptive UI**: Material & iOS adaptive widgets (Buttons, TextFields, Dialogs).
- 🔹 **Context Extensions**: Easy navigation and theme access (`context.push`, `context.theme`).
- 🔹 **Utility Extensions**: Validation and formatting for `String` and `DateTime`.
- 🔹 **Storage**: Easy `SharedPreferences` wrapper (`AppStorage`).
- 🔹 **Networking**: Generic base API service and connectivity monitoring.
- 🔹 **Modern Widgets**: Glassmorphism cards (`GlassCard`), `TimeLogCalendar`, and skeleton loaders.
- 🔹 **Security**: Simple AES-256 encryption/decryption utilities.

---

## 📦 Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  easy_dev_toolkit: ^0.1.6
```

---

## 🛠 Usage & API Guide

### 1. Responsive & Context Utilities
Get screen dimensions and scale fonts/sizes easily.

```dart
// 1. Initialize in main or first build
SizeConfig.init(context);

// 2. Use scaling extensions
Container(
  width: 50.w,   // 50% of screen width
  height: 200.h, // 200 scaled height units
)

Text("Scaling Text", style: TextStyle(fontSize: 16.sp));

// 3. Navigation & Context
context.push(NextScreen());
context.pop();
bool isDark = context.isDarkMode;
```

### 2. Networking (EasyApi)
A high-level wrapper with integrated caching and retries.

```dart
// Fetch data with 5-minute cache
final response = await EasyApi.get(
  'https://api.example.com/data',
  useCache: true,
  ttl: Duration(minutes: 5),
);

if (response.isSuccess) {
  print(response.data);
} else {
  print(response.error);
}
```

### 3. Storage & Security
Safe and encrypted local persistence.

```dart
// Secure Encryption (AES-256)
String secret = EncryptionUtil.encrypt("My Password");
String original = EncryptionUtil.decrypt(secret);

// Local Storage
await AppStorage.init();
AppStorage.write("theme", "dark");
String theme = AppStorage.read<String>("theme") ?? "light";
```

### 4. Advanced UI Components
Modern, production-ready widgets.

```dart
// Glassmorphism
GlassCard(
  child: Text("Glass Effect"),
  blur: 20,
  opacity: 0.1,
)

// Shimmering Skeleton
SkeletonLoader(height: 100, borderRadius: 12)

// Horizontal Date Selector
HorizontalDateSelector(
  days: myDayList,
  onDateSelected: (index) => print(index),
)

// Adaptive Dialog & Loader
EasyDialog.show(context, title: "Alert", message: "Success!");
EasyLoader.show(context); // Global overlay
```

### 5. String & Date Extensions
```dart
"hello".capitalize(); // "Hello"
"test@mail.com".isValidEmail; // true
DateTime.now().timeAgo(); // "Just now"
```
