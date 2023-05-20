import 'package:geolocator/geolocator.dart';

Future<Position> getPosition() async {
  return await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.medium
  );
}