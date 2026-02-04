# 🏆 Community Sports Tournament Management System
## Scrollable Views with ListView & GridView Implementation

This project demonstrates **scalable Flutter UI patterns** for displaying dynamic tournament data, live scores, and player statistics using **ListView** and **GridView** widgets.

---

## 📋 Project Overview

**Problem Statement:** Community sports tournaments struggle to provide live score updates and player stats, limiting engagement for spectators and participants.

**Solution:** A responsive Flutter application that showcases:
- ✅ Real-time live score updates with horizontal scrolling
- ✅ Tournament listings with detailed information
- ✅ Top player statistics in an adaptive grid layout
- ✅ Smooth scrolling performance optimized for mobile and tablet devices

---

## 🎯 Key Features Implemented

### 1. **Live Scores Section (Horizontal ListView)**
```dart
ListView.builder(
  scrollDirection: Axis.horizontal,
  itemCount: liveScores.length,
  itemBuilder: (context, index) {
    // Displays match cards with team names, scores, and status
    // Status: LIVE (red), COMPLETED (green), UPCOMING (orange)
  },
);
```

**Benefits:**
- Horizontal scrolling for quick browsing of ongoing matches
- Efficient rendering using `ListView.builder`
- Real-time status indicators (Live/Completed/Upcoming)

---

### 2. **Tournament List Section (Vertical ListView with Separators)**
```dart
ListView.separated(
  itemCount: tournaments.length,
  separatorBuilder: (context, index) => Divider(),
  itemBuilder: (context, index) {
    // Displays tournament name, dates, participants, and status
    // Uses ListTile for consistent Material Design
  },
);
```

**Benefits:**
- Vertical scrolling for browsing all tournaments
- Clear visual separation with dividers
- Uses `ListView.separated` for better readability
- Status badges for quick identification

---

### 3. **Player Statistics Grid (GridView.builder)**
```dart
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: isTablet ? 3 : 2,
    crossAxisSpacing: 12,
    mainAxisSpacing: 12,
    childAspectRatio: 0.85,
  ),
  itemCount: playerStats.length,
  itemBuilder: (context, index) {
    // Displays player card with stats: Points, Games, Assists
    // Adaptive grid: 2 columns on mobile, 3 columns on tablet
  },
);
```

**Benefits:**
- Responsive grid that adapts to screen size
- Beautiful card design with gradient backgrounds
- Player ranking displayed prominently
- Efficient memory usage with `GridView.builder`

---

## 📊 Data Models

### Live Score Structure
```dart
{
  'team1': 'Team A',
  'team2': 'Team B',
  'score1': 72,
  'score2': 68,
  'time': '3rd Quarter',
  'status': 'LIVE',
}
```

### Tournament Structure
```dart
{
  'name': 'Basketball Championship 2024',
  'date': 'Jan 28 - Feb 15',
  'participants': 16,
  'status': 'Live',
}
```

### Player Statistics Structure
```dart
{
  'name': 'Player 1',
  'team': 'Team A',
  'points': 234,
  'games': 15,
  'assists': 45,
}
```

---

## 🔄 Responsive Design Pattern

The application uses **MediaQuery** and **LayoutBuilder** to adapt layouts:

```dart
final screenWidth = MediaQuery.of(context).size.width;
final isTablet = screenWidth > 600;

// Grid adapts based on device type
int columns = isTablet ? 3 : 2;
```

**Breakpoints:**
- **Mobile:** < 600px (2 columns for grid)
- **Tablet:** ≥ 600px (3-4 columns for grid)

---

## 🎨 UI Components

### Color Scheme
- **Primary:** Deep Orange (#FF6F00) - Tournament branding
- **Secondary:** Teal (#00897B) - Player stats
- **Status Colors:**
  - 🔴 Live: Red
  - ✅ Completed: Green
  - ⏳ Upcoming: Orange/Blue

### Typography
- **Headings:** 20px, Bold
- **Card Titles:** 14px, Bold
- **Subtitles:** 12-13px, Regular
- **Stats:** 18px, Bold (highlighted)

---

## ⚡ Performance Optimizations

### 1. **ListView.builder**
- Only renders visible items in the viewport
- Memory efficient for large datasets
- Improved scroll performance

### 2. **GridView.builder**
- Lazy loading of grid items
- Optimal performance with 50+ items
- Automatic height calculation with `childAspectRatio`

### 3. **SingleChildScrollView**
- Wraps entire content for vertical scrolling
- Prevents multiple nested scrollable widgets
- Smooth scroll experience

### 4. **NeverScrollableScrollPhysics**
- Nested GridView uses `NeverScrollableScrollPhysics()`
- Prevents scroll conflicts
- Parent SingleChildScrollView handles scrolling

---

## 📱 Testing & Screenshots

### Mobile View (Portrait)
- Single column layout with vertical scrolling
- Horizontal scroll for live scores
- 2-column grid for player stats
- All content fits comfortably with proper spacing

### Tablet View (Landscape)
- 3-column grid layout for player statistics
- Larger cards and better readability
- Increased padding for better use of screen space
- Horizontal scroll still available for live scores

---

## 🚀 How to Use

### Running the App
```bash
# Navigate to project directory
cd s86_0126_flutter_basics

# Get dependencies
flutter pub get

# Run on Chrome (Web)
flutter run -d chrome

# Run on specific device
flutter run -d <device_id>
```

### Navigating to Scrollable Views
1. Login to the application
2. Navigate to the Dashboard
3. Tap on **"Scrollable Views - Tournament Tracker"** card
4. Explore the different scrolling patterns:
   - Scroll horizontally for live scores
   - Scroll vertically for tournaments
   - Scroll vertically for player statistics

---

## 📚 Widget Breakdown

| Widget | Purpose | Key Features |
|--------|---------|--------------|
| `ListView.builder` | Horizontal live scores | Efficient rendering, horizontal scroll |
| `ListView.separated` | Tournament list | Visual separation with dividers |
| `GridView.builder` | Player statistics | Responsive columns, lazy loading |
| `Container` | Card styling | Gradient, shadow, border radius |
| `ListTile` | Tournament items | Leading icon, title, subtitle, trailing |
| `CircleAvatar` | Player ranking | Numbered display, colored background |

---

## 💡 Key Learnings

### Why Use Builder Constructors?
- **Memory Efficiency:** Only renders visible items
- **Performance:** Smooth scrolling with large datasets
- **Scalability:** Can handle 100+ items without lag
- **Better User Experience:** Instant app response

### ListView vs GridView
| Feature | ListView | GridView |
|---------|----------|----------|
| **Direction** | Horizontal/Vertical | Grid (2D) |
| **Use Case** | Lists, feeds, menus | Galleries, dashboards, catalogs |
| **Arrangement** | Single row/column | Multiple rows & columns |
| **Builder Type** | `ListView.builder` | `GridView.builder` |

### Common Performance Pitfalls Avoided
❌ **NOT DONE:**
- Creating all widgets at once without builder
- Using `itemCount` without proper `itemBuilder`
- Multiple nested scrollable widgets without physics
- Heavy computations in `itemBuilder`

✅ **IMPLEMENTED:**
- Builder pattern for lazy rendering
- Proper use of `physics: NeverScrollableScrollPhysics()`
- Efficient data structures (Lists)
- Lightweight widget building

---

## 🎯 Assignment Completion Checklist

- ✅ Created `scrollable_views.dart` with ListView and GridView
- ✅ Implemented horizontal ListView for live scores
- ✅ Implemented vertical ListView with separators for tournaments
- ✅ Implemented GridView.builder for player statistics
- ✅ Made layout responsive (Mobile 2-col, Tablet 3-col)
- ✅ Added navigation from home screen
- ✅ Tested on Chrome (web)
- ✅ No errors in compilation
- ✅ Smooth scrolling performance
- ✅ Proper spacing and alignment
- ✅ Color-coded status indicators
- ✅ Real-time data display simulation

---

## 📹 Demo Video

Duration: 1-2 minutes showcasing:
1. **Live Scores:** Horizontal scrolling through active matches
2. **Tournaments:** Vertical scrolling through tournament list
3. **Player Stats:** Grid layout with responsive columns
4. **Responsive Behavior:** Switching between mobile/tablet views
5. **Smooth Performance:** No lag or jank during scrolling

---

## 🔗 Resources Used

- [Flutter ListView Documentation](https://api.flutter.dev/flutter/widgets/ListView-class.html)
- [ListView.builder Guide](https://api.flutter.dev/flutter/widgets/ListView/ListView.builder.html)
- [Flutter GridView Documentation](https://api.flutter.dev/flutter/widgets/GridView-class.html)
- [GridView.builder Implementation](https://api.flutter.dev/flutter/widgets/GridView/GridView.builder.html)
- [SliverGridDelegateWithFixedCrossAxisCount](https://api.flutter.dev/flutter/widgets/SliverGridDelegateWithFixedCrossAxisCount-class.html)
- [MediaQuery for Responsive Design](https://api.flutter.dev/flutter/widgets/MediaQuery-class.html)

---

## 📝 Reflection

### How do ListView and GridView improve UI efficiency?

**ListView** improves efficiency through:
- **Virtual scrolling:** Only renders items in the viewport
- **Memory optimization:** Reuses widget instances as user scrolls
- **Performance:** Maintains 60 FPS even with hundreds of items
- **Simplicity:** Easy to implement and maintain

**GridView** improves efficiency through:
- **Adaptive layouts:** Automatically arranges items in columns
- **Responsive design:** Adjusts to different screen sizes
- **Better space utilization:** More information visible at once
- **Touch-friendly:** Larger tap targets compared to ListView

### Why is using builder constructors recommended?

Builder constructors (`ListView.builder`, `GridView.builder`) are recommended because:
1. **Lazy Loading:** Items are built only when they come into view
2. **Memory Conservation:** No need to build widgets for off-screen items
3. **Scalability:** Can handle thousands of items without performance degradation
4. **Battery Efficiency:** Reduced CPU usage = longer battery life
5. **Professionalism:** Industry standard for production apps

### Common performance pitfalls avoided:

❌ Creating all 1000 widgets upfront
✅ Using `.builder` to create widgets on-demand

❌ Heavy computations inside `itemBuilder`
✅ Pre-computing data and storing it in Lists

❌ Multiple nested `SingleChildScrollView` widgets
✅ Using `physics: NeverScrollableScrollPhysics()` for nested scroll

❌ Large image widgets without caching
✅ Using cached network images with proper sizing

---

## 👥 Team Implementation

**Developed by:** Flutter Development Team  
**Course:** S86-0126 Ignite - Building Smart Mobile Experiences with Flutter and Firebase  
**Date:** January 28, 2026  
**Status:** ✅ Complete & Tested

---

## 📄 File Structure

```
s86_0126_flutter_basics/
├── lib/
│   ├── main.dart                          # App entry point with routes
│   ├── firebase_options.dart
│   └── screens/
│       ├── scrollable_views.dart          # NEW: ListView & GridView implementation
│       ├── responsive_layout.dart         # Container, Row, Column layouts
│       ├── home_screen.dart              # Dashboard with navigation
│       ├── login_screen.dart             # Authentication
│       ├── signup_screen.dart            # User registration
│       └── ... (other screens)
└── README.md                              # This file
```

---

**Happy scrolling! 🚀**

---

## 🔌 Firebase SDK Integration (FlutterFire CLI) ✅

**Purpose:** Integrate Firebase into the Flutter app using the official FlutterFire CLI to enable Authentication, Firestore and other Firebase services across Android, iOS, Windows and Web without manual edits to platform files.

### Steps Performed
1. Ensured Flutter, Dart, Node.js/npm were available.
2. (Optional) Installed Firebase Tools and FlutterFire CLI if needed:

```bash
npm install -g firebase-tools
dart pub global activate flutterfire_cli
flutterfire --version
```

3. Configured the Flutter project using the FlutterFire CLI from the `s86_0126_flutter_basics` folder:

```bash
flutterfire configure
```

---

## 🔐 Firestore Database Schema (Sprint 2) ✅

**Short description:** A Firestore schema designed to support community sports tournaments with scalable collections for users, tournaments, teams, matches, players, venues and real-time match events/score updates.

### 📋 Data Requirements List
- Users (profiles, roles)
- Players (profiles, stats)
- Tournaments (metadata, dates, status)
- Teams (per tournament, members)
- Matches (per tournament: schedule, scores, status)
- Match events / score updates (time-series of events)
- Venues (location data)
- Registrations (teams/users registered for tournaments)

---

### 🔧 Firestore Schema
- users (collection)
  - userId (document)
    - name: string
    - email: string
    - displayName: string
    - photoUrl: string
    - role: string ("admin" | "organizer" | "player" | "spectator")
    - createdAt: timestamp
    - updatedAt: timestamp

- players (collection)
  - playerId
    - name: string
    - dob: timestamp
    - teamIds: array<string>
    - jerseyNumber: number
    - profilePhotoUrl: string
    - createdAt: timestamp

- tournaments (collection)
  - tournamentId
    - name: string
    - description: string
    - startDate: timestamp
    - endDate: timestamp
    - status: string ("UPCOMING" | "LIVE" | "COMPLETED")
    - locationId: string (venue ref)
    - createdBy: string (userId)
    - participantsCount: number
    - createdAt: timestamp

- tournaments/{tournamentId}/teams (subcollection)
  - teamId
    - name: string
    - coach: string
    - members: array<string> (playerIds) OR use subcollection members/

- tournaments/{tournamentId}/matches (subcollection)
  - matchId
    - teamAId: string
    - teamBId: string
    - scoreA: number
    - scoreB: number
    - status: string ("SCHEDULED" | "LIVE" | "COMPLETED")
    - scheduledAt: timestamp
    - venueId: string
    - createdAt: timestamp

- tournaments/{tournamentId}/matches/{matchId}/events (subcollection)
  - eventId
    - type: string ("score" | "foul" | "sub" | "timeout")
    - playerId: string
    - teamId: string
    - value: map (e.g., {points: 2})
    - timestamp: timestamp

- venues (collection)
  - venueId
    - name: string
    - address: string
    - geoPoint: geopoint
    - capacity: number

**Design notes:**
- Use lowerCamelCase for fields
- Use timestamps (createdAt/updatedAt) for sorting and queries
- Use subcollections for data that can grow large (matches/events) to avoid large arrays in a single document
- Store references as strings or Firestore `Reference` types for joins

---

### 📄 Sample JSON Documents
**User (users/user123)**
```json
{
  "name": "Asha Patel",
  "email": "asha@example.com",
  "displayName": "Asha",
  "role": "organizer",
  "createdAt": "2026-01-28T12:34:56Z"
}
```

**Tournament (tournaments/tourn001)**
```json
{
  "name": "City Basketball Championship 2026",
  "startDate": "2026-02-10T09:00:00Z",
  "endDate": "2026-02-20T18:00:00Z",
  "status": "UPCOMING",
  "createdBy": "user123",
  "participantsCount": 16
}
```

**Match (tournaments/tourn001/matches/matchA1)**
```json
{
  "teamAId": "teamA",
  "teamBId": "teamB",
  "scoreA": 72,
  "scoreB": 68,
  "status": "LIVE",
  "scheduledAt": "2026-02-11T14:30:00Z"
}
```

**Event (tournaments/tourn001/matches/matchA1/events/evt1)**
```json
{
  "type": "score",
  "playerId": "player77",
  "teamId": "teamA",
  "value": { "points": 2 },
  "timestamp": "2026-02-11T14:35:12Z"
}
```

---

### 🗺️ Schema Diagram
Diagram included in repository: `s86_0126_flutter_basics/assets/diagrams/firestore_schema.svg` (shows collections, docs, and subcollection relationships).

---

### 🔍 Reflection
- Why this structure? Subcollections for `matches` and `events` allow per-tournament isolation and efficient streaming of live events without loading unrelated data. Player profiles live in a top-level collection for reuse across tournaments.
- Scalability: using subcollections and avoiding large arrays ensures reads are targeted and cost-efficient as data grows to thousands of matches or events.
- Challenges: modeling relationships (e.g., players appearing in multiple teams across tournaments) required storing `teamIds` arrays on players and using team-level membership documents where necessary.

---

### 📦 Submission Guidance (for Sprint PR)
- Commit message: `feat: designed Firestore schema and added database diagram`
- PR title: `[Sprint-2] Firestore Database Schema Design – TeamName`
- PR description should include: schema explanation, diagram (attached or linked), sample documents, and short reflection bullet points.

---

*If you'd like I can also add a short demo script or Firestore seed JSON examples in `assets/data/` to make the next step (CRUD implementation) faster.*

# selected existing Firebase project
# FlutterFire CLI generated the platform configs
# lib/firebase_options.dart was created
```

4. Added and verified core Firebase packages in `pubspec.yaml`:

```yaml
dependencies:
  firebase_core: ^3.0.0
  firebase_auth: ^5.0.0
  cloud_firestore: ^5.0.0
```

5. Initialized Firebase in `lib/main.dart` using the generated options (no change to login/signup screens):

```dart
void main() async {
  int s;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
```

### Verification (Terminal logs)
- `lib/firebase_options.dart` header confirms CLI generation:

```dart
// File generated by FlutterFire CLI.
```

- App successfully ran on Chrome during local verification (short extract):

```
Launching lib\main.dart on Chrome in debug mode...
🔑 [LOGIN] User logged in: arun@gmail.com
🏠 [HOME] HomeScreen initialized
Application finished.
```

> Note: Firebase initialization completed successfully using `DefaultFirebaseOptions` (auto-generated by FlutterFire CLI).

### Reflection 💡
- FlutterFire CLI saved time by auto-generating `firebase_options.dart` and adding platform configuration (no manual GoogleService files edits required). ✅
- No errors encountered during verification; key checks were presence of `lib/firebase_options.dart` and `Firebase.initializeApp()` usage.
- CLI-based setup reduces human error and ensures consistent multi-platform configuration — preferred for production workflows.

### Submission / PR Guidelines (for final submission)
- Commit message: `feat: integrated Firebase SDKs using FlutterFire CLI`
- PR title: `[Sprint-2] Firebase SDK Integration with FlutterFire CLI – <TeamName>`
- PR description should include: steps followed, a short terminal log or screenshot, and a reflection (as above).
- Add a 1–2 minute demo video (show `flutterfire configure`/`flutter run` and open `lib/firebase_options.dart`) and add the shareable link to the PR.

---

If you'd like, I can create the PR branch and push these changes for you (I will not modify the login/signup screens). 🔧
# 🔐 Firebase Authentication (Email & Password) – Flutter

This project demonstrates **Email & Password authentication** in a Flutter app using **Firebase Authentication**.  
Users can **sign up**, **log in**, **log out**, and have their authentication state securely managed by Firebase — without building a custom backend.

---

## 🚀 Features

- User **Signup** with Email & Password  
- User **Login** with Email & Password  
- Firebase-managed **secure authentication**
- Authentication state handling
- Error handling with user-friendly messages
- Verified users visible in **Firebase Console**

---

## 🛠️ Tech Stack

- **Flutter**
- **Firebase Authentication**
- **Firebase Core**

---

## 📋 Prerequisites

Before running this project, make sure:

- Flutter SDK is installed
- Firebase project is created
- Firebase SDK is already integrated into the Flutter project
- `firebase_options.dart` is generated using FlutterFire CLI

---

## 🔧 Setup Instructions

### 1️⃣ Enable Email & Password Authentication

1. Go to **Firebase Console**
2. Select your project
3. Navigate to **Authentication → Sign-in method**
4. Enable **Email/Password**
5. Click **Save**

---

### 2️⃣ Add Dependencies

In `pubspec.yaml`:

```yaml
dependencies:
  firebase_core: ^3.0.0
  firebase_auth: ^5.0.0
