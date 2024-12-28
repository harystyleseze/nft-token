// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {HarystylesNft} from "../src/HarystylesNft.sol";

contract DeployHarystylesNft is Script {
    function run() external returns (HarystylesNft){
        vm.startBroadcast();
        HarystylesNft harystylesNft = new HarystylesNft();
        vm.stopBroadcast();
        return harystylesNft;
    }
}