import 'package:flutter/material.dart';
import 'package:hope/authentication/auth.dart';

import '../widgets/userWidgets.dart';
import '../widgets/widgets.dart';

class Unverified extends StatelessWidget {
  const Unverified({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: title(),
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Email not verified'),
                gap(size:20),
                Text('Please verify your email to access the application'),
                gap(size:20),
                ElevatedButton(
                  onPressed: Auth().signOut,
                  child: const Text('Leave')
                )
              ],
            )
        )
    );
  }
}
