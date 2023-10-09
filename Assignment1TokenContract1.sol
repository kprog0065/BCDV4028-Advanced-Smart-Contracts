// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenContract1 is ERC20 {
    constructor() ERC20("Token1", "TOK1") {
        _mint(msg.sender, 1000000 * (10**18)); // Mint 1,000,000 tokens to the contract deployer
    }
}
