import 'package:financial_accounting_software/data/model/COA.dart';

class JournalEntry {
  int id;
  COA affectedAccount;
  bool isDebit;
  double amount;
  JournalEntry(this.id, this.affectedAccount, this.isDebit, this.amount);

  //factory JournalEntry.fromJson(Map<String, dynamic> json) {
  //  return JournalEntry(json["id"], json[""]);
  //}

  //Map<String, dynamic> toJson() {
  //  return {"id": id};
  //}
}
