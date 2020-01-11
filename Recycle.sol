pragma solidity ^0.5.12;
import "./access-control/RBAC.sol"; /// We should use this for role based access. as specified in our docs

contract Reycle{

    uint public averageTimeToCollectPlastic = 2;
    uint public totalCollectedPlastic = 0;

    struct CollectedPlastic{
        address collector;
        uint id;
        uint kg;
        uint dateCollected;
    }

    /// create events and modifiers here

    /// mappings
    mapping(uint => address) public plasticToOwner;
    mapping(address => uint) ownerPlasticCount;

    function _sendAnaTokenToCollector(address _collector, uint _kg) private {
        ///based on the weight send anatoken to collector
    }

    function sendAnaTokenToCollector(address collector, uint kg) public payable {
        _sendAnaTokenToCollector(collector, kg);
    }

    function getCollectedPlasticFromUser(address user) external view returns (uint[] memory) {
        //get all the collected plastic from a user
    }
}
