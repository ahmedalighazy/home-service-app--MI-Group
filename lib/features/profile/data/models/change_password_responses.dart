// currentPassword : "string"
// newPassword : "string"

class ChangePasswordResponses {
  ChangePasswordResponses({
      this.currentPassword, 
      this.newPassword,});

  ChangePasswordResponses.fromJson(dynamic json) {
    currentPassword = json['currentPassword'];
    newPassword = json['newPassword'];
  }
  String? currentPassword;
  String? newPassword;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['currentPassword'] = currentPassword;
    map['newPassword'] = newPassword;
    return map;
  }

}