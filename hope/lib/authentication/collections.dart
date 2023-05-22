import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hope/classes/adoption.dart';
import 'package:hope/classes/user.dart';

import '../classes/animal.dart';

class Collections {

  //
  //
  //
  // Future createAdoption(breed,birthDate,latitude,longitude,species,picture,price) async {
  //   final adoption = AdoptDoc(breed: breed, latitude: latitude,longitude: longitude, species: species, status: "Awaiting", birthDate: birthDate, timeStamp: DateTime.now(), picture: picture,price:price);
  //   final docRef = adoptions.withConverter(fromFirestore: AdoptDoc.fromFirestore, toFirestore: (AdoptDoc adoptDoc, options) => adoptDoc.toFirestore())
  //       .doc();
  //   await docRef.set(adoption);
  // }
  //
  //
  //
  //
  // Future<List<AdoptDoc>> allAdoptions() async {
  //   final snapshot = await _db.collection("adoptions").get();
  //   final adoptData = snapshot.docs.map((e) => AdoptDoc.fromSnapshot(e)).toList();
  //   return adoptData;
  // }
  // // Future<List<AdoptDoc>> filteredAdoptions({
  // //   double? minPrice,
  // //   double? maxPrice,
  // //   String? species,
  // //   double? maxDistance
  // //   }) async {
  // //   final snapshot = await _db.collection("adoptions")
  // //   .where("price",isGreaterThanOrEqualTo: minPrice)
  // //   .where("price",isLessThanOrEqualTo: maxPrice)
  // //   .where("species",isEqualTo: species)
  // //   .where("maxDistance",isLessThanOrEqualTo: maxDistance).get();
  // //   final adoptData = snapshot.docs.map((e) => AdoptDoc.fromSnapshot(e)).toList();
  // //   return adoptData;
  // // }
  //


}