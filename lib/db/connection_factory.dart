import 'package:drift/drift.dart';

import 'connection_factory_io.dart'
    if (dart.library.html) 'connection_factory_web.dart' as impl;

Future<QueryExecutor> createExecutor() => impl.createExecutor();
