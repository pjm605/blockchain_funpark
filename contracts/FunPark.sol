pragma solidity ^0.4.13;

import "./interfaces/FunParkI.sol";
import "./Owned.sol";
import "./Pausable.sol";
import "./AttractionHolder.sol";
import "./FunParkToken.sol";


contract FunPark is FunParkI, Owned, Pausable, AttractionHolder {
    
    mapping (address => uint256) public registeredCustomers;
    address[] private registeredCustomersIndex;
    
    mapping (address => uint) balances;
    
    FunParkToken token;
    
    function FunPark () 
        Pausable(false)
    {
        token = new FunParkToken();
        
    }
    
    function registerCustomer (address customer) 
        public
        fromOwner
        returns (bool success)
    {
        require(customer != address(0));
        require(isRegisteredCustomer(customer) == false);
        registeredCustomers[customer] = registeredCustomersIndex.push(customer) - 1;
        
        LogRegisterCustomer(customer);
        return true;
    }
    
    function removeCustomer (address customer) 
        public
        fromOwner
        returns (bool success)
    {
        require(customer != address(0));
        require(isRegisteredCustomer(customer) == true);
        
        uint targetCustomerIndex = registeredCustomers[customer];
        address customerToMove = registeredCustomersIndex[registeredCustomersIndex.length - 1];
        registeredCustomersIndex[targetCustomerIndex] = customerToMove;
        registeredCustomers[customerToMove] = targetCustomerIndex;
        registeredCustomersIndex.length--;
        
        LogRemoveCustomer(customer);
        return true;
    }
    
    function isRegisteredCustomer (address customer)
        constant
        public
        returns (bool isRegistered)
    {
        if (registeredCustomersIndex.length == 0) {
            return false;
        } 
        
        return (registeredCustomersIndex[registeredCustomers[customer]] == customer);
    }
    
    function customerDeposit ()
        public
        payable
        returns (bool success)
    {
        require(isRegisteredCustomer(msg.sender) == true);
        require(msg.value > 0);
        
        balances[msg.sender] += msg.value;
        
        LogCustomerDeposit(msg.sender, msg.value);
        return true;
    }
    
    function enterAttraction (address attraction)
        public
        payable
        returns (bool success)
    {
        require(isAttraction(attraction) == true);
        require(isPaused() == false);
        require(attraction != address(0));
        require(isRegisteredCustomer(msg.sender) == true);
        
        uint attractionFee = getAttractionFee(attraction);
        require (balances[msg.sender] >= attractionFee);
        
        balances[msg.sender] -= attractionFee;
        balances[owner] += attractionFee;
        
        LogAttractionEntered(attraction, msg.sender, attractionFee);
        return true;
    }
    
    function enterAttractionWithToken (address attraction)
        public
        returns (bool success)
    {
        require(isAttraction(attraction) == true);
        require(isPaused() == false);
        require(attraction != address(0));
        require(isRegisteredCustomer(msg.sender) == true);

        uint attractionFeeInTokens = getAttractionFeeInTokens(attraction);
        uint tokenBalance = token.balanceOf(msg.sender);
        
        require(attractionFeeInTokens <= tokenBalance);
        if (token.transferFrom(this, msg.sender, attractionFeeInTokens) == false) {
            revert();
        }        
        
        return true;
    }
    
    function getCollectedFeesAmount () 
        constant
        public
        returns(uint amount)
    {
        return balances[owner];
    }
    
    function withdrawBalances() 
        public
        payable
        returns(bool success)
    {
        uint amount = balances[msg.sender];
        balances[msg.sender] = 0;
        msg.sender.transfer(amount);
        
        LogWithdrawBalances(msg.sender, amount);
        return true;
    }

}