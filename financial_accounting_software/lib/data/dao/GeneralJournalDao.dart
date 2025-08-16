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

  Future<List<GeneralJournal>> filterWithDate(DateTime targetDateTime) async {
    var x = await _db.query(
      "GeneralJournal",
      where:
          "journalDate>${targetDateTime.millisecondsSinceEpoch} and journalDate<${targetDateTime.copyWith(day: targetDateTime.day + 1).millisecondsSinceEpoch}",
      orderBy: "journalDate",
    );
    List<GeneralJournal> tmp = x
        .map(
          (a) => GeneralJournal(
            a["id"] as int,
            a["description"] as String,
            DateTime.fromMillisecondsSinceEpoch(a["journalDate"] as int),
            [],
          ),
        )
        .toList();

    return tmp;
  }
}
