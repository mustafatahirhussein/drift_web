import 'package:drift/drift.dart';

// These imports are only needed to open the database
import 'package:drift/web.dart';

part 'tables.g.dart';

@DriftDatabase(
  // relative import for the drift file. Drift also supports `package:`
  // imports
  include: {'tables.drift'},
)
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<Todo>> getTodos() async {
    return await select(todos).get();
  }

  Future<int> saveTodo(TodosCompanion companion) async {
    return await into(todos).insert(companion);
  }

}

WebDatabase _openConnection() {
  return WebDatabase('db');
}

