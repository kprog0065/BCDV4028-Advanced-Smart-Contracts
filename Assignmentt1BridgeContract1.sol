// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BridgeContract1 is Ownable {
    IERC20 public token1;
    address public bridgeContract2;

    event TokensLocked(address sender, uint256 amount);

    constructor(address _token1, address _bridgeContract2) {
        token1 = IERC20(_token1);
        bridgeContract2 = _bridgeContract2;
    }

    function lockTokens(uint256 amount) external {
        require(token1.transferFrom(msg.sender, address(this), amount), "Transfer failed");
        emit TokensLocked(msg.sender, amount);
    }

    function unlockTokens(address recipient, uint256 amount) external onlyOwner {
        require(address(this).balance >= amount, "Insufficient balance");
        require(IERC20(bridgeContract2).transfer(recipient, amount), "Transfer failed");
    }
}
