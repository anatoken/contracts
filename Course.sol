pragma solidity ^0.5.12;

///should be more, could be more. We should discuss with each other. 
///Also price of amount of anatokens should be listed here, i guess. 

contract Course {
    string public courseName;
    string public university;
    uint public date;
    string public instructor;

    constructor(string _courseName, string _university, uint _date, string _instructor) public {
        courseName = _courseName;
        university = _university;
        date = _date;
        instructor = _instructor;
    }
}