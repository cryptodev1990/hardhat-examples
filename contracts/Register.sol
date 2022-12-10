//SPDX-License-Identifier: UNLICENSED

// Solidity files have to start with this pragma.
// It will be used by the Solidity compiler to validate its version.
pragma solidity ^0.8.9;

contract Register {

  address public owner;

// teachers attrubutes define
  struct Teacher {
    uint32 teacherId;
    string teacherName;
    string teacherDepartment;
    string teacherEmail;
    address teacherAddress;
    bool isExist;
    bool isComplete;
  }

// students attrubutes define
  struct Student {
    uint32 teacherId;
    uint32 studentId;
    string studentName;
    string studentDepartment;
    string studentEmail;
    address studentAddress;
    bool isExist;
    bool isComplete;
  }

  mapping (uint32 => Teacher) teachers;
  uint32[] teacherIds;
  mapping (uint32 => mapping (uint32 => Student)) students;
  mapping(uint32 => uint32[]) studentIds;

  constructor() {
    owner = msg.sender;
  }

  modifier onlyOwner {
    require(msg.sender == owner);
    _;
  }

  function adminRegister(uint32 id, string memory name, string memory department, string memory email) public onlyOwner {
    require(teachers[id].isExist == false, "Already registered");
    teachers[id] = Teacher(id, name, department, email, address(0), true, false);
    teacherIds.push(id);
  }

  function teacherCompleteRegister(uint32 id, address newAddress) public {
    require(teachers[id].isExist == true, "Admin did not registered");
    require(teachers[id].isComplete == false, "Alrady registered");
    teachers[id].teacherAddress = newAddress;
    teachers[id].isComplete = true;
  }

  function studentRegister(uint32 teacherId, uint32 studentId, string memory name, string memory department, string memory email) public {
    require(teachers[teacherId].isExist == true, "You are not registeres as a teacher");
    require(students[teacherId][studentId].isExist == false, "Already registered student");
    students[teacherId][studentId] = Student(teacherId, studentId, name, department, email, address(0), true, false);
    studentIds[teacherId].push(studentId);
  }

  function studentCompleteRegister(uint32 teacherId, uint32 studentId, address newAddress) public {
    require(students[teacherId][studentId].isExist == true, "You are not registered by your teacher");
    require(students[teacherId][studentId].isComplete == false, "Already registered");
    students[teacherId][studentId].studentAddress = newAddress;
    students[teacherId][studentId].isComplete = true;
  }

  function getTeachers() public view returns (Teacher[] memory) {
    Teacher[] memory allTeachers = new Teacher[](teacherIds.length);
    for(uint i = 0; i < teacherIds.length; i++) {
      Teacher storage teacher = teachers[teacherIds[i]];
      allTeachers[i] = teacher;
    }
    return allTeachers;
  }

  function getStudents(uint32 teacherId) public view returns (Student[] memory) {
    uint studentCnt = studentIds[teacherId].length;
    Student[] memory allStudents = new Student[](studentCnt);
    for(uint i = 0; i < studentCnt; i++) {
      Student storage student = students[teacherId][studentIds[teacherId][i]];
      allStudents[i] = student;
    }
    return allStudents;
  }
}