# Easy Dev Toolkit 🛠️

**Easy Dev Toolkit** is a production-grade Flutter package designed to supercharge your development workflow. It eliminates boilerplate by providing a robust suite of responsive utilities, adaptive widgets, seamless networking, and secure storage solutions.

[![pub package](https://img.shields.io/pub/v/easy_dev_toolkit.svg)](https://pub.dev/packages/easy_dev_toolkit)
![GitHub stars](https://img.shields.io/github/stars/ajmalm/easy_dev_toolkit)
![License](https://img.shields.io/badge/license-MIT-blue.svg)

---

## 🚀 Why Use Easy Dev Toolkit?

- **📱 Responsive Engine**: Build for Mobile, Tablet, and Desktop with a single codebase.
- **🎨 Dynamic Theming**: Toggle Light/Dark modes instantly with `EasyTheme`.
- **🌐 Pro Networking**: Built-in caching, offline support, and smart retries with `EasyApi`.
- **💾 Typed Storage**: Simple wrapper around SharedPreferences.
- **🔐 Security**: AES-256 encryption helper for sensitive data.
- **🧩 Adaptive UI**: Widgets that look native on iOS and Android automatically.

---

## 📦 Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  easy_dev_toolkit: ^0.2.0
```

---

## � Complete Documentation

### 1. 📱 Responsive & Adaptive Design

Make your app look perfect on any screen size.

#### Initialization
Call `SizeConfig.init` in your first build method (e.g., in `MaterialApp` builder or Home screen).

```dart
@override
Widget build(BuildContext context) {
  SizeConfig.init(context); // REQUIRED for .w, .h, .sp extensions
  return Scaffold(...);
}
```

#### Smart Scaling Extensions
Use these extensions to adapt sizes relative to the screen size.

```dart
Container(
  width: 50.w,    // 50% of screen width
  height: 200.h,  // 200 units scaled seamlessly across devices
  padding: EdgeInsets.all(10.w),
);

Text(
  "Responsive Text",
  style: TextStyle(fontSize: 16.sp), // Scalable pixel (great for accessibility)
);
```

#### Breakpoint-Aware Layouts
Use `ResponsiveBuilder` to show different UI layouts based on the device type.

```dart
ResponsiveBuilder(
  mobile: MobileDashboard(),
  tablet: TabletDashboard(),   // Optional
  desktop: DesktopDashboard(), // Optional
);
```

#### Context Helpers
Quickly check device characteristics.

```dart
if (context.isTablet) { ... }
if (context.isDesktop) { ... }
if (context.isLandscape) { ... }
double width = context.width;
double safeHeight = context.safeHeight;
```

---

### 2. 🎨 Theming & Design System

Manage your app's theme dynamically without complex providers.

#### Setup & Usage

```dart
// In your MaterialApp
MaterialApp(
  theme: EasyTheme.light(),
  darkTheme: EasyTheme.dark(),
  themeMode: EasyTheme.mode, // Listen to changes
  home: HomePage(),
);

// Toggle Theme anywhere
EasyTheme.toggle(); 

// Set specific mode
EasyTheme.set(ThemeMode.dark);
```

#### Design Tokens
Use standardized tokens for consistency.
```dart
Container(
  decoration: BoxDecoration(
    borderRadius: AppRadius.roundedMd, // 12.0
    color: context.theme.primaryColor,
  ),
  margin: EdgeInsets.all(AppSpacing.md), // 16.0
);
```

---

### 3. 🌐 Networking (EasyApi)

A powerful wrapper around `Dio` with built-in caching and error handling.

#### Initialization
```dart
EasyApi.init(
  baseUrl: 'https://api.myservice.com',
  maxRetries: 3,
);
```

#### Making Requests
```dart
// GET request with 5-minute cache
final response = await EasyApi.get(
  '/users',
  useCache: true,
  ttl: Duration(minutes: 5),
);

if (response.isSuccess) {
  List users = response.data;
} else {
  // Graceful error handling
  print(response.error); 
}

// POST request
await EasyApi.post('/login', data: {'email': 'test@test.com'});
```

---

### 4. 💾 Storage (AppStorage)

A simplified, typed wrapper for `SharedPreferences`.

#### Initialization
```dart
await AppStorage.init();
```

#### Read & Write
```dart
// Save data
await AppStorage.write('username', 'JohnDoe');
await AppStorage.write('isLoggedIn', true);

// Read data
String? user = AppStorage.read<String>('username');
bool isLogged = AppStorage.read<bool>('isLoggedIn') ?? false;

// Remove
await AppStorage.remove('username');
```

---

### 5. 🔐 Security (EncryptionUtil)

Encrypt sensitive local data using AES-256 (CBC mode).

```dart
String secret = EncryptionUtil.encrypt('My Secret Password');
// Output: "U2FsdGVkX1..."

String original = EncryptionUtil.decrypt(secret);
// Output: "My Secret Password"
```

---

### 6. 🧭 Navigation & Context Shortcuts

Cleaner navigation without `Navigator.of(context)`.

```dart
// Push a new screen
context.push(ProfileScreen());

// Replace current screen
context.pushReplacement(HomeScreen());

// Remove all previous routes
context.pushAndRemoveUntil(LoginScreen());

// Go back
context.pop();

// Access Theme colors easily
Color primary = context.theme.primaryColor;
bool isDark = context.isDarkMode;
```

---

### 7. 🧩 Advanced UI Components

Widgets designed for modern, premium applications.

#### 🪟 GlassCard (Glassmorphism)
Create beautiful frosted glass effects.
```dart
GlassCard(
  blur: 15,
  opacity: 0.2,
  borderRadius: 20,
  child: Text("Premium Content"),
);
```

#### 📅 TimeLogCalendar & DateSelector
Professional date picking tools.
```dart
// Swipeable horizontal date list
HorizontalDateSelector(
  days: myDates,
  onDateSelected: (index) => _onDateSelect(index),
);

// Expandable calendar view
TimeLogCalendar(
  initialDate: DateTime.now(),
  onDateSelected: (date) => print(date),
);
```

#### 🌓 Adaptive Widgets
Widgets that adapt to iOS (Cupertino) and Android (Material) automatically.
```dart
AdaptiveButton(text: "Click Me", onPressed: () {});
AdaptiveTextField(controller: _controller, label: "Enter Name");
AdaptiveBadge(label: "New", backgroundColor: Colors.red);
EasyDialog.show(context, title: "Alert", message: "Action Successful");
```

#### 💀 SkeletonLoader
Shimmering placeholder for loading states.
```dart
SkeletonLoader(width: 100.w, height: 20.h, borderRadius: 8);
```

---

### 8. 🛠 Utilities & Helpers

#### ⚡ Debounce & Throttle
Prevent multiple button clicks or API calls.
```dart
// Debounce (Wait for pause - e.g., Search)
EasyDebounce.run('search', Duration(milliseconds: 500), () {
  api.search(query);
});

// Throttle (Limit execution rate - e.g., Scroll)
EasyThrottle.run('scroll', Duration(seconds: 1), () {
  print("Scrolled");
});
```

#### 📝 Extensions
```dart
// String Validation
if (email.isValidEmail) { ... }
print("hello world".capitalize()); // "Hello world"

// Date Formatting
print(DateTime.now().timeAgo()); // "Just now", "5 min ago"
```

---

## 🤝 Contributing

Contributions are welcome! If you find a bug or want a feature, please open an issue.

## 📄 License

MIT License. See [LICENSE](LICENSE) for details.
