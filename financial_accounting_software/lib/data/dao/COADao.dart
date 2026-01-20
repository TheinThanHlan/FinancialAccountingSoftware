import 'package:financial_accounting_software/data/model/AccountType.dart';
import 'package:financial_accounting_software/data/model/COA.dart';
import 'package:winter/winter.dart';

class COADao {
  final Database _db = getIt<WinterSqliteDatabaseProvider>(
    instanceName: "accounting_db",
  ).getDb();
  Future<List<COA>> getAll() async {
    List<Map<String, dynamic>> tmp = await _db.query("COA");
    return tmp.map((a) {
      var b = COA(
        a["id"] ?? 0,
        a["code"],
        a["account"] ?? "",
        AccountType(a["accountTypeId"], "", "", false),
      );

      return b;
    }).toList();
  }

  Future<int> add(COA coa) async {
    return _db.insert("COA", {
      "account": coa.account,
      "code": coa.code,
      "accountTypeId": coa.accountType.id,
    });
  }

  Future<List<COA>> search(String search) async {
    List<Map<String, dynamic>> tmp = await _db.rawQuery(
      "Select * from COA inner join AccountType on COA.accountTypeId=AccountType.id  where COA.code like '%$search%' or COA.account like '%$search%' order by COA.code ",
    );
    return tmp.map((a) {
      var b = COA(
        a["id"] ?? 0,
        a["code"] ?? 0,
        a["account"],
        AccountType(
          a["accountTypeId"],
          a["name"],
          "start_at",
          a["isIncreaseInDebit"] == 1 ? true : false,
        ),
      );
      return b;
    }).toList();
  }
}
