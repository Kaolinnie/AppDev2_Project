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

  final emailTec = TextEditingController();
  final passwordTec = TextEditingController();
  final confirmPasswordTec = TextEditingController();
  final phoneTec = TextEditingController();
  final firstNameTec = TextEditingController();
  final lastNameTec = TextEditingController();
  final codeSentTec = TextEditingController();

  late PhoneAuthCredential credential;

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(email: emailTec.text, password: passwordTec.text);
    } on FirebaseAuthException catch(e) {
      errorMessage = e.message;
      ScaffoldMessenger.of(context).showSnackBar(_errorMessage());
    }
  }
  Future<void> createUserWithEmailAndPassword() async {
    if(firstNameTec.text == '' || lastNameTec.text == '') errorMessage = '$errorMessage\nPlease enter your name';
    if(passwordTec.text != confirmPasswordTec.text) errorMessage = '$errorMessage\nPasswords do not match';

    if (errorMessage!=''){
      _sendErrorMessage();
      return;
    }

    try {
      await Auth().createUserWithEmailAndPassword(email: emailTec.text, password: passwordTec.text, displayName: "${firstNameTec.text} ${lastNameTec.text}");
      await Auth().addUser(firstNameTec.text, lastNameTec.text);
    } on FirebaseAuthException catch(e) {
      errorMessage = e.message;
      _sendErrorMessage();
    }

  }

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
            padding: const EdgeInsets.all(25),
            child: content()
        )
        )
      );
  }

  Widget content() => Column(
    children: [
      const Text('Hope', style: TextStyle(
          color: Colors.white,
          fontSize: 50,
          fontFamily: 'ShadowsIntoLight'
      )),
      Expanded(
        child: isLogin ? login() : registerPages()
      ),
    ],
  );


  Widget login() => Column(
    mainAxisAlignment: MainAxisAlignment.center,
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

  Widget registerPages() {
    final pageController = PageController();
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: pageController,
      children: [
        Container(
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  reusableText3("Enter first name", firstNameTec, textInputType: TextInputType.name, icon: Icons.abc),
                  gap(),
                  reusableText3("Enter last name", lastNameTec, textInputType: TextInputType.name, icon: Icons.abc),
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    pageController.nextPage(duration: const Duration(milliseconds: 200), curve: Curves.linear);
                  },
                  child: const Text('Next')
              ),
              _loginOrRegisterButton()

            ],
          ),
        ),
        Container(
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  reusableText("Enter email", Icons.person_outline, false, emailTec),
                  gap(),
                  reusableText("Enter password", Icons.lock, true, passwordTec),
                  gap(),
                  reusableText("Confirm password", Icons.check, true, confirmPasswordTec),
                ],
              ),
              _submitButton(),
              _loginOrRegisterButton()
            ],
          ),
        ),
      ],
    );
  }

  void _sendErrorMessage() {
    ScaffoldMessenger.of(context).showSnackBar(_errorMessage());
    errorMessage = '';
  }

  SnackBar _errorMessage() => SnackBar(
    content: Text(errorMessage!),
    backgroundColor: hexStringToColor("#D9793D"),
    behavior: SnackBarBehavior.floating,
  );

  Widget _submitButton() => ElevatedButton(
      onPressed: isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
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
}

