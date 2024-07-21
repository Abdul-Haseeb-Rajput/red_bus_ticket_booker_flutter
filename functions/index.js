const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();
const db = admin.firestore();

exports.updateTicketStatus = functions.firestore
    .document("tickets/{ticketId}")
    .onUpdate((change, context) => {
      const newValue = change.after.data();
      const expiryTime = newValue.expiryTime.toDate();
      const scanCount = newValue.scanCount;

      if (expiryTime < new Date() || scanCount >= 2) {
        return change.after.ref.update({isExpired: true});
      } else {
        return change.after.ref.update({isExpired: false});
      }
    });

exports.scheduledFunctionCrontab = functions.pubsub
    .schedule("every 24 hours")
    .onRun(async (context) => {
      const snapshot = await db.collection("tickets")
          .where("expiryTime", "<", new Date())
          .get();
      const batch = db.batch();
      snapshot.forEach((doc) => {
        batch.update(doc.ref, {isExpired: true});
      });
      await batch.commit();
      return null;
    });
