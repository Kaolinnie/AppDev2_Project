import 'package:flutter/material.dart';

import '../../settings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPage> {
  double? zoomLevel;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SettingsPrefs().getZoom(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            zoomLevel = snapshot.data;
            return Scaffold(
                appBar: AppBar(
                    title: const Text('Settings')
                ),
                body: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ListTile(
                            leading: Icon(Icons.zoom_in),
                            title: Slider(
                              value: zoomLevel!,
                              onChanged: (value) {
                                setState(() {
                                  zoomLevel = double.parse((value).toStringAsFixed(1));
                                });
                              },
                              max: 2,
                              min: 0.5,
                            ),
                            trailing: Text("${zoomLevel!}")
                        ),


                        ElevatedButton(onPressed: updateSettings, child: Text('Update'))
                      ],

                    ),

                  ),

                )
            );
          } else {
            return CircularProgressIndicator();
          }
        },
    );

  }
  void updateSettings() async {
    SettingsPrefs().setZoom(zoomLevel);
  }
}
