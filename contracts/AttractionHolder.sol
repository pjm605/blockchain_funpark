pragma solidity ^0.4.13;
import "./interfaces/AttractionHolderI.sol";
import "./Owned.sol";


contract AttractionHolder is AttractionHolderI, Owned {
    
    struct AttractionStruct {
        uint fee;
        uint feeInTokens;
        uint index;
    }
    
    mapping (address => AttractionStruct) attractions;
    address[] private attractionsIndex;
     
    function addNewAttraction (address attraction, uint _fee, uint _feeInTokens) 
        public
        fromOwner
        returns (address newAttraction)
    {
        require(attraction != address(0));
        require(_fee != 0);
        require(isAttraction(attraction) == false);
        attractions[attraction].fee = _fee;
        attractions[attraction].feeInTokens = _feeInTokens;
        attractions[attraction].index = attractionsIndex.push(attraction)-1;
        
        LogAttractionAdded(msg.sender, attraction, _fee);
        return attraction;
    }
    
    function updateAttractionFee (address attraction, uint newFee) 
        public
        fromOwner
        returns (bool success)
    {
        require(isAttraction(attraction) == true);
        require(newFee != 0);
        attractions[attraction].fee = newFee;
        
        LogAttractionFeeUpdate(msg.sender, attraction, newFee);
        return true;
    }
    
    function getAttractionFee (address attraction) 
        constant
        public
        returns(uint attractionFee)
    {
        require(isAttraction(attraction) == true);
        return attractions[attraction].fee;
    }
    
    function getAttractionFeeInTokens (address attraction) 
        constant
        public
        returns(uint attractionFeeInTokens)
    {
        require(isAttraction(attraction) == true);
        return attractions[attraction].feeInTokens;
    }
    
    function isAttraction (address attraction)
        constant
        public
        returns (bool isIndeed)
    {
        if (attractionsIndex.length == 0) {
            return false;
        }
        
        return (attractionsIndex[attractions[attraction].index] == attraction);
    }
    
    function removeAttraction (address attraction) 
        public
        fromOwner
        returns(bool success)
    {
        require(attraction != address(0));
        require(isAttraction(attraction) == true); 
        
        uint targetAttractionIndex = attractions[attraction].index;
        address attractionToMove = attractionsIndex[attractionsIndex.length - 1];
        
        attractionsIndex[targetAttractionIndex] = attractionToMove;
        attractions[attractionToMove].index = targetAttractionIndex;
        attractionsIndex.length --;
        
        LogAttractionRemoved(msg.sender, attraction);
        return true;
    }
}