import 'package:winter/winter.dart';

class JournalEntryDao {
  final Database _db = getIt<Database>(instanceName: "accounting_db");
}
