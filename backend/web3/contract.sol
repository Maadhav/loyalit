// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Define the contract
contract LoyalIt {

    // Declare the admin address
    address admin;

    // Declare a mapping to store the NFTs owned by each email ID
    mapping (string => string[]) public nftsByUser;

    // Declare a mapping to store the current owner of each NFT
    mapping (string => string) public nftOwners;

    // Constructor to set the admin address
    constructor() {
        admin = msg.sender;
    }

    // Function to add a new NFT for a given email ID and NFT ID
    function addNFT(string memory email, string memory nftId) public onlyAdmin {
        // Add the NFT to the user's list
        nftsByUser[email].push(nftId);
        // Set the current owner of the NFT to the user's address
        nftOwners[nftId] = email;
    }

    // Function to transfer ownership of an NFT to another user
    function transferNFT(string memory nftId, string memory newOwnerEmail) public onlyAdmin {
        // Remove the NFT from the old owner's list
        string[] storage oldOwnerNfts = nftsByUser[getEmailByNftId(nftId)];
        for (uint i = 0; i < oldOwnerNfts.length; i++) {
            if (keccak256(bytes(oldOwnerNfts[i])) == keccak256(bytes(nftId))) {
                oldOwnerNfts[i] = oldOwnerNfts[oldOwnerNfts.length - 1];
                oldOwnerNfts.pop();
                break;
            }
        }
        // Add the NFT to the new owner's list
        nftsByUser[newOwnerEmail].push(nftId);
        // Set the current owner of the NFT to the new owner's address
        nftOwners[nftId] = newOwnerEmail;
    }

    // Function to get the NFTs owned by a user
    function getNFTsByUser(string memory email) public view returns (string[] memory) {
        return nftsByUser[email];
    }

    // Function to get the email of the current owner of an NFT
    function getEmailByNftId(string memory nftId) public view returns (string memory) {
        return nftOwners[nftId];
    }


    // Modifier to ensure that only the admin can call a function
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only the admin can call this function.");
        _;
    }
}
