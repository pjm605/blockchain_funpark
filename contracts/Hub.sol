pragma solidity ^0.4.13;

import "./Owned.sol";
import "./FunPark.sol";


contract Hub is Owned{
    mapping (address => uint256) funParks;
    address[] private funParksIndex;
    
    function Hub () {
        
    }
    
    function createNewFunPark (address owner) 
        public
        returns (address newFunParkAddress)
    {
        FunPark newFunPark = new FunPark();
        newFunPark.setOwner(owner);
        
        funParks[newFunPark] = funParksIndex.push(newFunPark) - 1;
        return newFunPark;
    }
    
    function removeFunPark (address funpark) 
        public
        returns (bool success)
    {
        
    }
}