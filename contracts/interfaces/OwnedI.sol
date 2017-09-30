pragma solidity ^0.4.13;


contract OwnedI {

    event LogOwnerSet(address indexed previousOwner, address indexed newOwner);

    function setOwner(address newOwner) returns(bool success);

    function getOwner() constant returns(address owner);

}