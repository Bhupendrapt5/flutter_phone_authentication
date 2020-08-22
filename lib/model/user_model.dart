import 'dart:convert';

class User {
  final String number;
  final String uId;

  User({
    this.number,
    this.uId,
  });

  factory User.fromFirebase(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    return User(
      number: json['phoneNumber'],
      uId: json['uid'],
    );
  }

  String toJson() => json.encode({
        'phoneNumber': number,
        'uid': uId,
      });
}
