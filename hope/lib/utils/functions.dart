import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

enum ImageType {
  profilePic,
  petPic,
  postPic
}


class Images {
  final _fb = FirebaseStorage.instance;
  final _currentUser = FirebaseAuth.instance.currentUser;

  UploadTask? _uploadTask;
  late XFile _image;

  Future<File> pickImage() async {
    final result = await ImagePicker().pickImage(
        source: ImageSource.gallery
    );
    return File(result!.path);
  }

  Future uploadAdoptionPic(File photo) async {
    final ext = extension(photo.path);
    final datetime = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd_kk:mm').format(datetime);
    final newFile = await _changeFileNameOnly(photo, "$formattedDate$ext");
    final finalPath = "/adoptions/${_currentUser?.uid}/${basename(newFile.path)}";
    final ref = _fb.ref().child(finalPath);
    _uploadTask = ref.putFile(newFile);
    final snapshot = await _uploadTask!.whenComplete(() => {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    return urlDownload;
  }

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

  Future<File> file(String filename) async {
    Directory dir = await getApplicationDocumentsDirectory();
    String pathName = join(dir.path, filename);
    return File(pathName);
  }

  Future<File> _changeFileNameOnly(File file, String newFileName) {
    var path = file.path;
    var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
    var newPath = path.substring(0, lastSeparator + 1) + newFileName;
    return file.rename(newPath);
  }
}
