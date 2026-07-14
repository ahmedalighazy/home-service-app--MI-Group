class CheckFavoriteResponses {
  CheckFavoriteResponses({
      this.additionalProp1, 
      this.additionalProp2, 
      this.additionalProp3,});

  CheckFavoriteResponses.fromJson(dynamic json) {
    additionalProp1 = json['additionalProp1'];
    additionalProp2 = json['additionalProp2'];
    additionalProp3 = json['additionalProp3'];
  }
  bool? additionalProp1;
  bool? additionalProp2;
  bool? additionalProp3;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['additionalProp1'] = additionalProp1;
    map['additionalProp2'] = additionalProp2;
    map['additionalProp3'] = additionalProp3;
    return map;
  }

}