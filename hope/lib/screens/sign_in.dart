import 'package:flutter/material.dart';
import 'package:hope/utils/color_utils.dart';
import 'package:hope/widgets/widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController usernameTec = TextEditingController();
  TextEditingController passwordTec = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("#29b2c2"),
              hexStringToColor("#14328c"),
              hexStringToColor("#2f055e"),
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
                Column(
                  children: [
                    Column(
                      children: [
                        sizedColumn(
                            widgets: [
                          reusableText("Enter username", Icons.person_outline, false, usernameTec),
                          reusableText("Enter password", Icons.lock, true, passwordTec),
                        ], mainAxisAlignment: MainAxisAlignment.spaceBetween, size: 125),
                      ],
                    )

                  ],
                ),
              ],
            )
        )
      )
    );
  }
}
