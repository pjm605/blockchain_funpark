pragma solidity ^0.4.13;

import "./interfaces/ERC20TokenI.sol";
import "./Owned.sol";
import "./SafeMath.sol";

contract FunParkToken is ERC20TokenI, Owned
{
	using SafeMath for uint;
	// symbol and name
	string public constant symbol = "FunParkToken";
	string public constant name = "FunPark Token Example";

	// initial number of tokens
	uint public totalTokens = 1000000;

	// address to balance mapping
	mapping(address => uint) balances;

	// allow others to transfer from another's account'
	mapping(address => mapping(address => uint)) allowed;
	
	function FunParkToken()
	{
		balances[msg.sender] = totalTokens;
	}

	// ERC20TokenI functions
	function totalSupply()
		public
		constant
		returns (uint total)
	{
		total = totalTokens;
	}

	function balanceOf(address _owner)
		public
		constant
		returns (uint balance)
	{
		balance = balances[_owner];
	}

	function transfer(address _to, uint _value)
		public
		returns (bool success)
	{
		require(_to != address(0));
		require(_value > 0);
		require(balances[msg.sender] >= _value);

		balances[msg.sender] = balances[msg.sender].sub(_value);
		balances[_to] = balances[_to].add(_value);
		Transfer(msg.sender, _to, _value);
		return true;
	}

	function transferFrom(address _from, address _to, uint _value)
		public
		returns (bool success)
	{
		require(_from != address(0));
		require(_to != address(0));
		require(_value > 0);

		require(allowance(_from, _to) >= _value);
		require(balances[_from] >= _value);

		allowed[_from][_to] = allowed[_from][_to].sub(_value);
		balances[_from] = balances[_from].sub(_value);
		balances[_to] = balances[_to].add(_value);
		Transfer(_from, _to, _value);

		return true;
	}


	function approve(address _spender, uint _value)
		public
		returns (bool success)
	{
		allowed[msg.sender][_spender] = _value;
		return true;
	}

	function allowance(address _owner, address _spender)
		constant
		returns (uint remaining)
	{
		remaining = allowed[_owner][_spender];
	}


}