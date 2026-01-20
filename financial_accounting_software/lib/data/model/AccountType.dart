class AccountType {
  int id;
  String name;
  String start_at;
  bool isIncreaseInDebit;
  AccountType(this.id, this.name, this.start_at, this.isIncreaseInDebit);

  factory AccountType.fromJson(Map<String, dynamic> json) {
    return AccountType(
      json["id"],
      json["name"],
      json["start_at"],
      json["isIncreaseInDebit"] == 1 ? true : false,
    );
  }
}
