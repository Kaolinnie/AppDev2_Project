import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hope/screens/pop_up/pet_details.dart';
import 'package:memory_cache/memory_cache.dart';

class AdoptDoc {
  String? breed, species, status, picture;
  DateTime? timeStamp, birthDate;
  double? price;
  double? latitude,longitude;
  double? distanceKm;

  AdoptDoc(
      {this.breed,
      this.species,
      this.status,
      this.picture,
      this.timeStamp,
      this.birthDate,
      this.price,
      this.latitude,
      this.longitude}) {
    distanceKm = getDistance();
  }

  double getDistance() {
    final lat = MemoryCache.instance.read("latitude");
    final lon = MemoryCache.instance.read("longitude");
    final result = ((Geolocator.distanceBetween(
        latitude!,
        longitude!,
        lat,
        lon
    ))/1000);
    return double.parse(result.toStringAsFixed(1));
  }


  factory AdoptDoc.fromFirestore(
      DocumentSnapshot<Map<String,dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return AdoptDoc(
        breed: data?["breed"],
        latitude: data?["latitude"],
        longitude: data?["longitude"],
        species: data?["species"],
        status: data?["status"],
        birthDate: data?["birthDate"],
        timeStamp: data?["timeStamp"],
        picture: data?["picture"],
        price: data?["price"]
    );
  }

  factory AdoptDoc.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return AdoptDoc(
        breed: data["breed"],
        latitude: data["latitude"],
        longitude: data["longitude"],
        species: data["species"],
        status: data["status"],
        birthDate: DateTime.parse(data["birthDate"]),
        timeStamp: DateTime.parse(data["timeStamp"]),
        picture: data["picture"],
        price: data["price"]
    );
  }

  Map<String,dynamic> toFirestore() {
    return {
      "breed" : breed,
      "longitude" : longitude,
      "latitude" : latitude,
      "species": species,
      "status": status,
      "birthDate": birthDate.toString(),
      "timeStamp": timeStamp.toString(),
      "picture" : picture,
      "price" : price
    };
  }

  Widget toListTile(context, double zoomLevel) {
    return Card(
      color: CupertinoColors.systemGrey5,
      elevation: 5,
      child: InkWell(
          onTap: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => PetDetails(adoptDoc: this)));
          },
          child: SizedBox(
              width: double.infinity,
              height:  zoomLevel * 100,
              child: Row(
                children: [
                  Image.network(picture!,
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: 150,
                  ),
                  Expanded(
                      child: Column(
                        children: [
                          Text("${species!} - ${breed!}"),
                          Text("$distanceKm km"),
                          Text("\$$price")
                        ],
                      )
                  ),
                ],
              )
          )
      ),
    );
  }
}


