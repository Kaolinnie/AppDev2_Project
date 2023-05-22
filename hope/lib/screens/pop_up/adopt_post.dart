import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hope/classes/adoption.dart';
import 'package:hope/utils/datepicker.dart';
import 'package:hope/utils/location.dart';
import 'package:hope/widgets/widgets.dart';
import 'package:intl/intl.dart';

import '../../authentication/collections.dart';
import '../../utils/color_utils.dart';
import '../../utils/functions.dart';

class AdoptPost extends StatefulWidget {
  const AdoptPost({Key? key}) : super(key: key);

  @override
  State<AdoptPost> createState() => _AdoptPostState();
}

class _AdoptPostState extends State<AdoptPost> {
  File? _photo;
  Widget _petPhoto() {
    if (_photo == null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.network(
            'https://i.pinimg.com/originals/a0/8b/a5/a08ba59656e06a42390959bc59e14d0d.jpg',
            height: 150,
            width: 150,
            fit: BoxFit.cover
        ),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Image.file(
          _photo!,
          height: 150,
          width: 150,
          fit: BoxFit.cover
      ),
    );
  }


  Widget _animalPic() =>
      Stack(
        alignment: Alignment.bottomRight,
        children: [
          _petPhoto(),
          GestureDetector(
            onTap: () async {
              File? photo = await Images().pickImage();

              if (photo.path != '') {
                setState(() {
                  _photo = photo;
                });
              }
            },
            child: CircleAvatar(
                radius: 20,
                backgroundColor: Theme.of(context).primaryColor,
                child: const Icon(Icons.add, size: 25, color: Colors.white)
            ),
          )
        ],
      );

  final breedTec = TextEditingController();
  final speciesTec = TextEditingController();
  final statusTec = TextEditingController();
  final priceTec = TextEditingController();

  DateTime date = DateTime.now();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('List an adoption')
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _animalPic(),
                Divider(indent: 50, endIndent: 50, thickness: 1),
                reusableText2("Species", speciesTec),
                SizedBox(height: 10),
                reusableText2("Breed", breedTec),
                SizedBox(height: 10),
                reusableText2('Price', priceTec, textInputType: TextInputType.number),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: getDate ,
                        child: Text('Date of Birth')
                    ),
                    Text(DateFormat('yyyy-MM-dd').format(date))
                  ],
                ),
                SizedBox(height: 50),

                ElevatedButton(
                    onPressed: () async {
                      final species = speciesTec.text;
                      final breed = breedTec.text;

                      double price;

                      if(species == '' || breed == '' || date == null) {
                        _sendErrorMessage('Missing fields');
                        return;
                      }
                      try {
                        price = double.parse(double.parse(priceTec.text).toStringAsFixed(2));
                      } on FormatException catch (e){
                        _sendErrorMessage('Bad format: price');
                        return;
                      }

                      final location = await getPosition();

                      final url = await Images().uploadPic(_photo!,'adoptions');


                      // AdoptDoc.createAdoption(breed,date,location.latitude,location.longitude,species,url,price);

                      Navigator.pop(context);
                    },
                    child: Text('Submit')
                )
              ],

            ),

          ),

        )
    );
  }
  void getDate() async {
    final results =(await pickDate(context))[0];
    setState(() {
      date = results;

    });
  }

  void _sendErrorMessage(msg) {
    ScaffoldMessenger.of(context).showSnackBar(errorMessage(msg,context));
  }
}
