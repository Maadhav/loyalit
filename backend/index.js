const express = require("express");
const { google } = require("googleapis");
const { OAuth2Client } = require("google-auth-library");
const moment = require("moment-timezone");
const CronJob = require("node-cron");
const scheduledFunctions = require("./scheduledFunctions");
const {
  storeUser,
  getUserRefreshToken,
  getTotalUserLength,
  storeNFTId,
} = require("./firestore");
const { addNft, update } = require("./revise");

scheduledFunctions.initScheduledJobs(getFitnessData);

const app = express();
const PORT = process.env.PORT || 5050;

const CLIENT_ID =
  "54368817104-7a1123u3gcre2vmkvmihhv0kvao69u7k.apps.googleusercontent.com";
const CLIENT_SECRET = "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";
const REDIRECT_URI =
  "https://8265-2405-201-2007-2009-550c-3b09-3890-a026.in.ngrok.io/auth/google/callback";

const client = new OAuth2Client(CLIENT_ID, CLIENT_SECRET, REDIRECT_URI);

app.get("/", (req, res) => {
  res.send("Hello, World!");
});

app.get("/auth/google", (req, res) => {
  const authorizeUrl = client.generateAuthUrl({
    access_type: "offline",
    prompt: "consent",
    scope: [
      "profile",
      "email",
      "https://www.googleapis.com/auth/fitness.activity.read",
      "https://www.googleapis.com/auth/fitness.body.read",
    ],
  });
  res.redirect(authorizeUrl);
});

app.get("/auth/google/callback", async (req, res) => {
  const code = req.query.code;

  try {
    const { tokens } = await client.getToken(code);
    console.log(tokens);
    const accessToken = tokens.access_token;
    const refreshToken = tokens.refresh_token;
    const idToken = tokens.id_token;

    const payload = idToken.split(".")[1];
    const decodedPayload = Buffer.from(payload, "base64").toString("utf-8");
    const email = JSON.parse(decodedPayload).email;

    // Store the access token and refresh token in the database
    // Return the tokens to the client
    // console.log(accessToken, refreshToken);

    storeUser(email, tokens);
    res.redirect(
      "loyalitycraft://login?accessToken=" + accessToken + "&idToken=" + idToken
    );
  } catch (error) {
    console.log(error);
    res.redirect("loyalitycraft://login?error=" + error);
  }
});

// Define an endpoint that retrieves the user's fitness data
app.get("/fitness", async (req, res) => {
  const { email } = req.query;

  try {
    const refreshToken = await getUserRefreshToken(email);
    if (!refreshToken) {
      res.status(400).send("User not found or refresh token missing");
      return;
    }

    const steps = await getFitnessData(refreshToken);

    res.send(`User ${email} has taken ${steps} steps today`);
  } catch (error) {
    console.error(error);
    res.status(500).send("Error retrieving fitness data");
  }
});

// create inital NFT
app.post("/createNFT", async (req, res) => {
  const { email } = req.query;

  try {
    const refreshToken = await getUserRefreshToken(email);
    if (!refreshToken) {
      res.status(400).send("User not found or refresh token missing");
      return;
    }
    const totalUserCount = await getTotalUserLength();
    console.log(totalUserCount);
    const nft = await addNft({
      tokenId: totalUserCount,
      discount: 0,
      daysUntilNextMilestone: 7,
      milestone: 0,
    });

    storeNFTId(email, nft);
    res.send(`User ${email} has created NFT with id ${nft}`);
  } catch (error) {
    console.error(error);
    res.status(500).send("Error creating NFT");
  }
});

// a Funcction which retrieves the user's fitness data
async function getFitnessData(refreshToken) {
  const client = new OAuth2Client(CLIENT_ID, CLIENT_SECRET, REDIRECT_URI);

  client.setCredentials({ refresh_token: refreshToken });
  // Set the timezone to the user's timezone
  const timezone = "Asia/Calcutta";
  moment.tz.setDefault(timezone);

  // Get the current time in the user's timezone
  const now = moment();

  const endMicros = now.unix() * 1000000000;
  const start = now.startOf("day");

  const startMicros = start.unix() * 1000000000;
  const datasetId = `${startMicros}-${endMicros}`;
  console.log(startMicros, endMicros);
  // const datasetId = `1678041000000000000-1678071152726000000`;

  // Retrieve the user's fitness data using the Fitness API
  const fitness = google.fitness("v1");
  const response = await fitness.users.dataSources.datasets.get({
    userId: "me",
    dataSourceId:
      "derived:com.google.step_count.delta:com.google.android.gms:estimated_steps",
    datasetId: datasetId,
    auth: client,
  });

  const steps = response.data.point.reduce((total, point) => {
    return total + point.value[0].intVal;
  }, 0);
  return steps;
}

app.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);
});
