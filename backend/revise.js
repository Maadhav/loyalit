const { Revise } = require("revise-sdk");
const { key, collectionId } = require("./config.js");
const { milestones } = require("./constants.js");
const revise = new Revise({
  auth: key,
});

async function run() {
  const collection = await revise.addCollection({
    name: "Discount Coupons",
    uri: "discount-coupons",
  });
  console.log("Collection created", collection);
}

exports.addNft = async ({
  tokenId,
  discount,
  daysUntilNextMilestone,
  milestone,
  uses = 1,
}) => {
  const image = "https://i.imgur.com/5cZyihP.png";
  const attributes = [
    { discount: discount.toString() },
    { uses: "1" },
    { "current milestone": "0" },
    { "max milestones achieved": milestone.toString() },
    { "days until next milestone": daysUntilNextMilestone.toString() },
  ];

  const nft = await revise.addNFT(
    {
      tokenId: tokenId.toString(),
      name: "Loyal It NFT",
      description: "Loyal It NFT",
      image: image,
    },
    attributes,
    collectionId
  );

  return nft.id;
};

exports.update = async ({
  discount,
  daysUntilNextMilestone,
  nftid,
  milestone,
}) => {
  const res = await revise.fetchNFT(nftid);
  let nft = revise.nft(res);

  nft.setProperty(
    "days until next milestone",
    daysUntilNextMilestone.toString()
  );
  nft.setProperty("current milestone", milestone.toString());
  if (discount != null) {
    nft.setProperty("max milestones achieved", (~~(discount / 5)).toString());
    nft.setProperty("discount", discount.toString());
  }
  nft.setProperty("uses", 1);
  nft.save();
};
