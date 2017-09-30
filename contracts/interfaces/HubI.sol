pragma solidity ^0.4.13;
import "./FunParkI.sol";


contract HubI {

    event LogFunParkCreated(
        address indexed sender,
        address indexed newFunPark,
        address indexed newFunParkOwner);

    function createNewFunPark (address owner)
        public
        returns(FunParkI newFunPark);

    event LogFunParkRemoved(
        address indexed sender,
        address indexed funPark);

    function removeFunPark(address funPark)
        public
        returns(bool success);

    function isFunPark (address funPark)
        constant
        public
        returns(bool indeed);
     
}