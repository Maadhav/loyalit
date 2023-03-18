const admin = require("firebase-admin");

var serviceAccount = require("./citric-proxy-379202-firebase-adminsdk-2ldw8-29d2de37a9.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const db = admin.firestore();

// Store the email and tokens in Firestore
exports.storeUser = (email, tokens) => {
  const userRef = db.collection("users").doc(email);

  userRef
    .set(
      {
        ...tokens,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
      },
      { merge: true }
    )
    .then(() => {
      console.log(`Stored tokens for ${email}`);
    })
    .catch((err) => {
      console.error(`Error storing tokens for ${email}:`, err);
    });
};

exports.storeNFTId = (email, nftid) => {
  const userRef = db.collection("users").doc(email);
  userRef
    .update({ nftid: nftid })
    .then(() => {
      console.log(`Stored NFT ID for ${email}`);
    })
    .catch((err) => {
      console.error(`Error storing NFT ID for ${email}:`, err);
    });
};

exports.getUserRefreshToken = async (email) => {
  // Get the user's refresh token from Firestore
  const userRef = db.collection("users").doc(email);
  const doc = await userRef.get();
  const refreshToken = doc.get("refresh_token");
  return refreshToken;
};

// get all user emails
exports.getAllUsers = async () => {
  const snapshot = await db.collection("users").get();
  const users = [];
  snapshot.forEach((doc) => {
    users.push({ ...doc.data(), email: doc.id });
  });
  return users;
};

exports.getTotalUserLength = async () => {
  const collectionRef = db.collection("users");
  const snapshot = await collectionRef.count().get();
  return snapshot.data().count;
};

exports.updateUserMilestone = async (email, milestone) => {
  const userRef = db.collection("users").doc(email);
  userRef
    .set(
      { ...milestone, updatedAt: admin.firestore.FieldValue.serverTimestamp() },
      { merge: true }
    )
    .then(() => {
      console.log(`Updated milestone for ${email}`);
    })
    .catch((err) => {
      console.error(`Error updating milestone for ${email}:`, err);
    });
};
