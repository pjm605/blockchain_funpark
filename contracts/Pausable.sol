pragma solidity ^0.4.13;

import "./Owned.sol";


contract Pausable is Owned {
    bool public paused;
    
    modifier whenPaused {
        require(paused == true);
        _;
    }
    
    modifier whenNotPaused {
        require(paused == false);
        _;
    }
    
    function Pausable (bool _isPaused) {
        paused = _isPaused;
    }
    
    function setPaused (bool newState) 
        fromOwner
        returns (bool success)
    {
        require(paused != newState);
        paused = newState;
        return true;
    }
    
    function isPaused ()
        constant
        returns (bool)
    {
        return paused;
    }
}