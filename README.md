Budget Calendar
===============

Flutter app to plan and track bills and income on a calendar, with a dashboard that shows projected vs. actual cash flow.

Features
--------
- Calendar with markers for upcoming and paid bills; tap any day to add or review items.
- Recurring bill templates (monthly, weekly, biweekly, semi-monthly, yearly, last day/business day) that auto-generate each month.
- Income tracking with expected vs. received amounts and simple source management.
- Dashboard summaries: projected/actual money left, next 7 days due, category breakdowns.
- Local SQLite via Drift; secure storage is ready for future encryption support and local_auth for device lock.
- Start dates for recurring items (nothing generates before the configured start).
- Optional self-hosted MySQL sync via API key (app still works offline with SQLite).

Stack
-----
- Flutter (Material 3)
- Riverpod
- Drift + sqlite3_flutter_libs
- TableCalendar
- local_auth, flutter_secure_storage, intl

Getting started
---------------
1) Install Flutter (SDK >= 3.5.4) and a platform toolchain (Android Studio/Xcode).
2) Install dependencies:
   ```
   flutter pub get
   ```
3) Generate Drift code (needed after schema changes):
   ```
   dart run build_runner build --delete-conflicting-outputs
   ```
4) Run the app:
   ```
   flutter run
   ```

Development tips
----------------
- Lint: `flutter analyze`
- Tests: `flutter test`
- Schema changes: update `lib/db/app_database.dart` then rerun the build_runner command above.
- The app seeds common categories on first run; data is stored locally in `budget_calendar.db`.

Building releases
-----------------
- Android APK (release):
  ```
  flutter build apk --release
  ```
  Output: `build/app/outputs/flutter-apk/app-release.apk`. Requires Android SDK/Android Studio installed.

- Windows (.exe) (release):
  ```
  flutter build windows --release
  ```
  Output: `build/windows/x64/runner/Release/budget_calendar.exe`. Requires Windows Developer Mode for symlinks and Visual Studio with the "Desktop development with C++" workload.

Remote sync backend (MySQL)
---------------------------
The app can point to a self-hosted API that writes to MySQL. SQLite remains the local/offline store.

1. Copy `server/.env.example` to `server/.env` and set `API_KEY` plus MySQL creds.
2. Create the schema:
   ```
   mysql -u <user> -p <dbname> < server/schema.sql
   ```
   (or start the server once; it will create tables if missing).
3. Install and run the API:
   ```
   cd server
   npm install
   npm start
   ```
   Env vars: `PORT` (default 8080), `API_KEY`, `MYSQL_HOST/PORT/USER/PASSWORD/DATABASE`, optional `MYSQL_SSL=true`.
4. Endpoints (require `x-api-key`):
   - `GET /health` -> `{ ok: true }`
   - `GET /api/v1/export` -> dumps categories, bill templates/instances, income sources/instances
   - `POST /api/v1/import` -> replaces those tables with posted JSON payload
5. In the app Settings tab, enable remote sync, set Base URL, and enter/scan the API key.

Note: client-side live sync is still WIP; this backend provides a starting point and export/import endpoints.

Project layout
--------------
- `lib/main.dart` — app bootstrap and theming.
- `lib/screens/` — dashboard, calendar/day detail, bills (templates), income views.
- `lib/db/` — Drift database, schema, and generated code.
- `lib/features/` — recurrence + month generation helpers.
- `lib/state/` — Riverpod providers for DB and selections.
- `lib/utils/` — date/money formatting helpers.
