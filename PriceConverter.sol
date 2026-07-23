// SPDX-License-Identifier: MIT
pragma solidity ^0.8.34;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getPrice() internal view returns(uint256){
        //ETH to USD contract address = 0x694AA1769357215DE4FAC081bf1f309aDC325306
        AggregatorV3Interface usdPrice = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 price,,,) = usdPrice.latestRoundData();
        return uint256(price * 1e10);
    }

    function getETHAmount(uint256 _ethAmount) internal view returns(uint256){
        uint256 usdPrice = getPrice();
        uint256 conversionPrice = (usdPrice * _ethAmount) / 1e18;
        return conversionPrice;
    }

    function convertETHtoUSD(uint256 usdAmount, uint256 ethValue) internal pure returns(uint256){
        
        //530000000000000 * 200 
        uint256 usdtoETH = ethValue * usdAmount;
        return usdtoETH;
    }
}