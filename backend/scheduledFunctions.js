const CronJob = require("node-cron");
const { milestones, DAILY_GOAL } = require("./constants");
const { getAllUsers, updateUserMilestone } = require("./firestore");
const { update } = require("./revise");

exports.initScheduledJobs = (getFitnessData) => {
  const fetchData = CronJob.schedule("0 * * * *", async () => {
    console.log("I'm executed on a schedule!");
    const users = await getAllUsers();
    users.forEach(async (user) => {
      const steps = await getFitnessData(user.refresh_token);
      const consecutiveDays = user.consecutiveDays || 0;
      const previousMilestone = user.previousMilestone || 0;
      const updatedAt = user.updatedAt.toDate();
      if (sameDay(updatedAt, new Date())) {
        return;
      } else if (steps > DAILY_GOAL && user.nftid != null) {
        const newMilestone = milestones[consecutiveDays + 1];
        const nextMilestone = (newMilestone || user.milestone) + 1;
        const daysUntilNextMilestone =
          Object.keys(milestones)[
            Object.values(milestones).indexOf(nextMilestone)
          ] -
          (consecutiveDays + 1);
        updateUserMilestone(user.email, {
          consecutiveDays: sameDay(
            updatedAt,
            new Date(new Date().setDate(new Date().getDate() - 1))
          )
            ? consecutiveDays + 1
            : 1,
          previousMilestone:
            newMilestone != null
              ? newMilestone > previousMilestone
                ? newMilestone
                : previousMilestone
              : previousMilestone,
          milestone: sameDay(
            updatedAt,
            new Date(new Date().setDate(new Date().getDate() - 1))
          )
            ? newMilestone || user.milestone
            : 0,
          daysUntilNextMilestone: daysUntilNextMilestone,
          highestConsecutiveDays:
            consecutiveDays + 1 > user.hieghestConsecutiveDays
              ? consecutiveDays + 1
              : user.hieghestConsecutiveDays || 0,
        });

        // TODO: Add NFT to Revise
        update({
          discount:
            (newMilestone != null
              ? newMilestone > previousMilestone
                ? newMilestone
                : previousMilestone
              : previousMilestone) * 5,
          nftid: user.nftid,
          milestone: newMilestone || user.milestone,
          daysUntilNextMilestone: daysUntilNextMilestone,
        });

        console.log({
          discount:
            (newMilestone != null
              ? newMilestone > previousMilestone
                ? newMilestone
                : previousMilestone
              : previousMilestone) * 5,
          nftid: user.nftid,
          daysUntilNextMilestone: daysUntilNextMilestone,
        });
      } else if (
        !sameDay(
          updatedAt,
          new Date(new Date().setDate(new Date().getDate() - 1))
        )
      ) {
        updateUserMilestone(user.email, {
          consecutiveDays: 0,
          milestone: 0,
          daysUntilNextMilestone: 7,
        });
        update({
          nftid: user.nftid,
          daysUntilNextMilestone: 7,
          milestone: 0,
        });
      }

      console.log(user.email, steps);
    });
  });

  fetchData.start();
};

function sameDay(d1, d2) {
  return (
    d1.getFullYear() === d2.getFullYear() &&
    d1.getMonth() === d2.getMonth() &&
    d1.getDate() === d2.getDate()
  );
}
