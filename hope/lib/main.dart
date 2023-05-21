import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hope/utils/color_utils.dart';
import 'package:hope/widget_tree.dart';
import 'package:memory_cache/memory_cache.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Map<Permission, PermissionStatus> statuses = await [
    Permission.location,
    Permission.storage,
  ].request();
  final location = await Geolocator.getCurrentPosition();
  MemoryCache.instance.create('latitude',location.latitude);
  MemoryCache.instance.create('longitude',location.longitude);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hope',
      theme: ThemeData(
          fontFamily: 'Montserrat',
        primarySwatch: customHex("#f04856"),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: customHex("#f04856"),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          elevation: 5
        )
      ),
      home: WidgetTree()
    );
  }
}



