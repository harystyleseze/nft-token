// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {HarystylesNft} from "../src/HarystylesNft.sol"; // import the HarystylesNft contract
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";

contract MintHarystylesNft is Script {

    string public constant CID_URL = 
        "https://ipfs.io/ipfs/bafkreicz5vqq5kqpfo75fvvgfafd3nmrxvvzbxeg7ic53n7v4xbnl3kmt4";

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("HarystylesNft", block.chainid);

        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        HarystylesNft(contractAddress).mintNFT(CID_URL); // Call the mint function on the deployed contract
        vm.stopBroadcast();
    }
}