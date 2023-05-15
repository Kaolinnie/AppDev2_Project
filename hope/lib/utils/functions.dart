import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

enum ImageType {
  profilePic,
  petPic,
  postPic
}


class UploadImage {
  final _fb = FirebaseStorage.instance;

  UploadTask? _uploadTask;
  late XFile _image;

  Future selectFile(ImageType type) async {
    final result = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 75
    );
    _image = result!;

    String path = '';

    switch(type){
      case ImageType.profilePic:
        path = 'images/profiles/${_image.name}';
        break;
      case ImageType.petPic:
        path = 'images/pets/${_image.name}';
        break;
      case ImageType.postPic:
        path = 'images/posts/${_image.name}';
        break;
    }

    return _uploadFile(path);
  }

  Future _uploadFile(String path) async {
    final file = File(_image.path);

    final ref = _fb.ref().child(path);
    _uploadTask = ref.putFile(file);

    final snapshot = await _uploadTask!.whenComplete(() => {});

    final urlDownload = await snapshot.ref.getDownloadURL();

    return urlDownload;
  }
}


class Functions {
   static Future<String> pickUploadImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 75
    );

    String path = '';

    Reference ref = FirebaseStorage.instance.ref().child("profilepic.jpg");

    await ref.putFile(File(image!.path));
    ref.getDownloadURL().then((value) {
      path = value;
    });

    return path;
  }
}