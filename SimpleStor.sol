// SPDX-License-Identifier: MIT
pragma solidity ^0.8.34;

contract SimpleStor {

    string public name;
    function userName(string memory _name) public {
        _name = string.concat(_name, " - updated");
        name = _name;
    }
    struct Person{
        string Name;
        uint256 id;
    }

    Person[] public listofPeople;
    mapping(string => uint256) public personId;

    function addPerson(uint256 _id, string memory _name) public {
        listofPeople.push( Person(_name, _id) );
        personId[_name] = _id;
    }

    function retrieve() public view returns(Person[] memory) {
        return listofPeople;
    }
}