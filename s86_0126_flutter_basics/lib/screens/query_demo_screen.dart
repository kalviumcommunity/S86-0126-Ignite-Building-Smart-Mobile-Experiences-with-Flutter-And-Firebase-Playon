import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/firestore_service.dart';

class QueryDemoScreen extends StatefulWidget {
  const QueryDemoScreen({super.key});

  @override
  State<QueryDemoScreen> createState() => _QueryDemoScreenState();
}

class _QueryDemoScreenState extends State<QueryDemoScreen> {
  final FirestoreService _fs = FirestoreService();
  final _titleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('Please login to view query demo')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Firestore Queries Demo')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const Text(
              'Demonstrates `.where`, `.orderBy`, `.limit`, and range queries',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            // Search by title prefix
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Search title prefix',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => setState(() {}),
                  child: const Text('Search'),
                )
              ],
            ),

            const SizedBox(height: 12),

            Expanded(
              child: ListView(
                children: [
                  // Active tasks (where + orderBy)
                  const Text('Active tasks (isCompleted == false)'),
                  SizedBox(
                    height: 200,
                    child: StreamBuilder(
                      stream: _fs.getActiveTasks(user.uid),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        }
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        final docs = snapshot.data!.docs;
                        if (docs.isEmpty) return const Center(child: Text('No active tasks'));
                        return ListView.separated(
                          itemCount: docs.length,
                          separatorBuilder: (_, __) => const Divider(),
                          itemBuilder: (context, index) {
                            final data = docs[index].data() as Map<String, dynamic>;
                            return ListTile(
                              title: Text(data['title'] ?? ''),
                              subtitle: Text(data['description'] ?? ''),
                            );
                          },
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Recent tasks (orderBy + limit)
                  const Text('Recent tasks (limit 5)'),
                  SizedBox(
                    height: 200,
                    child: StreamBuilder(
                      stream: _fs.getRecentTasks(user.uid, 5),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        }
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        final docs = snapshot.data!.docs;
                        if (docs.isEmpty) return const Center(child: Text('No recent tasks'));
                        return ListView.builder(
                          itemCount: docs.length,
                          itemBuilder: (context, index) {
                            final data = docs[index].data() as Map<String, dynamic>;
                            return ListTile(
                              title: Text(data['title'] ?? ''),
                              subtitle: Text(data['description'] ?? ''),
                            );
                          },
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Title prefix search (startAt / endAt)
                  const Text('Title prefix search'),
                  SizedBox(
                    height: 200,
                    child: StreamBuilder(
                      stream: _titleController.text.trim().isEmpty
                          ? _fs.getRecentTasks(user.uid, 10)
                          : _fs.getTasksByTitlePrefix(user.uid, _titleController.text.trim()),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        }
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        final docs = snapshot.data!.docs;
                        if (docs.isEmpty) return const Center(child: Text('No matches'));
                        return ListView.builder(
                          itemCount: docs.length,
                          itemBuilder: (context, index) {
                            final data = docs[index].data() as Map<String, dynamic>;
                            return ListTile(
                              title: Text(data['title'] ?? ''),
                              subtitle: Text(data['description'] ?? ''),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
