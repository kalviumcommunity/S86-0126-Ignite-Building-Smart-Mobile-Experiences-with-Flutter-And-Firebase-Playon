import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/firestore_service.dart';

class ItemsScreen extends StatefulWidget {
  const ItemsScreen({super.key});

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirestoreService _fs = FirestoreService();
  final User? _user = FirebaseAuth.instance.currentUser;

  String? _editingId;

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _createOrUpdate() async {
    if (!_formKey.currentState!.validate()) return;
    if (_user == null) return;

    final title = _titleController.text.trim();
    final desc = _descController.text.trim();

    try {
      if (_editingId == null) {
        await _fs.createUserItem(_user!.uid, title, desc);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Item created')));
      } else {
        await _fs.updateUserItem(_user!.uid, _editingId!, {
          'title': title,
          'description': desc,
          'updatedAt': Timestamp.now(),
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Item updated')));
        setState(() => _editingId = null);
      }

      _titleController.clear();
      _descController.clear();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  void _startEdit(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    _titleController.text = data['title'] ?? '';
    _descController.text = data['description'] ?? '';
    setState(() => _editingId = doc.id);
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return const Scaffold(body: Center(child: Text('Please login to manage items')));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('My Items — CRUD')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (_) => Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildForm()
            ),
          ),
        ),
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // inline form
            _buildForm(),
            const SizedBox(height: 12),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _fs.streamUserItems(_user!.uid),
                builder: (context, snapshot) {
                  if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));
                  if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());

                  final docs = snapshot.data!.docs;
                  if (docs.isEmpty) return const Center(child: Text('No items yet'));

                  return ListView.separated(
                    itemCount: docs.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      final doc = docs[index];
                      final data = doc.data() as Map<String, dynamic>;
                      return ListTile(
                        title: Text(data['title'] ?? ''),
                        subtitle: Text(data['description'] ?? ''),
                        onTap: () => _startEdit(doc),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            try {
                              await _fs.deleteUserItem(_user!.uid, doc.id);
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                            }
                          },
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

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
            validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter a title' : null,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _descController,
            decoration: const InputDecoration(labelText: 'Description'),
            validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter a description' : null,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _createOrUpdate,
                  child: Text(_editingId == null ? 'Create' : 'Update'),
                ),
              ),
              if (_editingId != null) ...[
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: () {
                    _titleController.clear();
                    _descController.clear();
                    setState(() => _editingId = null);
                  },
                  child: const Text('Cancel'),
                )
              ]
            ],
          )
        ],
      ),
    );
  }
}
