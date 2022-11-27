//SPDX-License-Identifier: UNLICENSED

// Solidity files have to start with this pragma.
// It will be used by the Solidity compiler to validate its version.
pragma solidity ^0.8.9;

import "hardhat/console.sol";

contract Register {

  address public owner;

  struct teacher {
    uint32 teacherId;
    string teacherName;
    string teacherDepartment;
    string teacherEmail;
    address teacherAddress;
    bool isExist;
    bool isComplete;
  }

  struct student {
    uint32 teacherId;
    uint32 studentId;
    string studentName;
    string studentDepartment;
    string studentEmail;
    address studentAddress;
    bool isExist;
    bool isComplete;
  }

  mapping (uint32 => teacher) teachers;
  mapping (uint32 => mapping (uint32 => student)) students;

  constructor() public {
    owner = msg.sender;
  }

  modifier onlyOwner {
    require(msg.sender == owner);
    _;
  }

  function adminRegister(uint32 memory id, string memory name, string memory department, string memory email) public onlyOwner {
    require(teachers[id].isExist == false, "Already registered");
    teachers[id] = teacher(id, name, department, email, address(0), true, false);
  }

  function teacherCompleteRegister(uint32 memory id, address memory newAddress) public {
    require(teachers[id].isExist == true, "Admin did not registered");
    require(teachers[id].isComplete == false, "Alrady registered");
    teachers[id].teacherAddress = newAddress;
    teachers[id].isComplete = true;
  }

  function studentRegister(uint32 memory teacherId, uint32 memory studentId, string memory name, string memory department, string memory email) public {
    require(teachers[teacherId].isExist == true, "You are not registeres as a teacher");
    require(students[teacherId][studentId].isExist == false, "Already registered student");
    students[teacherId][studentId] = student(teacherId, studentId, name, department, email, address(0), true, false);
  }

  function studentCompleteRegister(uint32 memory teacherId, uint32 memory studentId, address memory newAddress) public {
    require();
  }
}