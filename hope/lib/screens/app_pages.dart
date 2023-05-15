import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hope/authentication/auth.dart';
import 'package:hope/screens/home_page.dart';
import 'package:hope/screens/posts_page.dart';
import 'package:hope/screens/profile_page.dart';
import 'dart:async';

import '../authentication/unverified.dart';
import '../widgets/userWidgets.dart';

class AppPage extends StatefulWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  final User? user = Auth().currentUser;

  bool verified = false;
  Timer? timer;

  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    PostsPage(),
    ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _userPhoto() => Image.network(
    user?.photoURL??'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png',
  );

  @override
  void initState() {
    super.initState();

    checkEmailVerified();

    verified = Auth().verified();

    if(!verified) {
      Auth().sendEmailVerification();

      timer = Timer.periodic(
          Duration(seconds:3),
              (_) => checkEmailVerified()
      );
    }

  }

  Future checkEmailVerified() async {
    await Auth().reloadUser();

    setState(() {
      verified = Auth().verified();
    });

    if (verified) timer?.cancel();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return verified ? app() : const Unverified();
  }

  Widget app() {
    return Scaffold(
      appBar: AppBar(
        title: title(),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _selectedIndex = 2;
              });
            },
            icon: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: _userPhoto()

            ),
          ),
        ],

      ),
      body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: _widgetOptions[_selectedIndex]
          )

      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_box_outlined),
                label: 'Post'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile'
            ),
          ],
          currentIndex: _selectedIndex,
          iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5
      ),
    );
  }
}

