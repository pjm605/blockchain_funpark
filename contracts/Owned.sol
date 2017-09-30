pragma solidity ^0.4.13;
import "./interfaces/OwnedI.sol";


contract Owned is OwnedI {
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
		
		LogOwnerSet(previousOwner, owner);

		return true;
	}

	function getOwner()
		constant
		returns(address)
	{
		return owner;
	}
}