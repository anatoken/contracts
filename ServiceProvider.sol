pragma solidity ^0.5.11;

contract ServiceProvider {

    struct Service {
    string serviceType;
    string serviceName;
    string location;
    uint startdate;
    uint enddate;
    string instructor;
    string costs;
    }

    Service[] public services;

    event ServiceIsMade(string serviceName);
    event ServiceIsUpdated(string serviceName);
    event ServiceIsDeleted(string serviceName);
    event ServiceIsRead(string serviceName);

    uint totalElements = 0;

    function makeService(string serviceType, string serviceName, string location, uint startdate, uint enddate, string instructor, string costs) public {
        Service newService = Service(serviceType, serviceName, location, startdate, enddate, instructor, costs);
        services.push(newService);
        totalElements++;
        emit ServiceIsMade(serviceName);
    }

    function updateService(string serviceType, string serviceName, string location, uint startdate, uint enddate, string instructor, string costs) public returns (bool success) {
          for(uint256 i = 0; i < totalElements; i++){
           if(compareStrings(services[i].serviceName, serviceName)){
              services[i].serviceType = serviceType;
              services[i].serviceName = serviceName;
              services[i].location = location;
              services[i].startdate = startdate;
              services[i].enddate = enddate;
              services[i].instructor = instructor;
              services[i].costs = costs;
              emit ServiceIsUpdated(serviceName);
              return true;
           }
       }
       return false;
    }

    function deleteService(string serviceName) public returns (bool success) {
        require(totalElements > 0, 'No element is found');
        for(uint256 i = 0; i < totalElements; i++){
           if(compareStrings(services[i].serviceName, serviceName)){
              services[i] = services[totalElements-1];
              delete services[totalElements-1];
              totalElements--;
              services.length--;
              emit ServiceIsDeleted(serviceName);
              return true;
           }
       }
       return false;
    }

    function readService(string serviceName) public view
    returns (string serviceType, string serviceName, string location, uint startdate, uint enddate, string instructor, string costs) {
            for(uint256 i = 0; i < totalElements; i++) {
           if(compareStrings(services[i].serviceName, serviceName)){
              return (services[i].serviceType, services[i].serviceName, services[i].location, services[i].startdate, services[i].enddate, services[i].instructor, services[i].costs);
              emit ServiceIsRead(serviceName);
           }
       }
       revert('Service is not found');
    }

    function compareStrings (string a, string b)  internal pure returns (bool){
       return keccak256(a) == keccak256(b);
    }



    }
