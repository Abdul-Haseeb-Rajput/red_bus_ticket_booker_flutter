class UserModel {
  String uid;
  String name;
  String email;
  String profileUrl;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.profileUrl,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'],
      name: data['name'],
      email: data['email'],
      profileUrl: data['profileUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'profileUrl': profileUrl,
    };
  }
}
