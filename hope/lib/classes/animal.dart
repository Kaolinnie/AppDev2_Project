import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/pop_up/pet_details.dart';

class Animal {
  static final _currentUser = FirebaseAuth.instance.currentUser;
  static final _db = FirebaseFirestore.instance;
  static final _animals = FirebaseFirestore.instance.collection('animals');

  final String? docID;
  final String? species;
  final String? breed;
  final String? name;
  final DateTime? dob;
  final String? imagePath;
  final String? userUID;

  Animal(
      {required this.docID,
      required this.species,
      required this.breed,
      required this.name,
      required this.dob,
      required this.imagePath,
      required this.userUID});

  factory Animal.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Animal(
        docID: snapshot.reference.id,
        species: data?["species"],
        breed: data?["breed"],
        name: data?["name"],
        dob: (data?["dob"] as Timestamp).toDate(),
        imagePath: data?["imagePath"],
        userUID: data?["userUID"]);
  }

  factory Animal.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return Animal(
        docID: document.reference.id,
        species: data["species"],
        breed: data["breed"],
        name: data["name"],
        dob: (data["dob"] as Timestamp).toDate(),
        imagePath: data["imagePath"],
        userUID: data["userUID"]);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "species": species,
      "breed": breed,
      "name": name,
      "dob": dob,
      "imagePath": imagePath,
      "userUID": userUID
    };
  }

  static final List<String> _species = [
    "Cat",
    "Dog",
    "Rabbit",
    "Bird",
    "Fish",
    "Other"
  ];

  static List<DropdownMenuItem<String>>
      get speciesOptionsDropdown => _species
          .map((e) => DropdownMenuItem<String>(
              child: Text(e, style: const TextStyle(fontSize: 14)),
        value: e,
      ))
          .toList();

  Image _getImage() => Image.network(imagePath!);

  static Future insertAnimal(species, breed, name, dob, imagePath) async {
    Animal animal = Animal(
        docID: '',
        species: species,
        breed: breed,
        name: name,
        dob: dob,
        imagePath: imagePath,
        userUID: _currentUser?.uid);

    final docRef = _animals
        .withConverter(
            fromFirestore: Animal.fromFirestore,
            toFirestore: (Animal animal, options) => animal.toFirestore())
        .doc();
    await docRef.set(animal);
  }

  static Future delAnimal(String index) async {
    _animals.doc(index).delete();
    print(index);
  }

  static Future<List<Animal>> getAnimals() async {
    final snapshot = await _animals.get();
    final animalData =
        snapshot.docs.map((e) => Animal.fromSnapshot(e)).toList();
    return animalData;
  }

  static Future<List<Animal>> getAnimalsByUser(userUID) async {
    final snapshot = await _animals.where("userUID", isEqualTo: userUID).get();
    final animalData =
        snapshot.docs.map((e) => Animal.fromSnapshot(e)).toList();
    return animalData;
  }
  static Future<List<Animal>> getMyAnimals() async {
    final snapshot = await _animals.where("userUID", isEqualTo: _currentUser?.uid).get();
    final animalData =
    snapshot.docs.map((e) => Animal.fromSnapshot(e)).toList();
    return animalData;
  }

  static Future<Animal> getAnimalByID(docID) async {
    final snapshot = await _animals.get(docID);
    final animalData = snapshot.docs.map((e) => Animal.fromSnapshot(e)).single;
    return animalData;
  }

  Widget toListTile(context, double zoomLevel) {
    return Card(
      color: CupertinoColors.systemGrey5,
      elevation: 5,
      child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PetDetails(animal: this)));
          },
          child: SizedBox(
              width: double.infinity,
              height: zoomLevel * 100,
              child: Row(
                children: [
                  Image.network(
                    imagePath!,
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: 150,
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      Text("${name!}: $species"),
                    ],
                  )),
                ],
              ))),
    );
  }

}
