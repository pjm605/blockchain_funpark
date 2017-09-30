pragma solidity ^0.4.13;


contract AttractionHolderI {

    event LogAttractionAdded(
        address indexed sender,
        address indexed attraction,
        uint attractionFee);

    function addNewAttraction (address attraction, uint _fee)
        public
        returns (address newAttraction);
        
    event LogAttractionFeeUpdate(
        address indexed sender,
        address indexed attraction,
        uint attractionFee);
        
    function updateAttractionFee (address attraction, uint newFee)
        public
        returns (bool success);
        
    function getAttractionFee (address attraction)
        constant
        public
        returns (uint attractionFee);

    function isAttraction (address attraction)
        constant
        public
        returns (bool isIndeed);

    event LogAttractionRemoved (
        address indexed sender,
        address indexed attraction);

    function removeAttraction (address attraction)
        public
        returns (bool success);
     
}