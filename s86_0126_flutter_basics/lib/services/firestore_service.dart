import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('notes');

  Future<void> addNote(String uid, String text) {
    return notes.add({
      'uid': uid,
      'text': text,
      'createdAt': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getNotes(String uid) {
    return notes
        .where('uid', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> updateNote(String docId, String newText) {
    return notes.doc(docId).update({'text': newText});
  }

  Future<void> deleteNote(String docId) {
    return notes.doc(docId).delete();
  }
}
