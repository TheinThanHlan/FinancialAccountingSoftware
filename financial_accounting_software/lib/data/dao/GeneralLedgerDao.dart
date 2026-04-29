import 'package:financial_accounting_software/data/model/COA.dart';
import 'package:financial_accounting_software/data/model/GeneralJournal.dart';
import 'package:financial_accounting_software/data/model/GeneralLedger.dart';
import 'package:financial_accounting_software/data/model/JournalEntry.dart';
import 'package:winter/winter.dart';

class GeneralLedgerDao {
  Database _db;
  GeneralLedgerDao(this._db);
  //getIt<DatabaseProvider>(instanceName:"").getDb();

  Future<GeneralLedger> getGeneralLedgerOf(COA coa) async {
    try {
      var x = await _db
          .rawQuery("""select 
          je.id,
          affectedAccountId,
          isDebit,
          amount,
          generalJournalId,
          description,
          journalDate  from JournalEntry  je inner join GeneralJournal  gj
          on gj.id=je.generalJournalId
          inner join COA on COA.id=je.affectedAccountId
          where COA.id = ${coa.id} order by journalDate
          """)
          .then((j) {
            return j.map((a) {
              return GeneralJournal(
                a["generalJournalId"] as int,
                a["description"] as String,
                DateTime.fromMillisecondsSinceEpoch(a["journalDate"] as int),
                [
                  JournalEntry(
                    a["id"] as int,
                    coa,
                    a["isDebit"] == 1 ? true : false,
                    a["amount"] as double,
                  ),
                ],
              );
            }).toList();
          });
      return GeneralLedger(x);
    } catch (e) {
      print(e);
      throw Error();
    }
  }
}
