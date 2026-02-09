import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFunctionsDemoScreen extends StatefulWidget {
  const CloudFunctionsDemoScreen({Key? key}) : super(key: key);

  @override
  State<CloudFunctionsDemoScreen> createState() =>
      _CloudFunctionsDemoScreenState();
}

class _CloudFunctionsDemoScreenState extends State<CloudFunctionsDemoScreen> {
  final FirebaseFunctions _functions = FirebaseFunctions.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _responseMessage = "No response yet";
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cloud Functions Demo"),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildCallableFunctionsSection(),
            const SizedBox(height: 24),
            _buildEventTriggersSection(),
            const SizedBox(height: 24),
            _buildResponseSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        border: Border.all(color: Colors.deepPurple, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "🏆 Sports Tournament Cloud Functions",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Test callable functions and event-based triggers from your Flutter app",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildCallableFunctionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "📞 Callable Functions",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        const SizedBox(height: 12),
        _buildFunctionButton(
          "Greet User (sayHello)",
          () => _callSayHello(),
          Colors.blue,
        ),
        const SizedBox(height: 8),
        _buildFunctionButton(
          "Calculate Tournament Points",
          () => _callCalculatePoints(),
          Colors.green,
        ),
      ],
    );
  }

  Widget _buildEventTriggersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "🔥 Event-Based Functions (Firestore Triggers)",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        const SizedBox(height: 12),
        _buildFunctionButton(
          "Create New Match (Triggers onNewMatchCreated)",
          () => _createNewMatch(),
          Colors.orange,
        ),
        const SizedBox(height: 8),
        _buildFunctionButton(
          "Submit Tournament Result (Triggers onTournamentResultSubmitted)",
          () => _submitTournamentResult(),
          Colors.red,
        ),
      ],
    );
  }

  Widget _buildResponseSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "📊 Response / Logs",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(4),
            ),
            child: SelectableText(
              _responseMessage,
              style: const TextStyle(
                fontFamily: 'Courier',
                fontSize: 11,
              ),
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                _responseMessage = "No response yet";
              });
            },
            icon: const Icon(Icons.clear),
            label: const Text("Clear"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFunctionButton(String label, VoidCallback onPressed, Color color) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        child: _isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                label,
                style: const TextStyle(color: Colors.white),
              ),
      ),
    );
  }

  Future<void> _callSayHello() async {
    setState(() => _isLoading = true);
    try {
      final callable = _functions.httpsCallable('sayHello');
      final result = await callable.call({
        'name': 'Alex',
        'score': 150,
      });
      setState(() {
        _responseMessage =
            "✅ sayHello() Response:\n\n${result.data.toString()}";
      });
      print("sayHello Response: ${result.data}");
    } on FirebaseFunctionsException catch (e) {
      setState(() {
        _responseMessage = "❌ Error: ${e.code}\n${e.message}";
      });
      print("Error: ${e.code} - ${e.message}");
    } catch (e) {
      setState(() {
        _responseMessage = "❌ Unexpected error: $e";
      });
      print("Unexpected error: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _callCalculatePoints() async {
    setState(() => _isLoading = true);
    try {
      final callable = _functions.httpsCallable('calculatePoints');
      final result = await callable.call({
        'wins': 5,
        'draws': 2,
        'losses': 1,
      });
      setState(() {
        _responseMessage =
            "✅ calculatePoints() Response:\n\n${result.data.toString()}";
      });
      print("calculatePoints Response: ${result.data}");
    } on FirebaseFunctionsException catch (e) {
      setState(() {
        _responseMessage = "❌ Error: ${e.code}\n${e.message}";
      });
      print("Error: ${e.code} - ${e.message}");
    } catch (e) {
      setState(() {
        _responseMessage = "❌ Unexpected error: $e";
      });
      print("Unexpected error: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _createNewMatch() async {
    setState(() => _isLoading = true);
    try {
      final matchData = {
        'team1': 'Team Dragons',
        'team2': 'Team Tigers',
        'schedule': DateTime.now().add(const Duration(days: 1)).toIso8601String(),
        'location': 'Central Sports Arena',
        'sport': 'Football',
      };

      await _firestore.collection('matches').add(matchData);

      setState(() {
        _responseMessage =
            "✅ New match created! Check Firebase Console for onNewMatchCreated logs.\n\nMatch data:\n${matchData.toString()}";
      });
      print("Match created: $matchData");
    } catch (e) {
      setState(() {
        _responseMessage = "❌ Error creating match: $e";
      });
      print("Error: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _submitTournamentResult() async {
    setState(() => _isLoading = true);
    try {
      final resultData = {
        'teamName': 'Team Dragons',
        'score': 85,
        'wins': 3,
        'draws': 1,
        'losses': 0,
        'tournament': 'Spring Championship',
        'submittedBy': 'demo_user',
      };

      await _firestore.collection('tournamentResults').add(resultData);

      setState(() {
        _responseMessage =
            "✅ Tournament result submitted! Check Firebase Console for onTournamentResultSubmitted logs.\n\nResult data:\n${resultData.toString()}";
      });
      print("Result submitted: $resultData");
    } catch (e) {
      setState(() {
        _responseMessage = "❌ Error submitting result: $e";
      });
      print("Error: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
