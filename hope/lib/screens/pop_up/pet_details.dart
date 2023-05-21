import 'package:flutter/material.dart';
import 'package:hope/classes/adoption.dart';

import '../../settings.dart';

class PetDetails extends StatefulWidget {
  const PetDetails({Key? key, required this.adoptDoc}) : super(key: key);
  final AdoptDoc adoptDoc;

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
          var pet = widget.adoptDoc;
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${pet.species}")
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