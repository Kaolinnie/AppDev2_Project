import 'package:flutter/material.dart';

import '../utils/color_utils.dart';

TextField reusableText(String text, IconData icon, bool isPasswordType, TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    style: TextStyle(
      color: Colors.white.withOpacity(0.9)
    ),
    decoration: InputDecoration(
      prefixIcon: Icon(icon, color: Colors.white70,),
      labelText: text,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.2),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(
          width: 0,
          style: BorderStyle.none
        ),
      ),
    ),
    keyboardType: isPasswordType? TextInputType.visiblePassword : TextInputType.emailAddress,
  );
}


TextField reusableText2(String text, TextEditingController controller, {
  icon,
  isPasswordType = false,
  textInputType = TextInputType.text
  }) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.black,
    style: TextStyle(
        color: Colors.black.withOpacity(0.9)
    ),
    decoration: InputDecoration(
      prefixIcon: Icon(icon, color: Colors.black,),
      labelText: text,
      labelStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
      filled: false,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      fillColor: Colors.black.withOpacity(0.1),
      border: const OutlineInputBorder(
        borderSide: BorderSide(
            width: 1,
            style: BorderStyle.solid
        ),
      ),
    ),
    keyboardType: isPasswordType? TextInputType.visiblePassword : textInputType,
  );
}

TextField reusableText3(String text, TextEditingController controller, {
  icon,
  textInputType = TextInputType.text
}) {
  return TextField(
    controller: controller,
    obscureText: false,
    enableSuggestions: true,
    cursorColor: Colors.white,
    style: TextStyle(
        color: Colors.white.withOpacity(0.9)
    ),
    decoration: InputDecoration(
      prefixIcon: Icon(icon, color: Colors.white70,),
      labelText: text,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.2),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none
        ),
      ),
    ),
    keyboardType: textInputType,
  );
}


SizedBox sizedColumn(
    {required double size, required List<Widget> widgets, MainAxisAlignment? mainAxisAlignment}){
  return SizedBox(
    height: size,
    child: Column(
      mainAxisAlignment: mainAxisAlignment!,
      children: widgets
    )
  );
}

SizedBox gap({double? size = 15}){
  return SizedBox(
    height: size
  );
}

SnackBar errorMessage(errorMsg,context) => SnackBar(
  content: Text(errorMsg!),
  backgroundColor: Theme.of(context).primaryColor,
  behavior: SnackBarBehavior.floating,
);



TextFormField formField(hint,controller) => TextFormField(
  controller: controller,
  decoration: InputDecoration(
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 20,
    ),
    hintText: hint,
    hintStyle: const TextStyle(fontSize: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  ),
);



