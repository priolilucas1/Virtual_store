import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  User({this.id, this.email, this.name, this.password, this.confirmPassword});

  String? id;
  String? email;
  String? name;
  String? password;
  String? confirmPassword;

  User.fromDocument(DocumentSnapshot document) {
    if (document.exists) {
      id = document.id;
      name = document['name'] as String;
      email = document['email'] as String;
    }
  }

  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.doc('users/$id');

  Future<void> saveData() async {
    await firestoreRef.set(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
    };
  }
}
