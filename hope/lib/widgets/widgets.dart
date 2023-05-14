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












