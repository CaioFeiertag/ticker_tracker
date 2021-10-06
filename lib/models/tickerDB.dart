class TickerDB {
  final String code;
  final String name;
  TickerDB({required this.code, required this.name});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["code"] = this.code;
    map["name"] = this.name;

    return map;
  }
}
