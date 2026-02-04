import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScrollableViews extends StatefulWidget {
  const ScrollableViews({super.key});

  @override
  State<ScrollableViews> createState() => _ScrollableViewsState();
}

class _ScrollableViewsState extends State<ScrollableViews> {
  // Sample tournament data
  final List<Map<String, dynamic>> tournaments = [
    {
      'name': 'Basketball Championship 2024',
      'date': 'Jan 28 - Feb 15',
      'participants': 16,
      'status': 'Live',
    },
    {
      'name': 'Football League Cup',
      'date': 'Feb 1 - Mar 30',
      'participants': 20,
      'status': 'Upcoming',
    },
    {
      'name': 'Tennis Open',
      'date': 'Jan 20 - Jan 27',
      'participants': 32,
      'status': 'Completed',
    },
    {
      'name': 'Volleyball Masters',
      'date': 'Feb 10 - Mar 10',
      'participants': 12,
      'status': 'Upcoming',
    },
    {
      'name': 'Cricket Premier League',
      'date': 'Jan 28 - Feb 28',
      'participants': 8,
      'status': 'Live',
    },
  ];

  // Sample player stats
  final List<Map<String, dynamic>> playerStats = [
    {
      'name': 'Player 1',
      'team': 'Team A',
      'points': 234,
      'games': 15,
      'assists': 45,
    },
    {
      'name': 'Player 2',
      'team': 'Team B',
      'points': 218,
      'games': 14,
      'assists': 38,
    },
    {
      'name': 'Player 3',
      'team': 'Team C',
      'points': 205,
      'games': 15,
      'assists': 52,
    },
    {
      'name': 'Player 4',
      'team': 'Team D',
      'points': 198,
      'games': 13,
      'assists': 41,
    },
    {
      'name': 'Player 5',
      'team': 'Team A',
      'points': 187,
      'games': 15,
      'assists': 35,
    },
    {
      'name': 'Player 6',
      'team': 'Team B',
      'points': 176,
      'games': 14,
      'assists': 39,
    },
  ];

  // Sample match scores
  final List<Map<String, dynamic>> liveScores = [
    {
      'team1': 'Team A',
      'team2': 'Team B',
      'score1': 72,
      'score2': 68,
      'time': '3rd Quarter',
      'status': 'LIVE',
    },
    {
      'team1': 'Team C',
      'team2': 'Team D',
      'score1': 45,
      'score2': 42,
      'time': '2nd Quarter',
      'status': 'LIVE',
    },
    {
      'team1': 'Team E',
      'team2': 'Team F',
      'score1': 35,
      'score2': 28,
      'time': 'Final',
      'status': 'COMPLETED',
    },
    {
      'team1': 'Team G',
      'team2': 'Team H',
      'score1': 0,
      'score2': 0,
      'time': 'Starts in 2h',
      'status': 'UPCOMING',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sports Tournament Tracker'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(isTablet ? 24 : 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== LIVE SCORES SECTION (Horizontal ListView) =====
              Text(
                '🏆 Live Scores',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 140,
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('live_scores')
                      .snapshots(),
                  builder: (context, snapshot) {
                    List<Map<String, dynamic>> activeMatches = liveScores;

                    if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                      activeMatches = snapshot.data!.docs.map((d) {
                        final data = d.data();
                        return {
                          'team1': data['team1'] ?? 'Team A',
                          'team2': data['team2'] ?? 'Team B',
                          'score1': data['score1'] ?? 0,
                          'score2': data['score2'] ?? 0,
                          'time': data['time'] ?? 'N/A',
                          'status': (data['status'] ?? 'UPCOMING').toString().toUpperCase(),
                        };
                      }).toList();
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: activeMatches.length,
                      itemBuilder: (context, index) {
                        final match = activeMatches[index];
                        return Container(
                          width: 200,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: match['status'] == 'LIVE'
                                            ? Colors.red
                                            : match['status'] == 'COMPLETED'
                                                ? Colors.green
                                                : Colors.orange,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        match['status'],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      match['time'],
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      match['team1'],
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      match['team2'],
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${match['score1']}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepOrange,
                                      ),
                                    ),
                                    Text(
                                      '${match['score2']}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepOrange,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 28),

              // ===== TOURNAMENTS LIST (ListView) =====
              Text(
                '📋 Upcoming Tournaments',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('tournaments')
                      .orderBy('date', descending: false)
                      .snapshots(),
                  builder: (context, snapshot) {
                    List<Map<String, dynamic>> tournamentsList = tournaments;

                    if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                      tournamentsList = snapshot.data!.docs.map((d) {
                        final data = d.data();
                        return {
                          'name': data['name'] ?? 'Tournament',
                          'date': data['date'] ?? 'TBD',
                          'participants': data['participants'] ?? 0,
                          'status': (data['status'] ?? 'Upcoming'),
                        };
                      }).toList();
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    return ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: tournamentsList.length,
                      separatorBuilder: (context, index) =>
                          Divider(height: 1, color: Colors.grey[300]),
                      itemBuilder: (context, index) {
                        final tournament = tournamentsList[index];
                        return ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: tournament['status'] == 'Live'
                                  ? Colors.red.withOpacity(0.2)
                                  : tournament['status'] == 'Completed'
                                      ? Colors.green.withOpacity(0.2)
                                      : Colors.blue.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              tournament['status'] == 'Live'
                                  ? Icons.play_circle
                                  : tournament['status'] == 'Completed'
                                      ? Icons.check_circle
                                      : Icons.schedule,
                              color: tournament['status'] == 'Live'
                                  ? Colors.red
                                  : tournament['status'] == 'Completed'
                                      ? Colors.green
                                      : Colors.blue,
                            ),
                          ),
                          title: Text(
                            tournament['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          subtitle: Text(
                            '${tournament['date']} • ${tournament['participants']} participants',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: tournament['status'] == 'Live'
                                  ? Colors.red.withOpacity(0.2)
                                  : tournament['status'] == 'Completed'
                                      ? Colors.green.withOpacity(0.2)
                                      : Colors.blue.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              tournament['status'],
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: tournament['status'] == 'Live'
                                    ? Colors.red
                                    : tournament['status'] == 'Completed'
                                        ? Colors.green
                                        : Colors.blue,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 28),

              // ===== TOP PLAYERS GRID (GridView) =====
              Text(
                '⭐ Top Player Stats',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 12),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance.collection('players').snapshots(),
                builder: (context, snapshot) {
                  List<Map<String, dynamic>> players = playerStats;

                  if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    players = snapshot.data!.docs.map((d) {
                      final data = d.data();
                      return {
                        'name': data['name'] ?? 'Player',
                        'team': data['team'] ?? 'Team',
                        'points': data['points'] ?? 0,
                        'games': data['games'] ?? 0,
                        'assists': data['assists'] ?? 0,
                      };
                    }).toList();
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isTablet ? 3 : 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: players.length,
                    itemBuilder: (context, index) {
                      final player = players[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.15),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.primaries[index %
                                        Colors.primaries.length][300]!,
                                    Colors.primaries[index %
                                        Colors.primaries.length][600]!,
                                  ],
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                              ),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 24,
                                    backgroundColor: Colors.white.withOpacity(0.3),
                                    child: Text(
                                      '${index + 1}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    player['name'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    player['team'],
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Column(
                                children: [
                                  _buildStatRow(
                                    'Points',
                                    '${player['points']}',
                                  ),
                                  _buildStatRow(
                                    'Games',
                                    '${player['games']}',
                                  ),
                                  _buildStatRow(
                                    'Assists',
                                    '${player['assists']}',
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 28),

              // ===== STATS SUMMARY =====
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  border: Border.all(color: Colors.orange[200]!),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info, color: Colors.orange[700]),
                        const SizedBox(width: 12),
                        Text(
                          'About This View',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange[900],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '✓ ListView.builder - Efficient horizontal scrolling of live matches\n'
                      '✓ ListView.separated - Scrollable tournament list with dividers\n'
                      '✓ GridView.builder - Responsive grid of player statistics\n'
                      '✓ Adaptive Layout - Adjusts grid columns based on screen size\n'
                      '✓ Performance Optimized - Uses builder pattern for large datasets',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.orange[800],
                        height: 1.8,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange,
            ),
          ),
        ],
      ),
    );
  }
}
