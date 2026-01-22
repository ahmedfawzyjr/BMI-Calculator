# BMI Calculator Premium 🏋️‍♂️

A beautiful, feature-rich BMI (Body Mass Index) Calculator built with Flutter, featuring premium animations, 3D effects, and a stunning dark mode UI.

![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?logo=dart)
![License](https://img.shields.io/badge/License-MIT-green)

## ✨ Features

- 🎯 **Accurate BMI Calculation** - Calculate your Body Mass Index instantly
- 🎨 **Premium UI/UX** - Glassmorphism design with 3D animated cards
- ✨ **Smooth Animations** - Powered by flutter_animate
- 📊 **Animated BMI Gauge** - Dynamic needle indicator with category colors
- 🎊 **Confetti Celebration** - Celebrate healthy BMI results!
- 📈 **History Tracking** - Track your BMI progress over time with charts
- 🌍 **Multi-language** - Arabic and English support
- 🌙 **Dark Mode** - Beautiful dark theme throughout

## 📱 Screenshots

| Splash | Input | Result | History |
|--------|-------|--------|---------|
| ![Splash](store_assets/screenshots/1_splash.png) | ![Input](store_assets/screenshots/2_input.png) | ![Result](store_assets/screenshots/3_result.png) | ![History](store_assets/screenshots/4_history.png) |

## 🛠️ Tech Stack

- **Framework:** Flutter 3.0+
- **State Management:** Riverpod
- **Navigation:** GoRouter
- **Local Storage:** Hive
- **Animations:** flutter_animate, Lottie, Shimmer
- **Charts:** fl_chart
- **UI Effects:** Glassmorphism, Particles, Confetti

## 📦 Dependencies

```yaml
dependencies:
  flutter_riverpod: ^2.5.1
  go_router: ^14.2.0
  google_fonts: ^6.2.1
  hive_flutter: ^1.1.0
  flutter_animate: ^4.5.0
  lottie: ^3.1.0
  shimmer: ^3.0.0
  confetti: ^0.7.0
  fl_chart: ^0.68.0
  audioplayers: ^6.0.0
  glassmorphism: ^3.0.0
  particles_flutter: ^0.1.4
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.0 or higher
- Dart SDK 3.0 or higher

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/bmi_calculator.git
   cd bmi_calculator
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate launcher icons**
   ```bash
   dart run flutter_launcher_icons
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## 📁 Project Structure

```
lib/
├── core/
│   ├── constants/      # App constants
│   ├── router/         # GoRouter configuration
│   ├── services/       # Sound service
│   ├── theme/          # App theme, colors, gradients
│   └── widgets/        # Reusable premium widgets
│       ├── glass_card.dart
│       ├── animated_3d_card.dart
│       ├── glow_slider.dart
│       ├── counter_button.dart
│       └── pulse_button.dart
├── features/
│   ├── bmi/
│   │   ├── data/       # Models, repositories
│   │   ├── domain/     # Business logic
│   │   └── presentation/
│   │       ├── providers/
│   │       ├── screens/
│   │       └── widgets/
│   └── splash/         # Splash screen
├── l10n/               # Localization files
└── main.dart
```

## 🎨 Color Palette

| Color | Hex | Usage |
|-------|-----|-------|
| Deep Space | `#0A0E21` | Primary background |
| Active Card | `#1D1E33` | Card backgrounds |
| Hot Pink | `#EB1555` | Primary accent |
| Electric Cyan | `#00D9FF` | Secondary accent |
| Neon Green | `#24D876` | Success/Normal BMI |
| Warning Orange | `#FF9500` | Overweight |

## 🌐 Localization

The app supports:
- 🇺🇸 English (en)
- 🇸🇦 Arabic (ar)

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

Built with ❤️ using Flutter

---

**Package Name:** `bmicalculatorme.app`  
**App Name:** BMI Calculator
