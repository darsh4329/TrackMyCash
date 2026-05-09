# 💰 TrackMyCash

![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.x-blue?logo=dart)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)

A modern **Flutter-based budget tracking application** with local offline storage, beautiful analytics, and a clean Material 3 UI.

Track your daily income and expenses, analyze spending habits, and manage your monthly finances completely offline.

---

# 📌 Problem

Most finance tracking apps:
- Require internet connection
- Store user data on cloud servers
- Have complicated workflows
- Lack proper visual analytics
- Feel overloaded with unnecessary features

Traditional spreadsheets are time-consuming and difficult to maintain daily.

Users need a simple, fast, offline-first finance tracker that respects privacy while helping build financial discipline.

---

# ✅ Solution

**TrackMyCash** provides:
- 🔒 Offline-first local storage using Hive
- ⚡ Fast and lightweight performance
- 📊 Beautiful financial analytics
- 📅 Daily workflow management
- 🌙 Dark mode support
- 📈 Monthly reports and trends
- 🗑️ Quick swipe-to-delete entries
- 📱 Modern Material 3 UI

All data stays safely on the user's device.

---

# ✨ Features

- 📱 Animated Splash Screen
- 📊 Monthly Dashboard
- ➕ Add Income Entries
- ➖ Add Expense Entries
- 📅 Daily Summary Tracking
- 📈 Monthly Reports
- 📉 Pie / Bar / Line Chart Analytics
- 🗑️ Swipe to Delete
- 🔒 Offline Local Storage
- 🌙 Dark Theme Support

---

# 🖼️ Screenshots

> Screenshots will be added after first release.

--

# 🛠️ Tech Stack

| Technology | Usage |
|------------|-------|
| Flutter | App Framework |
| Dart | Programming Language |
| Hive | Local NoSQL Database |
| Provider | State Management |
| fl_chart | Charts & Analytics |
| intl | Date & Currency Formatting |
| uuid | Unique ID Generation |

---

# 📁 Project Structure

```bash
lib/
├── main.dart
├── app.dart
├── core/
│   ├── constants/
│   │   ├── app_colors.dart
│   │   └── app_text_styles.dart
│   ├── models/
│   │   ├── income_entry.dart
│   │   ├── income_entry.g.dart
│   │   ├── expense_entry.dart
│   │   └── expense_entry.g.dart
│   ├── providers/
│   │   └── budget_provider.dart
│   └── services/
│       └── hive_service.dart
├── screens/
│   ├── splash_screen.dart
│   ├── dashboard_screen.dart
│   ├── add_income_screen.dart
│   ├── add_expense_screen.dart
│   ├── daily_summary_screen.dart
│   ├── monthly_report_screen.dart
│   └── analytics_screen.dart
└── widgets/
    ├── summary_card.dart
    ├── entry_list_tile.dart
    └── chart_card.dart
```

---

# 🚀 Getting Started

## Prerequisites

- Flutter SDK 3.x or higher
- Android Studio / VS Code
- Android Emulator or Physical Device

---

# ⚙️ Installation

## 1️⃣ Clone Repository

```bash
git clone https://github.com/YOUR_USERNAME/track_my_cash.git
cd track_my_cash
```

## 2️⃣ Install Dependencies

```bash
flutter pub get
```

## 3️⃣ Run Application

```bash
flutter run
```

---

# 📦 Build Release APK

```bash
flutter build apk --release
```

APK Output Location:

```bash
build/app/outputs/flutter-apk/app-release.apk
```

---

# 📊 Analytics

TrackMyCash includes:

- 🥧 Pie Charts for category analysis
- 📊 Bar Charts for daily expenses
- 📉 Line Charts for monthly trends

Powered using `fl_chart`.

---

# 🌍 Localization

The app automatically uses the device locale for:
- Currency symbols
- Date formatting
- Number formatting

Using the `intl` package.

---

# 🧠 Daily Workflow

1️⃣ Launch App  
2️⃣ Add Income  
3️⃣ Add Expenses  
4️⃣ Review Daily Summary  
5️⃣ Submit Day  
6️⃣ Analyze Monthly Reports  

---

# 🔒 Privacy

- No account required
- No cloud sync
- No internet dependency
- All data stored locally on device

---

# 🧪 Testing

```bash
flutter test
```

---

# 🤝 Contributing

Contributions are welcome.

## Steps

```bash
git checkout -b feature-name
git commit -m "Added new feature"
git push origin feature-name
```

Then open a Pull Request.

---

# 📄 License

Distributed under the MIT License.

---

# 🙏 Acknowledgements

- Flutter
- Hive
- fl_chart
- Provider
- Dart Community

---

# 📬 Contact

**Darsh Parmar**

GitHub: https://github.com/darsh4329

Project Link:
https://github.com/darsh4329/track_my_cash

---

# ⭐ Support

If you like this project, consider giving it a ⭐ on GitHub.

Built with ❤️ using Flutter & Dart.
