// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ArithmeticOperations {
    address public owner; // Store the owner's address
    uint256[] public results; // Array to store calculation results

    constructor() {
        owner = msg.sender; // Set the owner as the deployer
    }

    // Basic arithmetic functions with modifier for owner-only access
    function performArithmetic(uint256 a, uint256 b, string memory operation) public returns (uint256) {
        require(msg.sender == owner, "Only owner can call this function");

        uint256 result;

        if (keccak256(abi.encodePacked(operation)) == keccak256(abi.encodePacked("add"))) {
            result = a + b;
        } else if (keccak256(abi.encodePacked(operation)) == keccak256(abi.encodePacked("subtract"))) {
            result = a - b;
        } else if (keccak256(abi.encodePacked(operation)) == keccak256(abi.encodePacked("multiply"))) {
            result = a * b;
        } else if (keccak256(abi.encodePacked(operation)) == keccak256(abi.encodePacked("divide"))) {
            require(b != 0, "Division by zero is not allowed");
            result = a / b;
        } else {
            revert("Invalid operation");
        }

        results.push(result);
        return result;
    }

    // Function to retrieve the last calculation result
    function getLastResult() public view returns (uint256) {
        uint256 length = results.length;
        require(length > 0, "No calculations performed yet");
        return results[length - 1];
    }
}