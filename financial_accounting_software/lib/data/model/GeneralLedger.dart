import 'package:financial_accounting_software/data/model/AccountType.dart';
import 'package:financial_accounting_software/data/model/COA.dart';
import 'package:financial_accounting_software/data/model/GeneralJournal.dart';
import 'package:financial_accounting_software/data/model/JournalEntry.dart';

class GeneralLedger {
  List<GeneralJournal> generalJournals;
  GeneralLedger(this.generalJournals);

  List<GeneralJournal> filterTheGeneralJournalsFromSpecifyDate(
    DateTime startingDate,
  ) {
    //filter the generaljournal untail specify date
    List<GeneralJournal> tmpGeneralJournals = [];
    double tmpBalance = 0;
    for (var a in generalJournals) {
      if (a.journalDate.millisecondsSinceEpoch <
          startingDate.millisecondsSinceEpoch) {
        tmpBalance += a.entries[0].getConditionedAmount();
      } else {
        tmpGeneralJournals.add(a);
      }
    }
    tmpGeneralJournals.insert(
      0,
      GeneralJournal(0, "Opening Balance", startingDate, [
        JournalEntry(
          0,
          COA(0, "", "", AccountType(0, "", "", true)),
          true,
          tmpBalance,
        ),
      ]),
    );

    return tmpGeneralJournals;
  }
}
