pragma solidity ^0.4.13;

import "./interfaces/HubI.sol";
import "./interfaces/FunParkI.sol";
import "./Owned.sol";
import "./FunPark.sol";


contract Hub is HubI, Owned{
    mapping (address => uint256) funParks;
    address[] private funParksIndex;
    
    function Hub () {
        
    }
    
    function createNewFunPark (address owner) 
        public
        fromOwner
        returns (FunParkI _newFunPark)
    {
        FunPark newFunPark = new FunPark();
        newFunPark.setOwner(owner);
        
        _newFunPark = FunParkI(newFunPark);
        funParks[newFunPark] = funParksIndex.push(newFunPark) - 1;
        
        LogFunParkCreated(msg.sender, _newFunPark, owner);
        return _newFunPark;
    }
    
    function removeFunPark (address funPark) 
        public
        fromOwner
        returns (bool success)
    {
        uint targetFunParkIndex = funParks[funPark];
        address funParkToMove = funParksIndex[funParksIndex.length - 1];
        funParksIndex[targetFunParkIndex] = funParkToMove;
        funParks[funParkToMove] = targetFunParkIndex;
        funParksIndex.length--;
        
        LogFunParkRemoved(msg.sender, funPark);
        return true;
    }
    
    function isFunPark (address funPark)
        constant
        public
        returns (bool indeed) 
    {
        if (funParksIndex.length == 0) {
            return false;
        }
        
        return (funParksIndex[funParks[funPark]] == funPark);
    }
}