import 'package:winter/winter.dart';

class JournalEntryDao {
  final Database _db;
  JournalEntryDao(this._db);
  Future<bool> checkIfCoaUsed(int id) async {
    List tmp = await _db.query("JournalEntry", where: "affectedAccountId=$id");
    if (tmp.isEmpty) {
      return false;
    }
    return true;
  }
}
