pragma solidity ^0.5.11;

contract ServiceProvider {

    struct Course {
    string courseName;
    string university;
    uint startdate;
    uint enddate;
    string instructor;
    }

    Course[] public services;

    event ServiceIsMade(string courseName, string university, uint startdate, uint enddate, string instructor);
    event ServiceIsUpdated(string courseName);
    event ServiceIsDeleted(string courseName);
    event ServiceIsRead(string courseName);

    uint totalElements = 0;

    function makeService(string courseName, string university, uint startdate, uint enddate, string instructor) public {
        Course newCourse = Course(courseName, university, startdate, enddate, instructor);
        services.push(newCourse);
        totalElements++;
        emit ServiceIsMade(courseName, university, startdate, enddate, instructor);
    }

    function updateService(string courseName, string university, uint startdate, uint enddate, string instructor) public returns (bool success) {
          for(uint256 i = 0; i < totalElements; i++){
           if(compareStrings(services[i].courseName, courseName)){
              services[i].courseName = courseName;
              services[i].university = university;
              services[i].startdate = startdate;
              services[i].enddate = enddate;
              services[i].instructor = instructor;
              emit ServiceIsUpdated(courseName);
              return true;
           }
       }
       return false;
    }

    function deleteService(string courseName) public returns (bool success) {
        require(totalElements > 0, 'No element is found');
        for(uint256 i = 0; i < totalElements; i++){
           if(compareStrings(services[i].courseName, courseName)){
              services[i] = services[totalElements-1];
              delete services[totalElements-1];
              totalElements--;
              services.length--;
              emit ServiceIsDeleted(courseName);
              return true;
           }
       }
       return false;
    }

    function readService(string courseName) public view
    returns (string courseName, string university, uint startdate, uint enddate, string instructor) {
            for(uint256 i = 0; i < totalElements; i++) {
           if(compareStrings(services[i].courseName, courseName)){
              return (services[i].courseName, services[i].university, services[i].startdate, services[i].enddate, services[i].instructor);
              emit ServiceIsRead(courseName);
           }
       }
       revert('Service is not found');
    }

    function compareStrings (string a, string b)  internal pure returns (bool){
       return keccak256(a) == keccak256(b);
    }



    }
