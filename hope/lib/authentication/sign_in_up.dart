import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hope/authentication/auth.dart';
import 'package:hope/utils/color_utils.dart';
import 'package:hope/widgets/widgets.dart';

class SignInUpScreen extends StatefulWidget {
  const SignInUpScreen({Key? key}) : super(key: key);

  @override
  State<SignInUpScreen> createState() => _SignInUpScreenState();
}

class _SignInUpScreenState extends State<SignInUpScreen> {
  String? errorMessage = '';
  bool isLogin = true;

  TextEditingController emailTec = TextEditingController();
  TextEditingController passwordTec = TextEditingController();
  TextEditingController confirmPasswordTec = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(email: emailTec.text, password: passwordTec.text);
    } on FirebaseAuthException catch(e) {
      errorMessage = e.message;
      ScaffoldMessenger.of(context).showSnackBar(_errorMessage());
    }
  }
  Future<void> createUserWithEmailAndPassword() async {
    if(passwordTec.text != confirmPasswordTec.text) {
      errorMessage = 'Passwords do not match';
      ScaffoldMessenger.of(context).showSnackBar(_errorMessage());
      return;
    }

    try {
      await Auth().createUserWithEmailAndPassword(email: emailTec.text, password: passwordTec.text);
    } on FirebaseAuthException catch(e) {
      errorMessage = e.message;
      ScaffoldMessenger.of(context).showSnackBar(_errorMessage());
    }
  }

  SnackBar _errorMessage() => SnackBar(
      content: Text(errorMessage!),
    backgroundColor: hexStringToColor("#D9793D"),
    behavior: SnackBarBehavior.floating,
  );

  Widget _submitButton() => ElevatedButton(
    onPressed: isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
    style: ElevatedButton.styleFrom(
      backgroundColor: hexStringToColor("#D9793D")
    ),
    child: Text(isLogin? 'Login' : 'Register')
  );

  Widget _loginOrRegisterButton() => TextButton(
    onPressed: (){
      setState((){
        isLogin = !isLogin;
      });
    },
    child: Text(isLogin?'Don\'t have an account?':'Already have an account?', style: const TextStyle(
      color: Colors.white
    ))
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("#F9E7BB"),
              hexStringToColor("#E97CBB"),
              hexStringToColor("#D9793D"),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight
          )
        ),
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Column(
                  children: [
                    Text('Hope', style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontFamily: 'ShadowsIntoLight'
                    )),
                    // ClipRRect(
                    //   borderRadius: BorderRadius.circular(20),
                    //   child: Image.network("https://wallpaperaccess.com/full/384178.jpg",
                    //     height: 300,
                    //     width: 300,
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                  ],
                ),
                content()
              ],
            )
        )
      )
    );
  }

  Widget content() => isLogin ? login() : register();

  Widget login() => Column(
    children: [
      sizedColumn(
          widgets: [
            reusableText("Enter email", Icons.person_outline, false, emailTec),
            reusableText("Enter password", Icons.lock, true, passwordTec),
          ], mainAxisAlignment: MainAxisAlignment.spaceBetween, size: 125),
      _submitButton(),
      _loginOrRegisterButton()
    ],
  );

  Widget register() => Column(
    children: [
      sizedColumn(
          widgets: [
            reusableText("Enter email", Icons.person_outline, false, emailTec),
            reusableText("Enter password", Icons.lock, true, passwordTec),
            reusableText("Confirm password", Icons.check, true, confirmPasswordTec),
          ], mainAxisAlignment: MainAxisAlignment.spaceBetween, size: 200),
      _submitButton(),
      _loginOrRegisterButton()
    ],
  );
}

