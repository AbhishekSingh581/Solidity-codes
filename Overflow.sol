pragma solidity >=0.6.0 <0.9.0;

contract Overflow{
    function f() public view returns(uint8){
        uint8 x=255;  //maximum value
        return x+2;
    }
}