pragma solidity ^0.4.13;


contract FunParkI {

    event LogRegisterCustomer(
        address indexed customer);

    function registerCustomer (address customer)
        public
        returns (bool success);
        
    event LogRemoveCustomer(
        address indexed customer);
        
        
    function removeCustomer (address customer)
        public
        returns (bool success);

    event LogCustomerDeposit(
        address indexed customer,
        uint amount);

    function customerDeposit ()
        public
        payable
        returns (bool success);
    
    event LogAttractionEntered (
        address indexed attraction,
        address indexed customer, 
        uint attractionFee);
        
    function enterAttraction (address attraction)
        public
        payable
        returns (bool success);
        
    function enterAttractionWithToken (address attraction)
        public
        returns (bool success);
        
    function getCollectedFeesAmount ()
        constant
        public
        returns(uint amount);
    
    event LogWithdrawBalances (
        address indexed receiver,
        uint amount);
        
    function withdrawBalances ()
        public
        payable
        returns(bool success);
}