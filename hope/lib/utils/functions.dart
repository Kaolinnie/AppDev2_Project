import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

enum ImageType {
  profilePic,
  petPic,
  postPic
}


class UploadImage {
  final _fb = FirebaseStorage.instance;
  final _currentUser = FirebaseAuth.instance.currentUser;

  UploadTask? _uploadTask;
  late XFile _image;

  Future uploadProfilePic() async {
    final result = await ImagePicker().pickImage(
        source: ImageSource.gallery
    );
    _image = result!;

    final file = File(_image.path);
    final dir = dirname(file.path);
    final ext = extension(file.path);
    final newFile = await file.rename("$dir/profile_pic$ext");
    final finalPath = "/users/${_currentUser?.uid}/${basename(newFile.path)}";

    final ref = _fb.ref().child(finalPath);
    _uploadTask = ref.putFile(newFile);

    final snapshot = await _uploadTask!.whenComplete(() => {});

    final urlDownload = await snapshot.ref.getDownloadURL();

    return urlDownload;
  }
}
