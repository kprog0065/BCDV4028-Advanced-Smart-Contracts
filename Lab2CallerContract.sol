// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CallerContract {
    address public targetContractAddress; // Declare a state variable to store the address of the target contract

    // Constructor to initialize the target contract address
    constructor(address _targetContractAddress) {
        targetContractAddress = _targetContractAddress; // Set the target contract address during deployment
    }

    // Function to set the value of myVariable in the target contract using a delegate call
    function setVariable(uint256 newValue) public {
        // Perform a delegate call to update the state variable in the target contract
        (bool success, ) = targetContractAddress.delegatecall(abi.encodeWithSignature("setVariable(uint256)", newValue));
        require(success, "Delegate call to setVariable failed"); // Check if the delegate call was successful
    }

    // Function to get the value of myVariable from the target contract using a delegate call
    function getVariable() public returns (uint256) {
        // Perform a delegate call to read the state variable from the target contract
        (bool success, bytes memory result) = targetContractAddress.delegatecall(abi.encodeWithSignature("getVariable()"));
        require(success, "Delegate call to getVariable failed"); // Check if the delegate call was successful
        return abi.decode(result, (uint256)); // Decode the result and return it
    }
}
