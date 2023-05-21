import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class Model {
  final currentUser = FirebaseAuth.instance.currentUser;
  final db = FirebaseFirestore.instance;
  final users = FirebaseFirestore.instance.collection('users');
  final adoptions = FirebaseFirestore.instance.collection('adoptions');
  final animals = FirebaseFirestore.instance.collection('animals');
}