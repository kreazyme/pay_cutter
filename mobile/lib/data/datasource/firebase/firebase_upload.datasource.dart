import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FirebaseUploadDataSoure {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadImage(File file, String path) async {
    try {
      final ref = _firebaseStorage.ref().child(path);
      final uploadTask = ref.putFile(file);
      final String url = await (await uploadTask).ref.getDownloadURL();
      return url;
    } catch (_) {
      rethrow;
    }
  }
}
