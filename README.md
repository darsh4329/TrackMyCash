# 💰 TrackMyCash

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
