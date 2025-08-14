class COA {
  int id;
  int code;
  String account;
  bool isIncreaseInDebit;
  bool isHidden;
  COA(this.id, this.code, this.account, this.isIncreaseInDebit, this.isHidden);
  //  factory COA.fromJson(Map<String, dynamic> json) {
  //    return
  //    COA(
  //      json["id"] ?? 0,
  //      json["code"] ?? 0,
  //      json["account"],
  //      json["isIncreaseInDebit"] == 1,
  //      json["isHidden"] == 1,
  //    );
  //  }
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
