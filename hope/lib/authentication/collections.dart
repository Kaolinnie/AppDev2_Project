import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hope/classes/user.dart';

class Collections {
  final users = FirebaseFirestore.instance.collection('users');
  final currentUser = FirebaseAuth.instance.currentUser;


  Future createUser(firstName, lastName) async {

    final user = UserDoc(
      firstName: firstName,
      lastName: lastName,
      uid: currentUser!.uid,
      email: currentUser!.email??''
    );
    final docRef = users.withConverter(fromFirestore: UserDoc.fromFirestore, toFirestore: (UserDoc userDoc, optoins) => userDoc.toFirestore())
        .doc("${user.uid}");
    await docRef.set(user);
  }
}