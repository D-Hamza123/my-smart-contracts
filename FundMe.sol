// SPDX-License-Identifier: MIT
pragma solidity ^0.8.34;

import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;

    address[] public transactions;
    mapping(address funder => uint256 transactionsAmount) public amount;

    address public owner;
    //864,262 gas
    //844,520 gas
    uint256 public constant MINIMUM_AMOUNT = 5e18;

    constructor() {
        owner = msg.sender;
    }

    function fund() public payable {
        require(msg.value.getETHAmount() >= MINIMUM_AMOUNT, "Not enough ETH");
        transactions.push(msg.sender);
        amount[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner{
        for (uint256 transactionsIndex = 0; transactionsIndex < transactions.length; transactionsIndex++) {
            address funder = transactions[transactionsIndex];
            amount[funder] = 0;
        }
        transactions = new address[](0);
        (bool success, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(success, "Withdrawal transaction failed!");
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }
    receive() external payable { 
        fund();
    }

    fallback() external payable { 
        fund();
    }
}