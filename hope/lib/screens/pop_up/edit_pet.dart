import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hope/utils/styles.dart';
import 'package:hope/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';

class EditAnimal extends StatefulWidget {
  const EditAnimal({Key? key}) : super(key: key);

  @override
  State<EditAnimal> createState() => _EditAnimal();
}

class _EditAnimal extends State<EditAnimal> {
  final _firstNameTec = TextEditingController();
  final _lastNameTec = TextEditingController();
  final _displayNameTec = TextEditingController();
  final _phoneNumTec = TextEditingController();

  final _picker = ImagePicker();

  Future<void> updateProfile() async {
    String displayName = _displayNameTec.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Edit Profile')
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                reusableText2("Display name", _displayNameTec,
                    textInputType: TextInputType.name),
                gap(),
                reusableText2("Phone number", _phoneNumTec,
                    textInputType: TextInputType.phone, icon: Icons.phone),
                gap(),
                ElevatedButton(
                    onPressed: updateProfile,
                    child: const Text('Update')
                ),
              ],

            ),

          ),

        )
    );
  }
}
