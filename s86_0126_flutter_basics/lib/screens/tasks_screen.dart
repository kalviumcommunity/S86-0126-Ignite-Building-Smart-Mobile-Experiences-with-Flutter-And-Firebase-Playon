import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/firestore_service.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirestoreService _fs = FirestoreService();
  final user = FirebaseAuth.instance.currentUser;

  String? _editingDocId;

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _addOrUpdateTask() async {
    if (!_formKey.currentState!.validate()) return;

    final title = _titleController.text.trim();
    final desc = _descController.text.trim();

    try {
      if (user == null) throw 'Not authenticated';

      if (_editingDocId == null) {
        await _fs.addTask(user!.uid, title, desc);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task added')),
        );
      } else {
        await _fs.updateTask(_editingDocId!, {
          'title': title,
          'description': desc,
          'updatedAt': Timestamp.now(),
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task updated')),
        );
        setState(() {
          _editingDocId = null;
        });
      }

      _titleController.clear();
      _descController.clear();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  void _startEdit(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    _titleController.text = data['title'] ?? '';
    _descController.text = data['description'] ?? '';
    setState(() {
      _editingDocId = doc.id;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('Please login to manage tasks')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Tasks — Firestore Writes')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'Please enter a title'
                        : null,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _descController,
                    decoration: const InputDecoration(labelText: 'Description'),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'Please enter a description'
                        : null,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _addOrUpdateTask,
                          child: Text(_editingDocId == null ? 'Add Task' : 'Update Task'),
                        ),
                      ),
                      if (_editingDocId != null) ...[
                        const SizedBox(width: 8),
                        OutlinedButton(
                          onPressed: () {
                            _titleController.clear();
                            _descController.clear();
                            setState(() => _editingDocId = null);
                          },
                          child: const Text('Cancel'),
                        )
                      ]
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _fs.getTasks(user!.uid),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final docs = snapshot.data!.docs;
                  if (docs.isEmpty) {
                    return const Center(child: Text('No tasks yet'));
                  }

                  return ListView.separated(
                    itemCount: docs.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      final doc = docs[index];
                      final data = doc.data() as Map<String, dynamic>;
                      final completed = data['isCompleted'] ?? false;

                      return ListTile(
                        title: Text(data['title'] ?? ''),
                        subtitle: Text(data['description'] ?? ''),
                        leading: Checkbox(
                          value: completed,
                          onChanged: (v) async {
                            try {
                              await _fs.toggleTaskCompleted(doc.id, v ?? false);
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Error: $e')),
                              );
                            }
                          },
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _startEdit(doc),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () async {
                                try {
                                  await _fs.deleteTask(doc.id);
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Error: $e')),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
