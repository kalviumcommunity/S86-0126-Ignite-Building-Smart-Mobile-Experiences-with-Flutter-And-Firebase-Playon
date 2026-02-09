const functions = require("firebase-functions");
const admin = require("firebase-admin");

// Initialize Firebase Admin
admin.initializeApp();

// Callable Function: Greet User with Tournament Score
exports.sayHello = functions.https.onCall((data, context) => {
  try {
    const name = data.name || "User";
    const score = data.score || 0;
    console.log(`[sayHello] Called by user: ${name} with score: ${score}`);
    
    return {
      message: `Welcome to Sports Tournament, ${name}!`,
      score: score,
      timestamp: new Date().toISOString(),
      success: true
    };
  } catch (error) {
    console.error("[sayHello] Error:", error);
    throw new functions.https.HttpsError("internal", "Error processing request");
  }
});

// Callable Function: Calculate Tournament Points
exports.calculatePoints = functions.https.onCall((data, context) => {
  try {
    const wins = data.wins || 0;
    const draws = data.draws || 0;
    const losses = data.losses || 0;
    const pointsPerWin = 3;
    const pointsPerDraw = 1;
    
    const totalPoints = (wins * pointsPerWin) + (draws * pointsPerDraw);
    
    console.log(`[calculatePoints] Wins: ${wins}, Draws: ${draws}, Losses: ${losses}, Total Points: ${totalPoints}`);
    
    return {
      totalPoints: totalPoints,
      breakdown: {
        winPoints: wins * pointsPerWin,
        drawPoints: draws * pointsPerDraw,
        lossPoints: 0
      },
      record: `${wins}W-${draws}D-${losses}L`,
      timestamp: new Date().toISOString(),
      success: true
    };
  } catch (error) {
    console.error("[calculatePoints] Error:", error);
    throw new functions.https.HttpsError("internal", "Error calculating points");
  }
});

// Event-Based Function: Trigger on New Match Creation
exports.onNewMatchCreated = functions.firestore
  .document("matches/{matchId}")
  .onCreate(async (snap, context) => {
    try {
      const matchData = snap.data();
      const matchId = context.params.matchId;
      
      console.log(`[onNewMatchCreated] New match created with ID: ${matchId}`);
      console.log(`[onNewMatchCreated] Match data:`, matchData);
      
      // Add metadata to the match document
      await snap.ref.update({
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
        status: "scheduled",
        notificationSent: true,
        processedByFunction: true
      });
      
      console.log(`[onNewMatchCreated] Successfully updated match ${matchId} with metadata`);
      return null;
    } catch (error) {
      console.error("[onNewMatchCreated] Error:", error);
      return null;
    }
  });

// Event-Based Function: Trigger on New Tournament Result
exports.onTournamentResultSubmitted = functions.firestore
  .document("tournamentResults/{resultId}")
  .onCreate(async (snap, context) => {
    try {
      const resultData = snap.data();
      const resultId = context.params.resultId;
      
      console.log(`[onTournamentResultSubmitted] New result submitted with ID: ${resultId}`);
      console.log(`[onTournamentResultSubmitted] Result data:`, resultData);
      
      // Calculate and store additional statistics
      const score = resultData.score || 0;
      const teamName = resultData.teamName || "Unknown";
      
      await snap.ref.update({
        recordedAt: admin.firestore.FieldValue.serverTimestamp(),
        processed: true,
        pointsEarned: calculatePoints(resultData),
        notification: `${teamName} scored ${score} points!`
      });
      
      console.log(`[onTournamentResultSubmitted] Successfully processed result ${resultId}`);
      return null;
    } catch (error) {
      console.error("[onTournamentResultSubmitted] Error:", error);
      return null;
    }
  });

// Helper function to calculate points
function calculatePoints(data) {
  const wins = data.wins || 0;
  const draws = data.draws || 0;
  return (wins * 3) + (draws * 1);
}

// Event-Based Function: Update Rankings on Result Change
exports.updateTournamentRankings = functions.firestore
  .document("tournamentResults/{resultId}")
  .onUpdate(async (change, context) => {
    try {
      const newData = change.after.data();
      const oldData = change.before.data();
      
      console.log("[updateTournamentRankings] Tournament result updated");
      console.log("[updateTournamentRankings] Old data:", oldData);
      console.log("[updateTournamentRankings] New data:", newData);
      
      // Trigger ranking recalculation (in production, you would query and update rankings)
      return { rankedUpdated: true };
    } catch (error) {
      console.error("[updateTournamentRankings] Error:", error);
      return null;
    }
  });
