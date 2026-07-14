/// additionalProp1 : "string"
/// additionalProp2 : "string"
/// additionalProp3 : "string"

class RemovedFavorites {
  RemovedFavorites({
      this.additionalProp1, 
      this.additionalProp2, 
      this.additionalProp3,});

  RemovedFavorites.fromJson(dynamic json) {
    additionalProp1 = json['additionalProp1'];
    additionalProp2 = json['additionalProp2'];
    additionalProp3 = json['additionalProp3'];
  }
  String? additionalProp1;
  String? additionalProp2;
  String? additionalProp3;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['additionalProp1'] = additionalProp1;
    map['additionalProp2'] = additionalProp2;
    map['additionalProp3'] = additionalProp3;
    return map;
  }

}