import 'package:financial_accounting_software/data/model/COA.dart';
import 'package:winter/winter.dart';

class COADao {
  Database _db = getIt<Database>(instanceName: "accounting_db");
  Future<List<COA>> getAll() async {
    List<Map<String, dynamic>> tmp = await _db.query("COA");
    return tmp.map((a) {
      var b = COA(
        a["id"] ?? 0,
        a["code"] ?? 0,
        a["account"] ?? "",
        a["isIncreaseInDebit"] == 1,
        a["isHidden"] == 1,
      );

      return b;
    }).toList();
  }

  Future<List<COA>> search(String search) async {
    List<Map<String, dynamic>> tmp = await _db.rawQuery(
      "Select * from COA where COA.code like '%$search%' or COA.account like '%$search%' order by COA.code ",
    );
    return tmp.map((a) {
      var b = COA(
        a["id"] ?? 0,
        a["code"] ?? 0,
        a["account"],
        a["isIncreaseInDebit"] == 1,
        a["isHidden"] == 1,
      );

      return b;
    }).toList();
  }
}
