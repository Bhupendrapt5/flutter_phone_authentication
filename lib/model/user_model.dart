import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String number;
  final String id;

  User({
    this.number,
    this.id,
  });

  factory User.fromFirebase(DocumentSnapshot snapshot) {
    return User(
      number: snapshot['number'],
      id: snapshot.documentID,
    );
  }
}
