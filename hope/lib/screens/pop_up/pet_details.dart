import 'package:flutter/material.dart';
import 'package:hope/classes/adoption.dart';
import 'package:hope/classes/animal.dart';

import '../../settings.dart';

class PetDetails extends StatefulWidget {
  const PetDetails({Key? key, required this.animal}) : super(key: key);
  final Animal animal;

  @override
  State<PetDetails> createState() => _PetDetailsState();
}

class _PetDetailsState extends State<PetDetails> {


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SettingsPrefs().getZoom(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          var zoomLevel = snapshot.data;
          var pet = widget.animal;
          return Scaffold(
              appBar: AppBar(
                  title: const Text('Pet Details')
              ),
              body: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipRRect(
                        child: Image.network(pet.imagePath!),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      Text("${pet.species?.toUpperCase()}", style: TextStyle(fontSize: 20)),
                      Text("${pet.breed?.toUpperCase()}", style: TextStyle(fontSize: 20)),
                      Text("Age: 4", style: TextStyle(fontSize: 20)),
                      ElevatedButton(onPressed: (){
                        //send email code
                      }, child: Text("Contact Owner"))
                    ],

                  ),

                ),

              )
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );

  }
}