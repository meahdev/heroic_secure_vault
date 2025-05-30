# 🔐 Secure Vault

A highly secure Flutter app for managing sensitive credentials, built using **Clean Architecture**, **BLoC**, and **modern security best practices**. Designed to protect user data with **AES encryption**, **PIN & biometric authentication**, and **robust privacy safeguards**.

---

## ✨ Features

- 🔑 **PIN & Biometric Authentication**
    - On first launch: users set a PIN, confirm it, and optionally enable biometric authentication (Touch ID, Face ID).
    - On app start: biometric prompt is shown if enabled, otherwise users enter their PIN.
- 🗃️ **Credential Vault**  
  Add, view, edit, and delete credentials (site, username, password) securely.
- ❌ **Copy-Paste Disabled**  
  Copy and paste functionality is disabled for all sensitive fields to prevent data leaks.
- 🧪 **Password Generator**  
  Generate strong passwords and evaluate their strength.
- 🛑 **Screenshot & Screen Recording Prevention**  
  Blocks screenshots and screen recordings on sensitive screens using the `no_screenshot` package.
- 🔐 **Auto-Lock on Inactivity**  
  App auto-locks after 2 minutes of inactivity or immediately when sent to the background.
- 🎨 **Theme Support**  
  Light and dark modes, persisted across app sessions.

---

## 📥 Setup Instructions

### 🔧 Prerequisites

- Flutter SDK (Tested with):
  Flutter 3.32.0 • channel stable
  Dart 3.8.0 • DevTools 2.45.1
  macOS 12+ (for iOS development)

- Xcode and CocoaPods (for iOS builds)

### 🚀 Installation

```bash
git clone <your-repo-url>
cd secure_vault
flutter pub get
flutter run
Biometric authentication requires a real device.
🍎 Building for iOS

Environment Setup
sudo sh -c 'xcode-select -s /Applications/Xcode.app/Contents/Developer && xcodebuild -runFirstLaunch'
sudo xcodebuild -license
sudo gem install cocoapods
flutter doctor
Build & Run
Debug Build

flutter run -d <device_id>
Release Build

flutter build ios --release
open ios/Runner.xcworkspace
Then archive via Product > Archive in Xcode and distribute via App Store Connect, TestFlight, or Ad Hoc.

🧱 App Architecture Overview

Secure Vault follows Clean Architecture principles for scalability, maintainability, and testability.

lib/
├── core/
│   ├── di/             # Dependency injection (GetIt)
│   ├── storage/        # Secure storage & shared preferences
│   ├── theme/          # ThemeCubit and theming logic
├── features/
│   ├── authentication/ # PIN/biometric authentication logic
│   ├── credential/     # Credential CRUD operations
│   └── password_generator/ # Password generation & strength evaluation
├── app/                # App entry point, routing, theming
└── splash_screen.dart  # Initial splash screen
Data Layer: Manages secure storage, encryption, and data models.
Domain Layer: Contains pure business logic, use cases, and repository interfaces.
Presentation Layer: UI components and BLoC state management.
Dependency Injection
Uses GetIt and setupDependencies() for:

Loose coupling of components
Easy swapping and mocking for testing
Clean, maintainable codebase
🔒 Security Considerations

PIN & Biometric Authentication: Secure app access with fallback from biometric to PIN.
Auto-Lock: Locks app after 2 minutes of inactivity or when app moves to background.
AES Encryption: All sensitive data including PINs and passwords are encrypted before storage:
await storage.write(key: _pinKey, value: AESHelper.encryptText(pin));
Secure Storage: Uses flutter_secure_storage for sensitive data and shared_preferences only for non-sensitive settings.
Screenshot & Screen Recording Prevention: Enabled on all sensitive screens with no_screenshot package.
Copy-Paste Disabled: Disabled for sensitive text fields via UI flags (enableInteractiveSelection: false, readOnly: true).
Strict Clean Architecture & SOLID principles to reduce risk and simplify security audits.
🧠 BLoC Structure Explanation

Authentication BLoC: Handles PIN setup, biometric authentication, and lock state management.
Credential BLoC: Manages add, update, delete, and fetch operations for user credentials.
Password Generator BLoC: Generates strong passwords and evaluates their strength dynamically.
ThemeCubit: Controls light/dark theme switching and persistence.
All BLoCs are provided globally via MultiBlocProvider for easy access and centralized state management.

📦 Libraries Used & Rationale

Library	Purpose
flutter_bloc	Robust BLoC state management for scalable, testable UI logic.
get_it	Dependency injection for loose coupling and easy testing.
go_router	Declarative and powerful routing/navigation.
local_auth	Biometric authentication integration (Face ID, Touch ID).
flutter_secure_storage	Secure key-value storage for PINs, passwords, and tokens.
shared_preferences	Store non-sensitive settings like theme preference.
encrypt	AES encryption of sensitive data before storage.
no_screenshot	Blocks screenshots and screen recording on sensitive screens.
pinput	Customizable PIN input UI.
flash	Toast/snackbar notifications.
equatable	Simplifies state comparison in BLoC states.
flutter_spinkit	Loading spinners for better user experience.
cupertino_icons	iOS style icons for consistent UI.
🔄 Git Workflow

This project follows Git Flow for organized, production-ready code:

main branch: Production releases only
development branch: Ongoing development and integration
feature/* branches: Individual features or bug fixes
Typical Workflow:

git checkout development
git pull
git checkout -b feature/<feature-name>
# develop, commit, test
git checkout development
git merge feature/<feature-name>
git branch -d feature/<feature-name>
git checkout main
git pull
git merge development
git push
