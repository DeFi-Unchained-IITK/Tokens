// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "ds-test/test.sol";
import "../src/ERCToken.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DUNTest is DSTest {
    DUN public dun;
    address public owner;
    uint256 constant cap = 100000000 * 10 ** 18; // Example cap
    uint256 constant reward = 5000 * 10 ** 18; // Example block reward

    function setUp() public {
        owner = address(this); // Test contract is the owner
        dun = new DUN(100000000,5000);
    }

    function testDeployment() public {
        assertEq(dun.owner(), owner);
        assertEq(dun.blockReward(), reward);
        assertEq(dun.cap(), cap);
        assertEq(dun.totalSupply(), 70000000 * 10 ** 18); // Assuming initial minting
    }

    function testMint() public {
        uint256 mintAmount = 10000000 * 10 ** 18;
        dun.mint(owner, mintAmount);
        assertEq(dun.totalSupply(), (70000000 * 10 ** 18) + mintAmount);
    }

    function testFailMintAboveCap() public {
        uint256 mintAmount = cap + 1 * 10 ** 18; // Exceeds cap
        dun.mint(owner, mintAmount); // This should fail
    }

    // Add more tests as needed
}