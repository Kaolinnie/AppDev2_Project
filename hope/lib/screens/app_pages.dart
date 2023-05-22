import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hope/authentication/auth.dart';
import 'package:hope/screens/home_page.dart';
import 'package:hope/screens/adopt_page.dart';
import 'package:hope/screens/pop_up/settings.dart';
import 'package:hope/screens/feed_page.dart';
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
    FeedPage(),
    AdoptPage(),
    ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
              Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
            },
            icon: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Icon(Icons.settings)
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
                icon: Icon(Icons.feed),
                label: 'Feed'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.pets),
                label: 'Adopt'
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

