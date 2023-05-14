import 'package:flutter/material.dart';

InputDecoration tf_decoration(String text, IconData icon) {
  return InputDecoration(
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
  );
}