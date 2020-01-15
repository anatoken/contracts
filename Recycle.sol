pragma solidity ^0.5.12;
import "./access-control/RBACExtend"; /// We should use this for role based access. as specified in our docs

contract Reycle{
    
  
    uint public averageTimeToCollectPlastic = 2;
    uint public totalCollectedPlastic = 0;
    bool public rightRole;
    RBACExtend roleHelper;

    struct CollectedPlastic{
        address collector;
        uint id;
        uint kg;
        uint dateCollected;
    }
    
    constructor() public {
        roleHelper = new RBACExtend();
    }

    /// create events and modifiers here
    modifier hasCollectorRole { require(roleHelper.userHasRole("collector"), "User doesn't have this role"); _;}
    modifier hasRecyclePlantRole { require(roleHelper.userHasRole("recyclePlant"), "User doesn't have this role"); _;}
    modifier hasRootRole {require(roleHelper.userHasRole("ROOT"), "User doesn't have this role"); _;} //might not be needed

    /// mappings
    mapping(uint => address) public plasticToOwner;
    mapping(address => uint) ownerPlasticCount;
    
    /*
     * Example function on how to use the RBACExtend contract
    */
    function roleExampleFunction() public hasRootRole view returns(string memory){
        return "Has role";
    }
    
    function _roleExampleFunction() public payable  returns (string memory) {
        roleExampleFunction();
    }
    
    function _sendAnaTokenToCollector(address _collector, uint _kg) private hasRecyclePlantRole {
        ///based on the weight send anatoken to collector
    }

    function sendAnaTokenToCollector(address collector, uint kg) public payable {
        _sendAnaTokenToCollector(collector, kg);
    }

    function getCollectedPlasticFromUser(address user) external hasCollectorRole view returns (uint[] memory) {
        //get all the collected plastic from a user
    }
}

