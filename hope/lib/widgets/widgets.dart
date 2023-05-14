import 'package:flutter/material.dart';

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

SizedBox gap(){
  return const SizedBox(
    height: 10
  );
}










