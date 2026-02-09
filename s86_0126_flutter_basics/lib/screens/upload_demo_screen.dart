import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:typed_data';

import '../services/storage_service.dart';

class UploadDemoScreen extends StatefulWidget {
  const UploadDemoScreen({super.key});

  @override
  State<UploadDemoScreen> createState() => _UploadDemoScreenState();
}

class _UploadDemoScreenState extends State<UploadDemoScreen> {
  final ImagePicker _picker = ImagePicker();
  final StorageService _storage = StorageService();

  XFile? _picked;
  String? _downloadUrl;
  bool _isUploading = false;

  Future<void> _pickAndUpload() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please log in first')));
      return;
    }

    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
    if (file == null) return;

    setState(() {
      _picked = file;
      _isUploading = true;
      _downloadUrl = null;
    });

    try {
      final url = await _storage.uploadImage(file, user.uid);
      setState(() {
        _downloadUrl = url;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Upload successful')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Upload failed: $e')));
    } finally {
      setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Demo — Firebase Storage')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: _isUploading ? null : _pickAndUpload,
              icon: const Icon(Icons.upload_file),
              label: Text(_isUploading ? 'Uploading...' : 'Pick & Upload Image'),
            ),
            const SizedBox(height: 12),

            if (_picked != null) ...[
              const Text('Selected preview:'),
              const SizedBox(height: 8),
              FutureBuilder(
                future: _picked!.readAsBytes(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) return const SizedBox(height:100, child: Center(child:CircularProgressIndicator()));
                  if (snapshot.hasError) return Text('Preview error: ${snapshot.error}');
                  return Image.memory(snapshot.data as Uint8List, height: 150);
                },
              ),
            ],

            const SizedBox(height: 12),

            if (_downloadUrl != null) ...[
              const Text('Uploaded image:'),
              const SizedBox(height: 8),
              Image.network(_downloadUrl!, height: 200),
              const SizedBox(height: 8),
              SelectableText(_downloadUrl!),
            ],
          ],
        ),
      ),
    );
  }
}
