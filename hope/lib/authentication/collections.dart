import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hope/classes/adoption.dart';
import 'package:hope/classes/user.dart';

import '../classes/animal.dart';

class Collections {
  final users = FirebaseFirestore.instance.collection('users');
  final adoptions = FirebaseFirestore.instance.collection('adoptions');
  final animals = FirebaseFirestore.instance.collection('animals');
  final currentUser = FirebaseAuth.instance.currentUser;
  final _db = FirebaseFirestore.instance;


  Future createUser(firstName, lastName) async {
    final user = UserDoc(
      firstName: firstName,
      lastName: lastName,
      uid: currentUser!.uid,
      email: currentUser!.email??''
    );
    final docRef = users.withConverter(fromFirestore: UserDoc.fromFirestore, toFirestore: (UserDoc userDoc, options) => userDoc.toFirestore())
        .doc("${user.uid}");
    await docRef.set(user);
  }

  Future<UserDoc> getUserDetails(String email) async {
    final snapshot = await _db.collection("users").where("email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserDoc.fromSnapshot(e)).single;
    return userData;
  }

  Future<List<UserDoc>> allUsers() async {
    final snapshot = await _db.collection("users").get();
    final userData = snapshot.docs.map((e) => UserDoc.fromSnapshot(e)).toList();
    return userData;
  }



  Future createAdoption(breed,birthDate,latitude,longitude,species,picture,price) async {
    final adoption = AdoptDoc(breed: breed, latitude: latitude,longitude: longitude, species: species, status: "Awaiting", birthDate: birthDate, timeStamp: DateTime.now(), picture: picture,price:price);
    final docRef = adoptions.withConverter(fromFirestore: AdoptDoc.fromFirestore, toFirestore: (AdoptDoc adoptDoc, options) => adoptDoc.toFirestore())
        .doc();
    await docRef.set(adoption);
  }




  Future<List<AdoptDoc>> allAdoptions() async {
    final snapshot = await _db.collection("adoptions").get();
    final adoptData = snapshot.docs.map((e) => AdoptDoc.fromSnapshot(e)).toList();
    return adoptData;
  }
  // Future<List<AdoptDoc>> filteredAdoptions({
  //   double? minPrice,
  //   double? maxPrice,
  //   String? species,
  //   double? maxDistance
  //   }) async {
  //   final snapshot = await _db.collection("adoptions")
  //   .where("price",isGreaterThanOrEqualTo: minPrice)
  //   .where("price",isLessThanOrEqualTo: maxPrice)
  //   .where("species",isEqualTo: species)
  //   .where("maxDistance",isLessThanOrEqualTo: maxDistance).get();
  //   final adoptData = snapshot.docs.map((e) => AdoptDoc.fromSnapshot(e)).toList();
  //   return adoptData;
  // }



}