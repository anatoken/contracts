pragma solidity ^0.5.12;
import "./Course.sol";
import "./access-control/RBACExtend.sol";

contract CourseFactory is Course{
    address[] courses;
    RBACExtend roleHelper;

    mapping(address => address) UsersInCourse; /// i think?

    constructor() public {
        roleHelper = new RBACExtend();
    }

    //is this even needed? Maybe only root should be to create & remove courses.
    modifier hasUniRole {require(roleHelper.userHasRole("university"), "User doesn't have this role"); _;}
    modifier hasRootRole {require(roleHelper.userHasRole("ROOT"), "User doesn't have this role"); _;}

    function createCourse(string courseName, string university, uint date, string instructor) public hasRootRole hasUniRole {
        Course course = new Course(courseName, university, date, instructor); //create new course contract
        courses.push(course);
    }

    function getCourses() public hasRootRole hasUniRole {
        
    }

    function removeCourse() public hasRootRole hasUniRole {

    }

    function addUserToCourse() public hasRootRole hasUniRole {

    }

}