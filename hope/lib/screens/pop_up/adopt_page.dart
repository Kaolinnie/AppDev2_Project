import 'package:flutter/material.dart';
import 'package:hope/screens/pop_up/adopt_post.dart';

class AdoptPage extends StatefulWidget {
  const AdoptPage({Key? key}) : super(key: key);

  @override
  State<AdoptPage> createState() => _AdoptPageState();
}

class _AdoptPageState extends State<AdoptPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        const SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Text('test')
            ],
          )
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AdoptPost()));
          },
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(50,50),
            shape: const CircleBorder(),
          ),
          child: const Icon(Icons.add),
        )
      ],
    );
  }
}
