import 'package:financial_accounting_software/data/model/JournalEntry.dart';

class GeneralJournal {
  int id;
  String description;

  List<JournalEntry> entries;
  DateTime journalDate;
  GeneralJournal(this.id, this.description, this.journalDate, this.entries);

  double findBalanceValue() {
    double tmpa = 0;
    double tmpb = 0;
    for (var a in entries) {
      if (a.affectedAccount.accountType.isIncreaseInDebit) {
        if (a.affectedAccount.accountType.isIncreaseInDebit == a.isDebit) {
          tmpa += a.amount;
        } else {
          tmpa -= a.amount;
        }
      } else {
        if (!a.affectedAccount.accountType.isIncreaseInDebit == !a.isDebit) {
          tmpb += a.amount;
        } else {
          tmpb -= a.amount;
        }
      }
    }

    return tmpa - tmpb;
  }

  bool isBalanced() {
    return findBalanceValue() == 0;
  }

  //factory GeneralJournal.fromJson(Map<String, dynamic> json) {
  //  return GeneralJournal(json["id"]);
  //}

  //Map<String, dynamic> toJson() {
  //  return {"id": id};
  //}
}
