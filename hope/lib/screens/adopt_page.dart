import 'package:flutter/material.dart';
import 'package:hope/screens/pop_up/adopt_post.dart';
import 'package:hope/settings.dart';

import '../authentication/collections.dart';
import '../classes/adoption.dart';

class AdoptPage extends StatefulWidget {
  const AdoptPage({Key? key}) : super(key: key);

  @override
  State<AdoptPage> createState() => _AdoptPageState();
}

class _AdoptPageState extends State<AdoptPage> {
  double? zoomLevel;

  late List<AdoptDoc> adoptData;
  late List<AdoptDoc> filteredData;

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
                  future: Collections().allAdoptions(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        adoptData =
                            snapshot.data as List<AdoptDoc>;
                        filteredData = adoptData;

                        return RefreshIndicator(
                            onRefresh: refreshList,
                            child: ListView.builder(
                              itemCount: adoptData.length,
                              itemBuilder: (context, index) {
                                AdoptDoc adoptDoc = filteredData[index];
                                return adoptDoc.toListTile(context, zoomLevel!);
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
                  height: 120,
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
                          child: Icon(Icons.filter_alt)),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => AdoptPost()));
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(50, 50),
                            shape: const CircleBorder(),
                          ),
                          child: Icon(Icons.add))
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
    var tmp = await Collections().allAdoptions();
    setState(() {
      adoptData = tmp;
      filteredData = tmp;
    });
  }
}
