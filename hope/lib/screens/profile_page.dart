import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hope/authentication/auth.dart';
import 'package:hope/screens/pop_up/edit_profile.dart';
import 'package:hope/widgets/userWidgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }
  Future<void> editProfile() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()));
  }
  Widget _userUid() => Text(user?.email ?? 'User email');
  Widget _signOutButton() => IconButton(
    icon: const Icon(Icons.logout),
    onPressed: signOut,
  );

  Widget _userPhoto() => ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Image.network(
        user?.photoURL??'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png',
        height: 150,
        width: 150,
      ),
  );

  Widget _profile() => SizedBox(
    height: 300,
    width: double.infinity,
    child: Column(
      children: [
        _userPhoto(),
        const Divider(
          height: 20,
          thickness: 1,
          indent: 50,
          endIndent: 50,
        ),
        profileName(user?.displayName??'No name?')
      ],
    )
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _profile(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: editProfile,
              child: const Text('Edit profile')
            ),
            _signOutButton()
          ],
        ),
      ],
    );
  }
}