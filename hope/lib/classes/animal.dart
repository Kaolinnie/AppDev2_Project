import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hope/core/model.dart';

class Animal extends Model {
  final String? docID;
  final Species? species;
  final String? breed;
  final String? name;
  final DateTime? dob;
  final String? imagePath;
  final String? userUID;

  Animal({required this.docID, required this.species,required this.breed,required this.name,required this.dob, required this.imagePath, required this.userUID});


  factory Animal.fromFirestore(
      DocumentSnapshot<Map<String,dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Animal(
      docID: snapshot.reference.id,
      species: speciesMap[data?["species"]],
      breed: data?["breed"],
      name: data?["name"],
      dob: data?["dob"],
      imagePath: data?["imagePath"],
      userUID: data?["userUID"]
    );
  }

  factory Animal.fromSnapshot(
      DocumentSnapshot<Map<String,dynamic>> document
      ) {
    final data = document.data()!;
    return Animal(
        docID: document.reference.id,
        species: speciesMap[data["species"]],
        breed: data["breed"],
        name: data["name"],
        dob: data["dob"],
        imagePath: data["imagePath"],
        userUID: data?["userUID"]
    );
  }

  Map<String,dynamic> toFirestore() {
    return {
      "species" : species.toString(),
      "breed" : breed,
      "name" : name,
      "dob" : dob,
      "imagePath" : imagePath,
      "userUID" : userUID
    };
  }

  static final Map<String,Species> speciesMap = {
    "Cat":Species.Cat,
    "Dog":Species.Dog,
    "Rabbit":Species.Rabbit,
    "Bird":Species.Bird,
    "Fish":Species.Fish
  };

  Image _getImage() => Image.network(imagePath!);

  Future insertAnimal(Animal animal) async {
    final docRef =
    animals.withConverter(
        fromFirestore: Animal.fromFirestore,
        toFirestore: (Animal animal,options) => animal.toFirestore()
    ).doc();
    await docRef.set(animal);
  }
  Future<List<Animal>> getAnimals() async {
    final snapshot = await animals.get();
    final animalData = snapshot.docs.map((e) => Animal.fromSnapshot(e)).toList();
    return animalData;
  }
  Future<List<Animal>> getAnimalsByUser(userUID) async {
    final snapshot = await animals.where(
        "userUID", isEqualTo: userUID
    ).get();
    final animalData = snapshot.docs.map((e) => Animal.fromSnapshot(e)).toList();
    return animalData;
  }
  Future<Animal> getAnimalByID(docID) async {
    final snapshot = await animals.get(docID);
    final animalData = snapshot.docs.map((e) => Animal.fromSnapshot(e)).single;
    return animalData;
  }
}

enum Species {
  Cat,
  Dog,
  Rabbit,
  Bird,
  Fish
}