pragma solidity ^0.5.12;
import "./Course.sol";

contract CourseFactory is Course{
    address[] courses;

    mapping(address => address) UsersInCourse; /// i think?

    function createCourse(string courseName, string university, uint date, string instructor) public {
        Course course = new Course(courseName, university, date, instructor); //create new course contract
        courses.push(course);
    }

    function getCourses(){

    }

    function removeCourse(){

    }

    function addUserToCourse(){

    }

}