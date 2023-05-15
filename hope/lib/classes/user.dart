import 'package:cloud_firestore/cloud_firestore.dart';

class UserDoc {
  String? uid;
  String? email;
  String? firstName, lastName;

  UserDoc({required this.uid, required this.email, required this.firstName, required this.lastName});

  factory UserDoc.fromFirestore(
      DocumentSnapshot<Map<String,dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return UserDoc(
      uid: data?['uid'],
      email: data?['email'],
      firstName: data?['firstName'],
      lastName: data?['lastName']
    );
  }

  Map<String,dynamic> toFirestore() {
    return {
      if (uid != null) "uid" : uid,
      if (email != null) "email" : email,
      if (firstName != null) "firstName" : firstName,
      if (lastName != null) "lastName" : lastName
    };
  }
}