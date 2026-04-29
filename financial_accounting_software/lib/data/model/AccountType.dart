class AccountType {
  int id;
  String name;
  int start_with;
  bool isIncreaseInDebit;
  AccountType(this.id, this.name, this.start_with, this.isIncreaseInDebit);

  static final _emptyObj = AccountType(0, "", 0, false);

  factory AccountType.fromJson(Map<String, dynamic> json) {
    return AccountType(
      json["id"],
      json["name"],
      json["start_with"] as int,
      json["isIncreaseInDebit"] == 1 ? true : false,
    );
  }
  factory AccountType.empty() {
    return _emptyObj;
  }
}
