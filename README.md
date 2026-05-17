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

- Flutter SDK `3.41.5` or higher
- Dart SDK `3.11.3` or higher
- Java Development Kit (JDK) `17` or `21`

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

4. **Run the app (Debug / Profile)**
   ```bash
   flutter run --debug
   flutter run --profile
   ```

## 🧪 Testing Suite

The project includes a comprehensive automated test suite consisting of unit, widget, and automated App Store golden screenshot tests (100% success rate).

To run the complete test suite:
```bash
flutter test
```

### Coverage Highlights:
- **Unit Tests**: Full verification of BMI category boundaries, calculator logic, and inputs.
- **Widget & Screen Tests**: Interactive UI verification of settings toggles, history lists, navigation pages, and theme state persistence.
- **Golden Tests**: Device layout and pixel-perfect screenshot rendering validation (located in `test/goldens/`).

## 🔐 Production Release Signing & Optimization

The Android build architecture has been fully upgraded to professional standards:
- **Toolchains**: Modernized declarative Gradle build structure using **Gradle 8.14**, **Android Gradle Plugin 8.11.1**, and **Kotlin 2.2.20** with full **Java 21** compatibility.
- **Tuned Build JVM**: Configured with optimized heap space limits (`-Xmx4G`) and modern Garbage Collection to prevent compilation bottlenecks.
- **Bypassed Jetifier**: Jetifier is disabled (`android.enableJetifier=false`) to significantly speed up compilation of precompiled Flutter native libraries.
- **Automatic Signing**: The system automatically reads `key.properties` from the `android/` directory (which is protected via `.gitignore` to prevent credential leaks) and signs your APKs seamlessly.

To build a signed release APK:
```bash
flutter build apk --release
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
