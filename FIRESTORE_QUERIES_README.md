# Firestore Queries & Filtering Demo

Project: PlayOn — Firestore Queries & Filtering

## Purpose
This document demonstrates Firestore queries implemented in the project: filters (`where`), sorting (`orderBy`), and limiting results (`limit`). It also includes a title-prefix search using `startAt` / `endAt`.

## Implemented Query Types
- Equality filter: `.where('isCompleted', isEqualTo: false)` — Active tasks
- Ordering: `.orderBy('createdAt', descending: true)` — Sort by creation time
- Limit: `.limit(5)` — Fetch most recent 5 tasks
- Range / prefix search: `.orderBy('title').startAt([prefix]).endAt([prefix + '\\uf8ff'])`

## Files touched
- `s86_0126_flutter_basics/lib/services/firestore_service.dart` — Added `getActiveTasks`, `getRecentTasks`, `getTasksByTitlePrefix` helpers.
- `s86_0126_flutter_basics/lib/screens/query_demo_screen.dart` — New UI demonstrating queries with `StreamBuilder`.
- `s86_0126_flutter_basics/lib/main.dart` — Registered `/queries` route for the demo screen.

## Code snippets
Collection query with filter, order, and limit:

```dart
FirebaseFirestore.instance
  .collection('tasks')
  .where('uid', isEqualTo: userId)
  .where('isCompleted', isEqualTo: false)
  .orderBy('createdAt', descending: true)
  .limit(10)
  .snapshots();
```

Title prefix search (range query):

```dart
final end = '$prefix\\uf8ff';
FirebaseFirestore.instance
  .collection('tasks')
  .where('uid', isEqualTo: userId)
  .orderBy('title')
  .startAt([prefix])
  .endAt([end])
  .snapshots();
```

StreamBuilder example (short):

```dart
StreamBuilder<QuerySnapshot>(
  stream: firestoreService.getActiveTasks(userId),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    }
    final docs = snapshot.data!.docs;
    return ListView.builder(
      itemCount: docs.length,
      itemBuilder: (ctx, i) {
        final data = docs[i].data() as Map<String, dynamic>;
        return ListTile(title: Text(data['title']));
      },
    );
  },
)
```

## How to run
From the repository root run:

```bash
cd s86_0126_flutter_basics
flutter pub get
flutter run -d chrome
```

Then log in and open the `/queries` route or navigate to the Query Demo screen from the app to see the filtered/sorted lists.

## Testing
1. Add tasks with different `createdAt` timestamps and `isCompleted` values.
2. Observe the "Active tasks" list (where `isCompleted == false`) updates in real time.
3. The "Recent tasks" list shows the most recent 5 tasks (limit + orderBy).
4. Use the title prefix search input to try searching by starting letters of a title. The UI will show matching documents.

## Reflection
- Querying only the data you need reduces bandwidth and speeds up the UI.
- Combining `where` and `orderBy` may require composite indexes in Firestore; the console will prompt when needed.
- Using timestamps (`createdAt`) is effective for sorting time-based lists.

## PR / Commit info
- Commit: `feat: implemented Firestore queries, filters, and ordering in UI`
- PR title: `[Sprint-2] Firestore Queries & Filtering – TeamName`

Include screenshots of the Firestore Console and app UI after verification.

---
If you want, I can open a PR draft and prepare the PR description and demo script next.
