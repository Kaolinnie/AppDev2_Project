import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hope/utils/location.dart';
import 'package:hope/widgets/widgets.dart';

import '../../authentication/collections.dart';
import '../../utils/color_utils.dart';
import '../../utils/functions.dart';

import 'package:syncfusion_flutter_datepicker/datepicker.dart';

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
                backgroundColor: customHex("#f04856"),
                child: const Icon(Icons.add, size: 25, color: Colors.white)
            ),
          )
        ],
      );

  final breedTec = TextEditingController();
  final speciesTec = TextEditingController();
  final statusTec = TextEditingController();

  late DateTime date;


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
                SizedBox(height: 50),
                SfDateRangePicker(
                  view: DateRangePickerView.month,
                  showTodayButton: true,
                  onSelectionChanged: (args) {
                    date = args.value;
                  },
                ),
                ElevatedButton(
                    onPressed: () async {
                      final species = speciesTec.text;
                      final breed = breedTec.text;

                      if(species == '' || breed == '' || date == null) {
                        _sendErrorMessage('Missing fields');
                        return;
                      }

                      final location = await getPosition();

                      final url = await Images().uploadAdoptionPic(_photo!);

                      Collections().createAdoption(breed,date,location.toString(),species,url);

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
  void _sendErrorMessage(msg) {
    ScaffoldMessenger.of(context).showSnackBar(errorMessage(msg));
  }
}
