// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TargetContract {
    uint256 public myVariable; // Declare a state variable to store data

    // Function to set the value of myVariable
    function setVariable(uint256 newValue) public {
        myVariable = newValue; // Update the state variable with the provided value
    }

    // Function to get the value of myVariable
    function getVariable() public view returns (uint256) {
        return myVariable; // Return the current value of the state variable
    }
}
