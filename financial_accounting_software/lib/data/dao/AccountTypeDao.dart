import 'package:financial_accounting_software/data/model/AccountType.dart';
import 'package:winter/winter.dart';

class AccountTypeDao {
  Database _db;
  AccountTypeDao(this._db);

  Future<List<AccountType>> getAllAccountTypes() async {
    List<AccountType> accountTypes = (await _db.query("AccountType")).map((a) {
      return AccountType.fromJson(a);
    }).toList();
    return accountTypes;
  }

  //getIt<DatabaseProvider>(instanceName:"").getDb();
}
