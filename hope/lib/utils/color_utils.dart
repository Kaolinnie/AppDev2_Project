import 'package:flutter/material.dart';

hexStringToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if(hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  return Color(int.parse(hexColor, radix:16));
}

MaterialColor customColor(Color color) {
  int red = color.red;
  int green = color.green;
  int blue = color.blue;
  Map<int, Color> shades = {
    50: Color.fromARGB(10, red, green, blue),
    100: Color.fromARGB(20, red, green, blue),
    200: Color.fromARGB(30, red, green, blue),
    300: Color.fromARGB(40, red, green, blue),
    400: Color.fromARGB(50, red, green, blue),
    500: Color.fromARGB(60, red, green, blue),
    600: Color.fromARGB(70, red, green, blue),
    700: Color.fromARGB(80, red, green, blue),
    800: Color.fromARGB(90, red, green, blue),
    900: Color.fromARGB(100, red, green, blue),
  };

  return MaterialColor(color.value, shades);
}
MaterialColor customHex(String hexColor) => customColor(hexStringToColor(hexColor));

