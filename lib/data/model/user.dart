import 'dart:convert';

class User {
  final String name;
  final String profileURL;
  User({
    required this.name,
    required this.profileURL,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profileURL': profileURL,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      profileURL: map['profileURL'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
