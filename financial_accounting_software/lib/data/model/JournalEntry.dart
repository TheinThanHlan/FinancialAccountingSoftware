import 'package:financial_accounting_software/data/model/COA.dart';

class JournalEntry {
  int id;
  COA affectedAccount;
  bool isDebit;
  double amount;
  JournalEntry(this.id, this.affectedAccount, this.isDebit, this.amount);

  factory JournalEntry.fromJson(Map<String, dynamic> json) {
    return JournalEntry(
      json["id"],
      COA.empty(),
      json["isDebit"],
      json["amount"],
    );
  }

  bool shouldAdd() {
    if (affectedAccount.accountType.isIncreaseInDebit) {
      if (isDebit == true) {
        return true;
      } else {
        return false;
      }
    } else {
      if (isDebit == true) {
        return false;
      } else {
        return true;
      }
    }
  }

  double getConditionedAmount() {
    return shouldAdd() ? amount : -amount;
  }

  //Map<String, dynamic> toJson() {
  //  return {"id": id};
  //}
}
