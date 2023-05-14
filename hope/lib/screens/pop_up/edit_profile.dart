import 'package:flutter/material.dart';
import 'package:hope/utils/styles.dart';
import 'package:hope/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _firstNameTec = TextEditingController();
  final _lastNameTec = TextEditingController();
  final _displayNameTec = TextEditingController();
  final _phoneNumTec = TextEditingController();

  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile')
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                reusableText2("First name", _firstNameTec,textInputType: TextInputType.name),
                gap(),
                reusableText2("Last name", _lastNameTec,textInputType: TextInputType.name),
                gap(),
                reusableText2("Display name", _displayNameTec,textInputType: TextInputType.name),
                gap(),
                reusableText2("Phone number", _phoneNumTec,textInputType: TextInputType.phone,icon:Icons.phone),
              ],

          ),

        ),

      )
    );
  }
}