class User {
  String? displayName;
  String? email;
  String? userId;
  String? photoUrl;
  String? logedInPlatform;

  User(
      {this.displayName,
      this.logedInPlatform,
      this.email,
      this.userId,
      this.photoUrl});

  User.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    email = json['email'];
    userId = json['userId'];
    photoUrl = json['photoUrl'];
    logedInPlatform = json['logedInPlatform'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['displayName'] = displayName;
    data['email'] = email;
    data['userId'] = userId;
    data['logedInPlatform'] = logedInPlatform;
    data['photoUrl'] = photoUrl;
    return data;
  }
}
