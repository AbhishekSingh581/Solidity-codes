pragma solidity >=0.6.0 <0.9.0;

import "./Fundme.sol";

contract HospitalFund{
    
    struct doctors{
        string name;
        uint256 fund;
    }
    mapping(address=>uint256) public addressToint;
    mapping(string=>uint256) public stringTouint;
    doctors[] public docs;

    function funding() public payable{
        addressToint[msg.sender]+=msg.value;
    }

    function addDoctors(string memory _name,uint256 _fund) public{
        docs.push(doctors({name:_name,fund:_fund}));
        stringTouint[_name]=_fund;
    }

    // function retrieve() public view returns(uint256){
    //     return(stringTouint[])
    // }
    
        Fundme public f=new Fundme();
        
    function getPrice() public view returns(uint256){
         uint256 y=f.getPrice();
        return y;
    }
}