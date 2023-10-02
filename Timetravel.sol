// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TimeLockedContract {
    uint256 public unlockTime;
    bool public featureUnlocked;

    constructor(uint256 _unlockInMinutes) {
        unlockTime = block.timestamp + (_unlockInMinutes * 1 minutes);
        featureUnlocked = false;
    }

    function unlockFeature() external {
        require(block.timestamp >= unlockTime, "Feature is still locked");
        require(!featureUnlocked, "Feature is already unlocked");
        featureUnlocked = true;
    }
}


