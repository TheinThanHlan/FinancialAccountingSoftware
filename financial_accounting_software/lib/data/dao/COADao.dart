import 'package:financial_accounting_software/data/model/COA.dart';
import 'package:winter/winter.dart';

class COADao {
  final Database _db = getIt<Database>(instanceName: "accounting_db");
  Future<List<COA>> getAll() async {
    List<Map<String, dynamic>> tmp = await _db.query("COA", orderBy: "code");
    return tmp.map((a) {
      var b = COA(a["id"] ?? 0, a["code"] ?? 0, a["account"] ?? "", a["isIncreaseInDebit"] == 1, a["isHidden"] == 1);

      return b;
    }).toList();
  }

  Future<int> add(COA coa) async {
    return _db.insert("COA", {"account": coa.account, "code": coa.code, "isIncreaseInDebit": coa.isIncreaseInDebit ? 1 : 0});
  }

  Future<List<COA>> search(String search) async {
    List<Map<String, dynamic>> tmp = await _db.rawQuery("Select * from COA where COA.code like '%$search%' or COA.account like '%$search%' order by COA.code ");
    return tmp.map((a) {
      var b = COA(a["id"] ?? 0, a["code"] ?? 0, a["account"], a["isIncreaseInDebit"] == 1, a["isHidden"] == 1);

      return b;
    }).toList();
  }
}
