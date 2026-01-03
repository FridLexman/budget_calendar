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

Local-only web UI
-----------------
- A static web shell lives in `web/` (no backend by default) with styling aligned to the app.
- Tabs: Dashboard, Calendar, Bills, Income, Settings. Uses sample data; wire your API calls in `web/app.js`.
- Mobile-friendly out of the box.
- Serve locally: `npx serve web` or any static server. In Kubernetes, mount `web/` into an nginx pod and expose only on your LAN.

Remote sync backend (MySQL)
---------------------------
SQLite remains the offline cache. A single API key = one household; all devices sharing that key see the same data. The backend uses safe, incremental sync (no destructive import/export).

1. Copy `server/.env.example` to `server/.env` and set `API_KEY` plus MySQL creds.
2. Start once (or run `mysql < server/schema.sql`) to apply the new sync-safe schema (drops old tables).
3. Install and run the API:
   ```
   cd server
   npm install
   npm start
   ```
   Env vars: `PORT` (default 8080), `API_KEY`, `MYSQL_HOST/PORT/USER/PASSWORD/DATABASE`, optional `MYSQL_SSL=true`.
4. Sync endpoints (all require `x-api-key`):
   - `GET /health`
   - `GET /api/v1/sync/changes?since=<unix_ms>` — incremental changes + tombstones
   - `POST /api/v1/sync/push` — upserts + soft deletes; server sets `updated_at_server`
   - `GET /api/v1/sync/full` — full snapshot for initial seed
   Legacy `import/export` is disabled to avoid table replacement.
5. Quick verification:
   ```
   cd server
   API_KEY=... BASE_URL=https://budget.local ./sync-demo.sh
   ```
   (trust the TLS cert or use `-k` for self-signed.)
6. In the app Settings, enable self-hosted sync, set Base URL + API key, then use “Sync now”.

Project layout
--------------
- `lib/main.dart` — app bootstrap and theming.
- `lib/screens/` — dashboard, calendar/day detail, bills (templates), income views.
- `lib/db/` — Drift database, schema, and generated code.
- `lib/features/` — recurrence + month generation helpers.
- `lib/state/` — Riverpod providers for DB and selections.
- `lib/utils/` — date/money formatting helpers.
