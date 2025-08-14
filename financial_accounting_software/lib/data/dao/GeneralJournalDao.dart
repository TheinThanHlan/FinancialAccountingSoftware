import '../model/GeneralJournal.dart';
import 'package:winter/winter.dart';

class GeneralJournalDao {
  Database _db = getIt<Database>(instanceName: "accounting_db");
  void insert(GeneralJournal generalJournal) async {
    int id = await _db.insert("GeneralJournal", {
      "description": generalJournal.description,
      "journalDate": generalJournal.journalDate.millisecondsSinceEpoch,
    });
    for (var a in generalJournal.entries) {
      _db.insert("JournalEntry", {
        "affectedAccountId": a.affectedAccount.id,
        "isDebit": a.isDebit ? 1 : 0,
        "amount": a.amount,
        "generalJournalId": id,
      });
    }
  }
}
