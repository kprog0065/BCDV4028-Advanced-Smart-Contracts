// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BridgeContract2 is Ownable {
    IERC20 public token2;
    address public bridgeContract1;

    event TokensLocked(address sender, uint256 amount);

    constructor(address _token2, address _bridgeContract1) {
        token2 = IERC20(_token2);
        bridgeContract1 = _bridgeContract1;
    }

    function lockTokens(uint256 amount) external {
        require(token2.transferFrom(msg.sender, address(this), amount), "Transfer failed");
        emit TokensLocked(msg.sender, amount);
    }

    function unlockTokens(address recipient, uint256 amount) external onlyOwner {
        require(address(this).balance >= amount, "Insufficient balance");
        require(IERC20(bridgeContract1).transfer(recipient, amount), "Transfer failed");
    }
}
