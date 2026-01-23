import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firestore_service.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    final FirestoreService firestoreService = FirestoreService();
    final AuthService authService = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authService.logout();
              if (context.mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              }
            },
          )
        ],
      ),

      // 🔥 THIS IS WHERE YOUR StreamBuilder GOES
      body: StreamBuilder(
        stream: firestoreService.getNotes(uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No notes yet"));
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(docs[index]['text']),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    firestoreService.deleteNote(docs[index].id);
                  },
                ),
              );
            },
          );
        },
      ),

      // Button to ADD data
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          firestoreService.addNote(uid, "New Note at ${DateTime.now()}");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
