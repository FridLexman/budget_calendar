# Budget Calendar

Flutter app to plan and track bills and income on a calendar, with a dashboard that shows projected vs. actual cash flow.

## Features
- Calendar with markers for upcoming and paid bills; tap any day to add or review items.
- Recurring bill templates (monthly, weekly, biweekly, semi-monthly, yearly, last day/business day) that auto-generate each month.
- Income tracking with expected vs. received amounts and simple source management.
- Dashboard summaries: projected/actual money left, next 7 days due, category breakdowns.
- Local SQLite via Drift; secure storage is ready for future encryption support and local_auth for device lock.
- Riverpod state management and TableCalendar UI.

## Stack
- Flutter (Material 3)
- Riverpod
- Drift + sqlite3_flutter_libs
- TableCalendar
- local_auth, flutter_secure_storage, intl

## Getting started
1) Install Flutter (SDK >= 3.5.4) and a platform toolchain (Android Studio/Xcode).
2) Install dependencies:
   ```bash
   flutter pub get
   ```
3) Generate Drift code (needed after schema changes):
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```
4) Run the app:
   ```bash
   flutter run
   ```

## Development tips
- Lint: `flutter analyze`
- Tests: `flutter test`
- Schema changes: update `lib/db/app_database.dart` then rerun the build_runner command above.
- The app seeds common categories on first run; data is stored locally in `budget_calendar.db`.

## Building releases
- Android APK (release):
  ```bash
  flutter build apk --release
  ```
  Output: `build/app/outputs/flutter-apk/app-release.apk`. Requires Android SDK/Android Studio installed.

- Windows (.exe) (release):
  ```bash
  flutter build windows --release
  ```
  Output: `build/windows/x64/runner/Release/budget_calendar.exe`. Requires Windows Developer Mode for symlinks and Visual Studio with the “Desktop development with C++” workload.

## Project layout
- `lib/main.dart` – app bootstrap and theming.
- `lib/screens/` – dashboard, calendar/day detail, bills (templates), income views.
- `lib/db/` – Drift database, schema, and generated code.
- `lib/features/` – recurrence + month generation helpers.
- `lib/state/` – Riverpod providers for DB and selections.
- `lib/utils/` – date/money formatting helpers.
