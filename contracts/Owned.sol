pragma solidity ^0.4.13;


contract Owned {
	address owner;
	
	modifier fromOwner {
		require(msg.sender == owner);
		_;
	}

	function Owned() {
		owner = msg.sender;
	}

	function setOwner(address newOwner)
		fromOwner
		returns(bool success)
	{
		require(newOwner != address(0));
		require(owner != newOwner);
		address previousOwner = owner;
		owner = newOwner;
	
		return true;
	}

	function getOwner()
		constant
		returns(address)
	{
		return owner;
	}
}