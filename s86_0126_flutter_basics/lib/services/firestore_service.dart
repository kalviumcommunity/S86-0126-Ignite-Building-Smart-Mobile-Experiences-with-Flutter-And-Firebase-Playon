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

  // --- Tasks collection helpers ---
  final CollectionReference tasks =
      FirebaseFirestore.instance.collection('tasks');

  Future<void> addTask(String uid, String title, String description) async {
    await tasks.add({
      'uid': uid,
      'title': title,
      'description': description,
      'isCompleted': false,
      'createdAt': Timestamp.now(),
    });
    return;
  }

  Stream<QuerySnapshot> getTasks(String uid) {
    return tasks
        .where('uid', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> updateTask(String docId, Map<String, dynamic> data) {
    return tasks.doc(docId).set(data, SetOptions(merge: true));
  }

  Future<void> toggleTaskCompleted(String docId, bool value) {
    return tasks.doc(docId).update({'isCompleted': value});
  }

  Future<void> deleteTask(String docId) {
    return tasks.doc(docId).delete();
  }
}
