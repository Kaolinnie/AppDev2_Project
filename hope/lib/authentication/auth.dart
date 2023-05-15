import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    await updateDisplayName(displayName: displayName);
    sendEmailVerification();
  }

  Future<void> sendEmailVerification() async {
    await currentUser?.sendEmailVerification();
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> updateDisplayName({
    required String displayName
  }) async {
    await currentUser?.updateDisplayName(displayName);
  }

  Future<void> updatePhoto({
    required String photoUrl
  }) async {
    await currentUser?.updatePhotoURL(photoUrl);
  }
  Future<void> updatePhone({
    required PhoneAuthCredential phoneAuthCredential
  }) async {
    await currentUser?.updatePhoneNumber(phoneAuthCredential);
  }

  Future<void> reloadUser() async {
    currentUser?.reload();
  }

  bool verified() { return currentUser!.emailVerified; }
}