import 'package:financial_accounting_software/data/model/JournalEntry.dart';

class GeneralJournal {
  int id;
  String description;

  List<JournalEntry> entries;
  DateTime journalDate;
  GeneralJournal(this.id, this.description, this.journalDate, this.entries);

  double findBalanceValue() {
    double tmp = 0;
    entries.forEach((a) {
      if (a.isDebit == a.affectedAccount.isIncreaseInDebit) {
        tmp += a.amount;
      } else {
        tmp -= a.amount;
      }
    });
    return tmp;
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
