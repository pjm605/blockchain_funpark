pragma solidity ^0.4.13;

import "./Owned.sol";
import "./Pausable.sol";
import "./AttractionHolder.sol";


contract FunPark is Owned, Pausable, AttractionHolder {
    
    // struct RideHistory {
    //   address attraction;
    //   uint deposit;
    // }
    
    //mapping(address => RideHistory[]) history;
    // history[msg.sender].push(obj);
    mapping (address => uint) balances;
    
    function FunPark () {
    }
    
    function enterAttraction (address attraction)
        public
        payable
        returns (bool success)
    {
        require(isAttraction(attraction) == true);
        require(isPaused() == false);
        require(attraction != address(0));
        require(msg.value != 0);
        uint attractionFee = getAttractionFee(attraction);
        require (msg.value >= attractionFee);

        if (msg.value > attractionFee) {        
            uint refund = (msg.value - attractionFee);
            balances[owner] += attractionFee;
        //    registeredCustomer(?).transfer(refund)
        } else { 
            balances[owner] += msg.value;
        }
    }
    
    function getCollectedFeesAmount () 
        constant
        public
        returns(uint amount)
    {
        return balances[owner];
    }
    
    function withdrawCollectedFees() 
        public
        fromOwner
        returns(bool success)
    {
        uint amount = balances[msg.sender];
        balances[msg.sender] = 0;
        msg.sender.transfer(amount);
        return true;
    }

}