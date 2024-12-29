// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployHarystylesNft} from "../script/DeployHarystylesNft.s.sol";
import {HarystylesNft} from "../src/HarystylesNft.sol";

contract HarystylesNftTest is Test {
    DeployHarystylesNft public deployer;
    HarystylesNft public harystylesNft;
    address public USER1 = makeAddr("user1");
    string public constant CID_URL = "https://ipfs.io/ipfs/bafkreicz5vqq5kqpfo75fvvgfafd3nmrxvvzbxeg7ic53n7v4xbnl3kmt4";


    function setUp() public {
        deployer = new DeployHarystylesNft();
        harystylesNft = deployer.run();
    }
    function testNameIsCorrect() public view {
        string memory expectedName = "HarystylesNft";
        string memory actualName = harystylesNft.name();
        // compare strings
        assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(abi.encodePacked(actualName))));

    }
    function testCanMintAndHaveBalance() public {
        vm.prank(USER1);
        harystylesNft.mintNFT(CID_URL);

        assert(harystylesNft.balanceOf(USER1) == 1);
        assert(keccak256(abi.encodePacked(CID_URL)) == keccak256(abi.encodePacked(harystylesNft.tokenURI(0))));
    }

}
