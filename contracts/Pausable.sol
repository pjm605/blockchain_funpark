pragma solidity ^0.4.13;

import "./interfaces/PausableI.sol";
import "./Owned.sol";


contract Pausable is PausableI, Owned {
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
        LogPausedSet(msg.sender, paused);
        return true;
    }
    
    function isPaused ()
        constant
        returns (bool)
    {
        return paused;
    }
}