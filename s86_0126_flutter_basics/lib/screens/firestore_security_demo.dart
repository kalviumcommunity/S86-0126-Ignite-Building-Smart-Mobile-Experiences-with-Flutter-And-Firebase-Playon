import 'package:flutter/material.dart';
import '../services/firestore_security_service.dart';

class FirestoreSecurityDemoScreen extends StatefulWidget {
  const FirestoreSecurityDemoScreen({Key? key}) : super(key: key);

  @override
  State<FirestoreSecurityDemoScreen> createState() =>
      _FirestoreSecurityDemoScreenState();
}

class _FirestoreSecurityDemoScreenState
    extends State<FirestoreSecurityDemoScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _teamController = TextEditingController();
  final TextEditingController _scoreController = TextEditingController();
  final TextEditingController _winsController = TextEditingController();

  String _userInfo = "Loading user info...";
  String _profileData = "No profile data yet";
  List<Map<String, dynamic>> _tournamentResults = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  void _loadUserInfo() {
    final uid = FirestoreSecurityService.getCurrentUserId();
    final email = FirestoreSecurityService.getCurrentUserEmail();

    setState(() {
      _userInfo = uid != null
          ? "UID: $uid\nEmail: $email"
          : "No authenticated user";
    });
  }

  void _updateUserProfile() async {
    if (_nameController.text.isEmpty ||
        _bioController.text.isEmpty ||
        _roleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await FirestoreSecurityService.updateUserProfile(
        name: _nameController.text,
        bio: _bioController.text,
        role: _roleController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("✅ Profile updated successfully"),
          backgroundColor: Colors.green,
        ),
      );

      _loadUserProfile();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("❌ Error: $e"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _loadUserProfile() async {
    setState(() => _isLoading = true);

    try {
      final profile =
          await FirestoreSecurityService.getUserProfile();

      setState(() {
        _profileData = profile != null
            ? "Name: ${profile['name']}\nBio: ${profile['bio']}\nRole: ${profile['role']}\nEmail: ${profile['email']}"
            : "No profile data found";
      });
    } catch (e) {
      setState(() {
        _profileData = "Error loading profile: $e";
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _addTournamentResult() async {
    if (_teamController.text.isEmpty ||
        _scoreController.text.isEmpty ||
        _winsController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await FirestoreSecurityService.addTournamentResult(
        teamName: _teamController.text,
        score: int.parse(_scoreController.text),
        wins: int.parse(_winsController.text),
        draws: int.parse(_winsController.text) ~/ 2,
        losses: int.parse(_winsController.text) ~/ 3,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("✅ Tournament result added"),
          backgroundColor: Colors.green,
        ),
      );

      _teamController.clear();
      _scoreController.clear();
      _winsController.clear();

      _loadTournamentResults();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("❌ Error: $e"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _loadTournamentResults() async {
    setState(() => _isLoading = true);

    try {
      final results =
          await FirestoreSecurityService.getTournamentResults();

      setState(() {
        _tournamentResults = results;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error loading results: $e"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firestore Security Rules"),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildUserInfoSection(),
            const SizedBox(height: 24),
            _buildProfileSection(),
            const SizedBox(height: 24),
            _buildTournamentResultsSection(),
            const SizedBox(height: 24),
            _buildSecurityRulesSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        border: Border.all(color: Colors.teal, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "🔒 Firestore Security & Authentication",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Secure database access with authentication and custom Firestore rules",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfoSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        border: Border.all(color: Colors.blue, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.account_circle, color: Colors.blue.shade600),
              const SizedBox(width: 8),
              const Text(
                "Authenticated User",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.blue.shade200),
              borderRadius: BorderRadius.circular(4),
            ),
            child: SelectableText(
              _userInfo,
              style: TextStyle(fontSize: 11, color: Colors.blue.shade900),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.purple.shade50,
        border: Border.all(color: Colors.purple, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person, color: Colors.purple.shade600),
              const SizedBox(width: 8),
              const Text(
                "User Profile (Auth-Protected)",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: "Name",
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _bioController,
            decoration: InputDecoration(
              labelText: "Bio",
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _roleController,
            decoration: InputDecoration(
              labelText: "Role (e.g., player, coach, spectator)",
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _updateUserProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.shade600,
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text("Save Profile"),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _isLoading ? null : _loadUserProfile,
              icon: const Icon(Icons.cloud_download),
              label: const Text("Load Profile from Firestore"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.shade400,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.purple.shade200),
              borderRadius: BorderRadius.circular(4),
            ),
            child: SelectableText(
              _profileData,
              style: TextStyle(fontSize: 11, color: Colors.purple.shade900),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTournamentResultsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        border: Border.all(color: Colors.amber, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.sports_score, color: Colors.amber.shade600),
              const SizedBox(width: 8),
              const Text(
                "Tournament Results (Sub-Collection)",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _teamController,
            decoration: InputDecoration(
              labelText: "Team Name",
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _scoreController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Score",
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _winsController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Wins",
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _addTournamentResult,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber.shade600,
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text("Add Result"),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _isLoading ? null : _loadTournamentResults,
              icon: const Icon(Icons.refresh),
              label: const Text("Load My Results"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber.shade400,
              ),
            ),
          ),
          const SizedBox(height: 12),
          if (_tournamentResults.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "My Results (${_tournamentResults.length})",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ..._tournamentResults.map((result) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.amber.shade200),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      "Team: ${result['teamName']}\nScore: ${result['score']}\nWins: ${result['wins']}",
                      style: const TextStyle(fontSize: 10),
                    ),
                  );
                }).toList(),
              ],
            )
          else if (!_isLoading)
            Text(
              "No results yet. Add one above!",
              style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
            ),
        ],
      ),
    );
  }

  Widget _buildSecurityRulesSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        border: Border.all(color: Colors.green, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.security, color: Colors.green.shade600),
              const SizedBox(width: 8),
              const Text(
                "Firestore Security Rules Applied",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "Rules Protecting This Data:\n\n"
            "✅ Only authenticated users can read/write\n"
            "✅ Users can only access their own /users/{uid} document\n"
            "✅ Users can only access their own tournament results\n"
            "✅ Automatic server timestamps prevent tampering\n"
            "✅ createdBy field ensures data ownership\n\n"
            "Firestore Rules:\n"
            "service cloud.firestore {\n"
            "  match /databases/{database}/documents {\n"
            "    match /users/{uid} {\n"
            "      allow read, write: if request.auth.uid == uid;\n"
            "      match /tournamentResults/{resultId} {\n"
            "        allow read, write: if request.auth.uid == uid;\n"
            "      }\n"
            "    }\n"
            "  }\n"
            "}",
            style: TextStyle(
              fontSize: 10,
              fontFamily: 'Courier',
              color: Colors.green.shade900,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _roleController.dispose();
    _teamController.dispose();
    _scoreController.dispose();
    _winsController.dispose();
    super.dispose();
  }
}
