import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Uploads an image picked via ImagePicker and returns the download URL.
  /// Also saves a metadata record in Firestore under `uploads` collection.
  Future<String> uploadImage(XFile file, String uid) async {
    final fileName = '${DateTime.now().millisecondsSinceEpoch}_${file.name}';
    final ref = _storage.ref().child('uploads/$uid/$fileName');

    final bytes = await file.readAsBytes();
    final ext = (file.name.contains('.')) ? file.name.split('.').last : 'jpg';
    final metadata = SettableMetadata(contentType: 'image/$ext');

    await ref.putData(bytes, metadata);
    final url = await ref.getDownloadURL();

    await _firestore.collection('uploads').add({
      'uid': uid,
      'url': url,
      'fileName': fileName,
      'createdAt': Timestamp.now(),
    });

    return url;
  }

  /// Deletes a file by its storage path reference
  Future<void> deleteByUrl(String url) async {
    final ref = _storage.refFromURL(url);
    await ref.delete();
  }
}
