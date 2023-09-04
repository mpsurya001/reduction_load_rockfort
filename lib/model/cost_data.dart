class User {
  int? id;
  String? description;
  String? rate;
  String? per;
  UserMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['description'] = description!;
    mapping['rate'] = rate!;
    mapping['per'] = per!;

    return mapping;
  }
}
