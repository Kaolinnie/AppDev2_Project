import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDoc {
  static final _users = FirebaseFirestore.instance.collection('users');
  static final _currentUser = FirebaseAuth.instance.currentUser;
  static final _db = FirebaseFirestore.instance;

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

  factory UserDoc.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;
    return UserDoc(
        uid: data["uid"],
        email: data["email"],
        firstName: data["firstName"],
        lastName: data["lastName"]
    );
  }

  static Future createUser(firstName, lastName) async {
    final user = UserDoc(
        firstName: firstName,
        lastName: lastName,
        uid: _currentUser!.uid,
        email: _currentUser!.email??''
    );
    final docRef = _users.withConverter(fromFirestore: UserDoc.fromFirestore, toFirestore: (UserDoc userDoc, options) => userDoc.toFirestore())
        .doc("${user.uid}");
    await docRef.set(user);
  }

  static Future<UserDoc> getUserDetails(String email) async {
    final snapshot = await _db.collection("users").where("email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserDoc.fromSnapshot(e)).single;
    return userData;
  }

  static Future<List<UserDoc>> allUsers() async {
    final snapshot = await _db.collection("users").get();
    final userData = snapshot.docs.map((e) => UserDoc.fromSnapshot(e)).toList();
    return userData;
  }
}