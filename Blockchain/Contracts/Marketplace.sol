 
 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Marketplace is Ownable {
    struct Listing {
        address seller;
        uint256 price;
    }

    mapping(address => mapping(uint256 => Listing)) public listings;

    function createListing(address nftContract, uint256 tokenId, uint256 price) public {
        IERC721 nft = IERC721(nftContract);
        require(nft.ownerOf(tokenId) == msg.sender, "You are not the owner");
        require(nft.isApprovedForAll(msg.sender, address(this)), "Marketplace not approved");

        listings[nftContract][tokenId] = Listing({
            seller: msg.sender,
            price: price
        });
    }

    function buyNFT(address nftContract, uint256 tokenId) public payable {
        Listing storage listing = listings[nftContract][tokenId];
        require(msg.value == listing.price, "Incorrect price");

        IERC721 nft = IERC721(nftContract);
        nft.safeTransferFrom(listing.seller, msg.sender, tokenId);

        payable(listing.seller).transfer(msg.value);
        delete listings[nftContract][tokenId];
    }
}
