import 'package:financial_accounting_software/data/model/COA.dart';

class COAHierarchy {
  List<List<COA>> hierarchy;
  COAHierarchy(this.hierarchy);

  factory COAHierarchy.fromJson(List<COA> coas) {
    Map<int, List<COA>> hierarchy = {};
    //insert into map by code length
    for (var a in coas) {
      if (hierarchy[a.code.length] == null) {
        hierarchy[a.code.length] = [];
      }
      hierarchy[a.code.length]!.add(a);
    }

    List<List<COA>> hierarchy2 = [];
    //reorder the hierarchy
    var tmp = hierarchy.keys!.toList();
    tmp.sort();

    int maxCOALevel = 5;
    for (var a in tmp) {
      if (hierarchy2.length <= maxCOALevel) {
        hierarchy2.add(hierarchy[a]!);
      } else {
        hierarchy2[maxCOALevel].addAll(hierarchy[a]!);
      }
    }
    return COAHierarchy(hierarchy2);
  }

  factory COAHierarchy.empty() {
    return COAHierarchy([]);
  }
}
