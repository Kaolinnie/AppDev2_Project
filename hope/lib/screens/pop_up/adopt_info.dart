import 'package:flutter/material.dart';
import '../../classes/adoption.dart';

class AdoptInfo extends StatefulWidget {
  final AdoptDoc adoptDoc;
  const AdoptInfo({Key? key, required this.adoptDoc}) : super(key: key);

  @override
  State<AdoptInfo> createState() => _AdoptInfoState();
}

class _AdoptInfoState extends State<AdoptInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Adopt Info')
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.adoptDoc.species??'NOT FOUND')
              ],

            ),

          ),

        )
    );
  }
}
