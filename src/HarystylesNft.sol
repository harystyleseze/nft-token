// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract HarystylesNft is ERC721 {
    uint256 private tokenCounter;
    mapping(uint256 => string) private tokenIdToUri;

    constructor() ERC721("HarystylesNft", "HSN") {
        tokenCounter = 0;
    }

    function mintNFT(string memory tokenUri) public returns (uint256) {
        tokenIdToUri[tokenCounter] = tokenUri;
        _safeMint(msg.sender, tokenCounter);
        tokenCounter++;
        return tokenCounter - 1;  // Return the tokenId of the minted NFT
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        return tokenIdToUri[tokenId];
    }
}