import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hope/settings.dart';

import '../screens/pop_up/adopt_info.dart';

class AdoptDoc {
  String? breed, locale, species, status, picture;
  DateTime? timeStamp, birthDate;

  AdoptDoc(
      {required this.breed, required this.locale, required this.species, required this.status, required this.birthDate,required this.timeStamp, required this.picture});

  factory AdoptDoc.fromFirestore(
      DocumentSnapshot<Map<String,dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return AdoptDoc(
        breed: data?["breed"],
        locale: data?["locale"],
        species: data?["species"],
        status: data?["status"],
        birthDate: data?["birthDate"],
        timeStamp: data?["timeStamp"],
        picture: data?["picture"]
    );
  }

  factory AdoptDoc.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return AdoptDoc(
        breed: data["breed"],
        locale: data["locale"],
        species: data["species"],
        status: data["status"],
        birthDate: DateTime.parse(data["birthDate"]),
        timeStamp: DateTime.parse(data["timeStamp"]),
        picture: data["picture"]
    );
  }

  Map<String,dynamic> toFirestore() {
    return {
      "breed" : breed,
      "locale" : locale,
      "species": species,
      "status": status,
      "birthDate": birthDate.toString(),
      "timeStamp": timeStamp.toString(),
      "picture" : picture
    };
  }

  Widget toListTile(context, double zoomLevel){

    return SizedBox(
      width: double.infinity,
      height:  zoomLevel * 100,
      child: Row(
        children: [
          Image.network(picture!,
            fit: BoxFit.cover,
            height: double.infinity,
            width: 150,
          ),
          Text("${species!} - ${breed!}")
        ],
      )
    );


    return ListTile(
      onTap: () {
        Navigator.push(context,MaterialPageRoute(builder: (context) => AdoptInfo(adoptDoc: this)));
      },
      title: Text("${species!} - ${breed}"),
      leading: Image.network(picture!),
    );
  }
}