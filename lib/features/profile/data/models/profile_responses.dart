// id : "3fa85f64-5717-4562-b3fc-2c963f66afa6"
// name : "string"
// email : "string"
// phone : "string"
// bio : "string"
// socialLinks : ["string"]
// verified : true
// role : "string"
// createdAt : "2026-06-30T10:07:33.796Z"
// updatedAt : "2026-06-30T10:07:33.796Z"
// lastSeen : "2026-06-30T10:07:33.796Z"
// preferredLanguage : "string"
// online : true

class ProfileResponses {
  ProfileResponses({
      this.id, 
      this.name, 
      this.email, 
      this.phone, 
      this.bio, 
      this.socialLinks, 
      this.verified, 
      this.role, 
      this.createdAt, 
      this.updatedAt, 
      this.lastSeen, 
      this.preferredLanguage, 
      this.online,});

  ProfileResponses.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    bio = json['bio'];
    socialLinks = json['socialLinks'] != null ? json['socialLinks'].cast<String>() : [];
    verified = json['verified'];
    role = json['role'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    lastSeen = json['lastSeen'];
    preferredLanguage = json['preferredLanguage'];
    online = json['online'];
  }
  String? id;
  String? name;
  String? email;
  String? phone;
  String? bio;
  List<String>? socialLinks;
  bool? verified;
  String? role;
  String? createdAt;
  String? updatedAt;
  String? lastSeen;
  String? preferredLanguage;
  bool? online;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['bio'] = bio;
    map['socialLinks'] = socialLinks;
    map['verified'] = verified;
    map['role'] = role;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['lastSeen'] = lastSeen;
    map['preferredLanguage'] = preferredLanguage;
    map['online'] = online;
    return map;
  }

}