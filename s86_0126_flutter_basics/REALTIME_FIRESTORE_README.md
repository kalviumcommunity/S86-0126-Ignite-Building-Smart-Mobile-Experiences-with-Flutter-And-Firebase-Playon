# Real-Time Firestore Snapshot Listeners Demo

Project Title: PlayOn — Real-Time Sync with Firestore Snapshots

## What this demonstrates
- Real-time collection listeners using `FirebaseFirestore.instance.collection(...).snapshots()`
- StreamBuilder-driven UI that updates instantly when documents are added/updated/deleted
- Example: `TasksScreen` uses a `StreamBuilder<QuerySnapshot>` to render the user's tasks and reacts to writes performed in the app or via the Firebase Console.

## Snapshot listener explanation
Firestore's `.snapshots()` returns a Stream of query snapshot updates. Each time a document matching the query is added, changed, or removed, the stream emits a new `QuerySnapshot`. Using `StreamBuilder` you can rebuild widgets with the latest data without manual polling or refresh.

### Collection listener (example)
```dart
Stream<QuerySnapshot> taskStream = FirebaseFirestore.instance
  .collection('tasks')
  .where('uid', isEqualTo: userId)
  .orderBy('createdAt', descending: true)
  .snapshots();
```

### Document listener (example)
```dart
Stream<DocumentSnapshot> userDoc = FirebaseFirestore.instance
  .collection('users')
  .doc(userId)
  .snapshots();

// Then use a StreamBuilder to rebuild UI on changes.
```

### StreamBuilder usage (example)
```dart
StreamBuilder<QuerySnapshot>(
  stream: taskStream,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }
    if (snapshot.hasError) {
      return Center(child: Text('Error: \\${snapshot.error}'));
    }
    final docs = snapshot.data!.docs;
    if (docs.isEmpty) return const Center(child: Text('No tasks yet'));

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
)
```

## Files changed / used
- `lib/screens/tasks_screen.dart` — already implements a `StreamBuilder` listening to `getTasks()` from `FirestoreService`.
- `lib/services/firestore_service.dart` — helper methods for `tasks` collection that return streams and perform CRUD operations.

## How to run (web / Chrome)
1. Ensure Flutter and web tooling are installed and Chrome is available.
2. From the `s86_0126_flutter_basics` folder run:

```bash
flutter pub get
flutter run -d chrome
```

3. Log in to the app (do not change login/signup screens) and open the `Tasks` screen from the app menu or navigate to the `/tasks` route.
4. In the Firebase Console (Firestore), add/edit/delete documents in the `tasks` collection for the current user's `uid` and watch the app update instantly.

## Testing checklist & screenshots
- Add a task in the app → app list updates immediately.
- Edit a task in the Firebase Console → app updates instantly.
- Delete a task in the Console → task is removed from the app list.

(Placeholders) Add screenshots of Console changes and app UI here after verification.

## Reflection
- Real-time sync improves UX by removing manual refresh and keeps all clients consistent with server state.
- Using `.snapshots()` with `StreamBuilder` keeps the implementation concise and reactive.
- Challenges: ensuring correct security rules, handling offline behavior, and implementing permission checks server-side.

## PR / Commit info for submission
- Commit message: `feat: implemented real-time Firestore sync using snapshot listeners`
- PR title: `[Sprint-2] Real-Time Sync with Firestore Snapshots – TeamName`
- PR description should include explanation of snapshot listeners, code snippets (above), screenshots, and a short reflection.

## Video demo checklist
- Show app displaying `tasks` data
- Make a change in Firebase Console
- Show the app updating instantly
- Short explanation of how `.snapshots()` drives the UI

---
If you'd like, I can capture screenshots (if you run the app) and update this README with real images, and prepare the PR text and a short demo script for recording the video.