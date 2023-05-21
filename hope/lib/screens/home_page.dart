import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            ClipOval(
              child: SizedBox.fromSize(
                size: const Size.fromRadius(150),
                child: Image.network(
                  'https://cdn.discordapp.com/attachments/810218257889493023/1109947912475127919/PXL_20230420_0223218803.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              "Welcome to Hope!",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, height: 2, color: Colors.black),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  Text(
                    "This app is dedicated to Hope the Scottish Straight who has brought joy, laughter, and cuteness into the vast digital world of the internet. Our goal is that no animal, will have to fight for a home, service or love of all kinds. ",
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold, height: 1.5, color: Colors.black),
                  ),
                ],

              ),
            ),
          ],
        ),
      ),
    );
  }
}
