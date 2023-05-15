import 'package:flutter/material.dart';

class AdoptPost extends StatefulWidget {
  const AdoptPost({Key? key}) : super(key: key);

  @override
  State<AdoptPost> createState() => _AdoptPostState();
}

class _AdoptPostState extends State<AdoptPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('List an adoption')
        ),
        body: const SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('add the animal here')
              ],

            ),

          ),

        )
    );
  }
}
