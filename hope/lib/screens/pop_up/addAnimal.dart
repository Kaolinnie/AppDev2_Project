import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hope/classes/animal.dart';
import 'package:intl/intl.dart';

import '../../utils/color_utils.dart';
import '../../utils/datepicker.dart';
import '../../utils/functions.dart';
import '../../utils/location.dart';
import '../../widgets/widgets.dart';

class AddAnimal extends StatefulWidget {
  const AddAnimal({Key? key}) : super(key: key);

  @override
  State<AddAnimal> createState() => _AddAnimalState();
}

class _AddAnimalState extends State<AddAnimal> {
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

  void getDate() async {
    final results =(await pickDate(context))[0];
    setState(() {
      date = results;
    });
  }

  void _sendErrorMessage(msg) {
    ScaffoldMessenger.of(context).showSnackBar(errorMessage(msg,context));
  }

  final nameTec = TextEditingController();
  final breedTec = TextEditingController();
  final speciesTec = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? species;
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('List an adoption')
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _animalPic(),
              const Divider(indent: 50, endIndent: 50, thickness: 1),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    formField("Name", nameTec),
                    DropdownButtonFormField2(
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      items: Animal.speciesOptionsDropdown,
                      hint: const Text(
                        'Species',
                        style: TextStyle(fontSize: 14),
                      ),
                      isExpanded: true,
                      value: species,
                      onChanged: (e){
                        setState(() {
                          species = e.toString();
                          print(species);
                        });
                      },
                      validator: (value) => value != null ? null : "Please choose a species",
                      buttonStyleData: const ButtonStyleData(
                          height: 75,
                          elevation: 5,
                      ),
                      iconStyleData: const IconStyleData(
                          icon: Icon(Icons.arrow_drop_down),
                          openMenuIcon: Icon(Icons.arrow_drop_up)
                      ),
                    ),
                    formField("Breed", breedTec),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: getDate,
                            child: const Text('Date of Birth')
                        ),
                        Text(DateFormat('yyyy-MM-dd').format(date))
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            final location = await getPosition();
                            final url = await Images().uploadPic(_photo!,'animals');

                            Animal.insertAnimal(species,breedTec.text,nameTec.text,date,url);

                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Submit')
                    )
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}
