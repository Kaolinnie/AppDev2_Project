import 'package:shared_preferences/shared_preferences.dart';

class SettingsPrefs {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void setDefaults() async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setDouble("zoom",1);
  }

  void setZoom(zoomLevel) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setDouble("zoom",zoomLevel);
  }

  Future<double?> getZoom() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getDouble("zoom");
  }
}