// SPDX-License-Identifier: MIT
pragma solidity ^0.8.34;

import {SimpleStor} from "./SimpleStor.sol";

contract StorageFactory{
    //Create a SimpleStor type array
    SimpleStor[] public simpleStor;

    //Function that stores a new deployed contract (SimpleStor) into the array, simpleStor
    function deployContract() public {

        SimpleStor newStor = new SimpleStor();
        simpleStor.push(newStor);
    }

    
    //Function that stores a string to a specified contract
    function storeString(string memory _string, uint256 _num) public {
        //Store the string _string into deployed contract
        SimpleStor targetContract = simpleStor[_num];
        targetContract.store(_string);
    }

    function retrieveString(uint256 _num) public view returns(string memory){
        return simpleStor[_num].retrieveStor();
    }

    function getContract() public view returns(SimpleStor[] memory){
        return simpleStor;
    }
}