import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:sqlite3/wasm.dart';

Future<QueryExecutor> createExecutor() async {
  final sqlite3 = await WasmSqlite3.loadFromUrl(Uri.parse('sqlite3.wasm'));
  return WasmDatabase(sqlite3: sqlite3, path: 'budget_calendar_web');
}
