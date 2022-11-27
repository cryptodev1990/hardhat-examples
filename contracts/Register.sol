//SPDX-License-Identifier: UNLICENSED

// Solidity files have to start with this pragma.
// It will be used by the Solidity compiler to validate its version.
pragma solidity ^0.8.9;

import "hardhat/console.sol";

contract Register {

  address public owner;

  struct teacher {
    uint32 id;
    string name;
    string department;
    string email;
    address Address;
    bool isExist;
    bool isComplete;
  }

  mapping (uint => teacher) teachers;

  constructor() public {
    owner = msg.sender;
  }

  modifier onlyOwner {
    require(msg.sender == owner);
    _;
  }

  function adminRegister(uint32 memory id, string memory name, string memory department, string memory email) public onlyOwner {
    require(teachers[id].isExist == false, "Already Registered");
    teachers[id] = teacher(id, name, department, email, address(0), true, false);
  }

  function completeRegister(uint32 memory id, address memory newAddress) public {
    require(teachers[id].isExist == true, "Admin did not registered");
    require(teachers[id].isComplete == false, "Alrady registered");
    teachers[id].Address = newAddress;
  }
}