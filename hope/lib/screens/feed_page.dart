import 'package:flutter/material.dart';
import 'package:hope/screens/pop_up/addAnimal.dart';

import '../classes/animal.dart';
import '../settings.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  double? zoomLevel;

  late List<Animal> animalData;
  late List<Animal> filteredData;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SettingsPrefs().getZoom(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            zoomLevel = snapshot.data;
            return Stack(
              alignment: Alignment.bottomRight,
              children: [
                FutureBuilder(
                  future: Animal.getAnimals(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        animalData =
                        snapshot.data as List<Animal>;
                        filteredData = animalData;

                        return RefreshIndicator(
                            onRefresh: refreshList,
                            child: ListView.builder(
                              itemCount: animalData.length,
                              itemBuilder: (context, index) {
                                Animal animal = filteredData[index];
                                return animal.toListTile(context, zoomLevel!);
                              },
                            )
                        );

                      } else if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString()));
                      }
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
                SizedBox(
                  height: 60,
                  width: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            // filter adoptions
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(50, 50),
                            shape: const CircleBorder(),
                          ),
                          child: Icon(Icons.filter_alt))
                    ],
                  ),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }

  Future<void> refreshList() async {
    var tmp = await Animal.getAnimals();
    setState(() {
      animalData = tmp;
      filteredData = tmp;
    });
  }
}
