import 'package:financial_accounting_software/data/model/JournalEntry.dart';

import '../model/GeneralJournal.dart';
import 'package:winter/winter.dart';

class GeneralJournalDao {
  final Database _db = getIt<WinterSqliteDatabaseProvider>(
    instanceName: "accounting_db",
  ).getDb();
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

  Future<GeneralJournal> getWithId(int id) async {
    var generalJournal = GeneralJournal.fromJson(
      (await _db.query("GeneralJournal", where: "id=$id"))[0],
    );
    generalJournal.entries =
        (await _db.rawQuery("""
        select je.id,je.affectedAccountId,je.isDebit,je.amount,coa.code,coa.account from JournalEntry je inner join COA  on COA.id=je.affectedAccountId
        where je.generalJournalId=$id 
        """)).map((a) {
          return JournalEntry.fromJson(a);
        }).toList();

    return generalJournal;
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
