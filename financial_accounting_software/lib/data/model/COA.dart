import 'package:financial_accounting_software/data/model/AccountType.dart';

class COA {
  int id;
  String code;
  String account;
  AccountType accountType;

  static final COA _emptyCOA = COA(0, "", "", AccountType(0, "", 0, false));

  COA(this.id, this.code, this.account, this.accountType) {
    this.code = check_0_from_code(this.code);
  }

  set setCode(String code) {
    this.code = check_0_from_code(code);
  }

  factory COA.fromJson(Map<String, dynamic> json) {
    return COA(
      json["id"] ?? 0,
      json["code"] ?? 0,
      json["account"],
      AccountType(json["accountTypeId"], "", 0, false),
    );
  }

  factory COA.empty() {
    return _emptyCOA;
  }

  String check_0_from_code(String code) {
    String tmp = code;
    String tmp1 = tmp;
    //check is there any 0 in front of the string
    for (int b = 0; b < tmp.length; b++) {
      if (tmp[b] == "0") {
        try {
          tmp1 = tmp.substring(b + 1, tmp.length);
        } on RangeError catch (_) {}
      } else {
        break;
      }
    }
    tmp = tmp1;
    //check is there any 0 behind the string
    for (int b = tmp.length - 1; b >= 0; b--) {
      if (tmp[b] == "0") {
        try {
          tmp1 = tmp.substring(0, b);
        } on RangeError catch (_) {}
      } else {
        break;
      }
    }

    tmp = tmp1;
    return tmp;
  }

  //Map<String, dynamic> toJson() {
  //  return {
  //    "id": id,
  //    "code": code,
  //    "account": account,
  //    "isIncreaseInDebit": isIncreaseInDebit,
  //    "isHidden": isHidden,
  //  };
  //}
}
