// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {HarystylesNft} from "../src/HarystylesNft.sol"; // import the HarystylesNft contract
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract MintHarystylesNft is Script {

    string public constant TOKENURI = 
        "ipfs://QmeTMfFJJw6hvRrYo6iWFGUsTcpPveSo9X8LkBWF1HM98y";

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("HarystylesNft", block.chainid);

        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        HarystylesNft(contractAddress).mintNFT(TOKENURI); // Call the mint function on the deployed contract
        vm.stopBroadcast();
    }
}