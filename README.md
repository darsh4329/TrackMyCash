# 💰 TrackMyCash

![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.x-blue?logo=dart)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)

A modern **Flutter-based budget tracking application** with local offline storage, beautiful analytics, and a clean Material 3 dark UI.

Track your daily income and expenses, analyze spending habits, and manage your monthly finances — completely offline.

---

## 📌 Problem

Most finance tracking apps:
- Require an internet connection
- Store user data on cloud servers
- Have complicated workflows
- Lack proper visual analytics
- Feel overloaded with unnecessary features

Traditional spreadsheets are time-consuming and difficult to maintain daily.

Users need a simple, fast, offline-first finance tracker that respects privacy while helping build financial discipline.

---

## ✅ Solution

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

## ✨ Features

- 📱 Animated Splash Screen
- 📊 Monthly Dashboard with balance hero card
- ➕ Add Income Entries with source chips
- ➖ Add Expense Entries with category grid
- 📅 Daily Summary Tracking with Submit Day button
- 📈 Monthly Reports with stats grid & insights
- 📉 Pie / Bar / Line Chart Analytics
- 🗑️ Swipe to Delete entries
- 🔒 Offline Local Storage (no internet needed)
- 🌙 Dark Theme Support

---

## 🖼️ Screenshots

<p align="center">
  <img width="220" alt="Dashboard Screen" src="https://github.com/user-attachments/assets/051ffe0f-3fe0-4672-b74d-682da952724d" />
  &nbsp;&nbsp;
  <img width="220" alt="Add Entry Screen" src="https://github.com/user-attachments/assets/5263bea1-1e02-43ca-8c68-bf0d1a215a71" />
  &nbsp;&nbsp;
  <img width="220" alt="Analytics Screen" src="https://github.com/user-attachments/assets/8b5a93f3-23eb-4d72-9a3a-67b107be9c36" />
  &nbsp;&nbsp;
  <img width="220" alt="Monthly Report Screen" src="https://github.com/user-attachments/assets/c37a1233-de4f-46c9-a023-9a227850ec48" />
</p>

---

## 🛠️ Tech Stack

| Technology | Usage |
|------------|-------|
| Flutter | App Framework |
| Dart | Programming Language |
| Hive + Hive Flutter | Local NoSQL Database |
| Provider | State Management |
| fl_chart | Pie, Bar & Line Charts |
| intl | Date & Currency Formatting |
| uuid | Unique Entry ID Generation |

---

## 📱 Screens

| Screen | Route | Description |
|--------|-------|-------------|
| Splash | `/` | Animated logo + tagline → auto-navigates to Dashboard |
| Dashboard | `/dashboard` | Monthly balance hero, income/expense cards, today's entries |
| Add Income | `/add-income` | Amount + source chips + description form |
| Add Expense | `/add-expense` | Amount + category grid + description form |
| Daily Summary | `/daily-summary` | Today's entries list + **Submit Day** button |
| Monthly Report | `/monthly-report` | Stats grid, insights, category breakdown, reset |
| Analytics | `/analytics` | Pie / Bar / Line charts in a tab view |

---

## 📁 Project Structure

```
lib/
├── main.dart                     # App entry — Hive init + Provider setup
├── app.dart                      # MaterialApp + routes + themes
├── core/
│   ├── constants/
│   │   ├── app_colors.dart       # Color palette + gradients
│   │   └── app_text_styles.dart  # Typography system
│   ├── models/
│   │   ├── income_entry.dart     # Hive model
│   │   ├── income_entry.g.dart   # Hand-written TypeAdapter
│   │   ├── expense_entry.dart    # Hive model
│   │   └── expense_entry.g.dart  # Hand-written TypeAdapter
│   ├── services/
│   │   └── hive_service.dart     # CRUD + monthly filters
│   └── providers/
│       └── budget_provider.dart  # ChangeNotifier state + analytics getters
├── screens/
│   ├── splash_screen.dart
│   ├── dashboard_screen.dart
│   ├── add_income_screen.dart
│   ├── add_expense_screen.dart
│   ├── daily_summary_screen.dart
│   ├── monthly_report_screen.dart
│   └── analytics_screen.dart
└── widgets/
    ├── summary_card.dart         # Gradient stat card
    ├── entry_list_tile.dart      # Dismissible income/expense tile
    └── chart_card.dart           # Chart container with accent bar
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.x or higher
- Android Studio / VS Code
- Android Emulator or Physical Device

> ⚠️ **Device Guard Note:** If Dart is blocked by your organization policy, open a **personal (non-managed) PowerShell** window, or use Android Studio's built-in terminal which runs under a different security context.

---

## ⚙️ Installation

### 1️⃣ Clone Repository

```bash
git clone https://github.com/darsh4329/track_my_cash.git
cd track_my_cash
```

### 2️⃣ Install Dependencies

```bash
flutter pub get
```

### 3️⃣ Run Application

```bash
flutter run
```

---

## 📦 Build Release APK

```bash
flutter build apk --release
```

APK output location:

```
build/app/outputs/flutter-apk/app-release.apk
```

---

## 🎨 Design System

| Role | Color | Hex |
|------|-------|-----|
| Primary | Indigo / Violet | `#6C63FF` |
| Income | Emerald Green | `#00D68F` |
| Expense | Coral Red | `#FF6B6B` |
| Balance | Amber | `#FFB347` |
| Background | Deep Dark | `#0F0F1A` |

---

## 🧠 Daily Workflow

1. Launch App
2. Add Income entries
3. Add Expense entries
4. Review Daily Summary
5. Submit Day
6. Analyze Monthly Reports

---

## 📊 Analytics

TrackMyCash includes three chart types powered by `fl_chart`:

- 🥧 **Pie Charts** — category-wise spending breakdown
- 📊 **Bar Charts** — daily expense comparison
- 📉 **Line Charts** — monthly income vs expense trends

---

## 🌍 Localization

The app automatically uses the device locale for currency symbols, date formatting, and number formatting via the `intl` package.

---

## 🔒 Privacy

- No account required
- No cloud sync
- No internet dependency
- All data stored locally on device

---

## 🧪 Testing

```bash
flutter test
```

---

## 🤝 Contributing

Contributions are welcome!

```bash
git checkout -b feature-name
git commit -m "Added new feature"
git push origin feature-name
```

Then open a Pull Request.

---

## 📄 License

Distributed under the MIT License.

---

## 🙏 Acknowledgements

- [Flutter](https://flutter.dev)
- [Hive](https://pub.dev/packages/hive)
- [fl_chart](https://pub.dev/packages/fl_chart)
- [Provider](https://pub.dev/packages/provider)
- Dart Community

---

## 📬 Contact

**Darsh Parmar**

GitHub: [https://github.com/darsh4329](https://github.com/darsh4329)

Project: [https://github.com/darsh4329/track_my_cash](https://github.com/darsh4329/track_my_cash)

---

## ⭐ Support

If you like this project, consider giving it a ⭐ on GitHub!

Built with ❤️ using Flutter & Dart.
