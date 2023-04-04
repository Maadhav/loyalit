const { ethers } = require("ethers");
const abi = require("./contract.json");
require("dotenv").config();

// Set up the provider and signer using the RPC endpoint and the admin private key
const provider = new ethers.providers.JsonRpcProvider(
  "https://rpc.ankr.com/polygon_mumbai"
);
const privateKey = process.env.ADMIN_PRIVATE_KEY;
const signer = new ethers.Wallet(privateKey, provider);

// Set up the contract interface using the ABI and contract address
const contractAbi = abi;
const contractAddress = "0xd4657aA4ddc7564B1A45Cc1C62f19f5E1F9F478e";
const contract = new ethers.Contract(contractAddress, contractAbi, signer);

// Example function to add a new NFT for a given email ID and NFT ID
async function addNFT(email, nftId) {
  // Call the contract's "addNFT" function
  const tx = await contract.addNFT(email, nftId);
  // Wait for the transaction to be confirmed
  await tx.wait();
  console.log(`Added NFT ${nftId} for email ${email}`);
  return tx;
}

// Example function to transfer ownership of an NFT to another user
async function transferNFT(nftId, newOwnerEmail) {
  // Call the contract's "transferNFT" function
  const tx = await contract.transferNFT(nftId, newOwnerEmail);
  // Wait for the transaction to be confirmed
  await tx.wait();
  console.log(`Transferred ownership of NFT ${nftId} to ${newOwnerEmail}`);
  return tx;
}

// Example function to get the NFTs owned by a user
async function getNFTsByUser(email) {
  // Call the contract's "getNFTsByUser" function
  const nfts = await contract.getNFTsByUser(email);
  console.log(`NFTs owned by ${email}: ${nfts.join(", ")}`);
  return nfts;
}

// Call the example functions
// addNFT("example@example.com", "example-nft-id");
// transferNFT("example-nft-id", "new-owner@example.com");
getNFTsByUser("example@example.com");

module.exports = {
  mintNFT: addNFT,
  transferNFT,
  getNFTsByUser,
};
