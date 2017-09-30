pragma solidity ^0.4.13;


contract PausableI {
    
    event LogPausedSet(address indexed sender, bool indexed newPausedState);

    function setPaused(bool newState) returns(bool success);

    function isPaused() constant returns(bool isIndeed);

}