# 💰 TrackMyCash

<<<<<<< HEAD
A **professional monthly budget tracking** Flutter app with local Hive storage,
fl_chart analytics, and a beautiful dark-first Material 3 UI.

---

## 🚀 Quick Start

> ⚠️ **Device Guard Note**: If Dart is blocked by your organization policy,
> open a **personal (non-managed) PowerShell** window, or use Android Studio's
> built-in terminal which runs under a different security context.

### Step 1 — Get dependencies
```bash
cd track_my_cash
flutter pub get
```

### Step 2 — Run on device / emulator
```bash
flutter run
```

### Step 3 (Optional) — Build APK
```bash
flutter build apk --release
```

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

## 🗂️ Project Structure

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
=======
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

<img width="720" height="1600" alt="WhatsApp Image 2026-05-09 at 11 20 08 AM (1)" src="https://github.com/user-attachments/assets/051ffe0f-3fe0-4672-b74d-682da952724d" />
<img width="720" height="1600" alt="WhatsApp Image 2026-05-09 at 11 20 09 AM" src="https://github.com/user-attachments/assets/5263bea1-1e02-43ca-8c68-bf0d1a215a71" />
<img width="720" height="1600" alt="WhatsApp Image 2026-05-09 at 11 20 09 AM (1)" src="https://github.com/user-attachments/assets/8b5a93f3-23eb-4d72-9a3a-67b107be9c36" />
<img width="720" height="1600" alt="WhatsApp Image 2026-05-09 at 11 20 08 AM" src="https://github.com/user-attachments/assets/c37a1233-de4f-46c9-a023-9a227850ec48" />


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
>>>>>>> 8b8766ed0d499c7b110c4c446f0487ddac4fbe56
├── screens/
│   ├── splash_screen.dart
│   ├── dashboard_screen.dart
│   ├── add_income_screen.dart
│   ├── add_expense_screen.dart
│   ├── daily_summary_screen.dart
│   ├── monthly_report_screen.dart
│   └── analytics_screen.dart
└── widgets/
<<<<<<< HEAD
    ├── summary_card.dart         # Gradient stat card
    ├── entry_list_tile.dart      # Dismissible income/expense tile
    └── chart_card.dart           # Chart container with accent bar
=======
    ├── summary_card.dart
    ├── entry_list_tile.dart
    └── chart_card.dart
>>>>>>> 8b8766ed0d499c7b110c4c446f0487ddac4fbe56
```

---

<<<<<<< HEAD
## 🔧 Dependencies

| Package | Purpose |
|---------|---------|
| `hive` + `hive_flutter` | Local NoSQL database |
| `fl_chart` | Pie, bar, line charts |
| `provider` | State management |
| `intl` | Currency / date formatting |
| `uuid` | Unique entry IDs |

---

## 📊 Key Features

- ✅ **Daily workflow** — add multiple incomes/expenses, submit at end of day
- ✅ **Monthly analytics** — total income, expenses, profit/loss, category breakdown
- ✅ **3 chart types** — pie, bar, line (fl_chart)
- ✅ **Swipe to delete** — dismissible entry tiles
- ✅ **Dark mode** — system-aware with beautiful dark theme
- ✅ **Monthly reset** — clear all data and start fresh
- ✅ **Local persistence** — Hive NoSQL, no internet needed

---

## 🎨 Design System

- **Primary colour**: `#6C63FF` (indigo/violet)
- **Income**: `#00D68F` (emerald green)
- **Expense**: `#FF6B6B` (coral red)
- **Balance**: `#FFB347` (amber)
- Background: Deep dark `#0F0F1A` with layered surface cards

---

*Built with Flutter 3.x · Dart 3.x · Material 3*
=======
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
>>>>>>> 8b8766ed0d499c7b110c4c446f0487ddac4fbe56
