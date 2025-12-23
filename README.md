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
  easy_dev_toolkit: ^0.1.5
```

---

## 🛠 Usage Examples

### Context & Navigation
```dart
context.push(NextScreen());
context.pop();
print(context.width);
Color primary = context.colorScheme.primary;
```

### String Validations
```dart
if ("email@example.com".isValidEmail) {
  print("Valid email!");
}
```

### Storage
```dart
await AppStorage.init();
AppStorage.saveString("user_name", "John Doe");
String? name = AppStorage.getString("user_name");
```

### GlassCard
```dart
GlassCard(
  child: Text("I am on glass!"),
  blur: 15,
  opacity: 0.2,
)
```

### TimeLogCalendar
```dart
TimeLogCalendar(
  initialDate: DateTime.now(),
  onDateSelected: (date) => print(date),
)
```

### HorizontalDateSelector
```dart
HorizontalDateSelector(
  days: List.generate(30, (i) => DateSelectorDay.fromDateTime(
    DateTime.now().add(Duration(days: i)),
  )),
  onDateSelected: (index) => print("Selected index: $index"),
)
```
