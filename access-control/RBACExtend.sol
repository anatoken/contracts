pragma solidity ^0.5.12;
import "./RBAC.sol";

/// @title RBACExtend
/// @author Djamaile Rahamat
/// @dev functions build upon the RBAC
contract RBACExtend {
    RBAC internal roles;
    
    constructor(address _root) public{
        roles = new RBAC(_root);
        roles.addRole(stringToBytes32("collector"), stringToBytes32("ROOT"));
        roles.addRole(stringToBytes32("university"), stringToBytes32("ROOT"));
        roles.addRole(stringToBytes32("recyclePlant"), stringToBytes32("ROOT"));
    }
    
    
    /**
     * @notice A method that checks if the contract has this role. This is mostly for debugging reasons. 
     * @param roleId The role that we want to check if it exists
     */
    function contractHasRole(string memory roleId) public view returns (bool){
        return roles.roleExists(stringToBytes32(roleId));
    }
    
    
    /**
     * @notice A method that convert strings to bytes32. RBAC only accepts bytes32 inputs
     * @param source string that is going to be converted to a byte32
    */
    function stringToBytes32(string memory source) public pure returns (bytes32 result) {
        bytes memory tempEmptyStringTest = bytes(source);
        if (tempEmptyStringTest.length == 0) {
            return 0x0;
        }
        
        assembly {
            result := mload(add(source, 32))
        }
    }
}
