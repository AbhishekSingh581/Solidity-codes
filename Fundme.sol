pragma solidity >=0.6.0 <0.9.0;

//import chainlink price 


// SPDX-License-Identifier: MIT

//import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
//or
interface AggregatorV3Interface {
  function decimals() external view returns (uint8);

  function description() external view returns (string memory);

  function version() external view returns (uint256);

  // getRoundData and latestRoundData should both raise "No data present"
  // if they do not have data to report, instead of returning unset values
  // which could be misinterpreted as actual reported values.
  function getRoundData(uint80 _roundId)
    external
    view
    returns (
      uint80 roundId,
      int256 answer,
      uint256 startedAt,
      uint256 updatedAt,
      uint80 answeredInRound
    );

  function latestRoundData()
    external
    view
    returns (
      uint80 roundId,
      int256 answer,
      uint256 startedAt,
      uint256 updatedAt,
      uint80 answeredInRound
    );
}

// import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol";

contract Fundme{
    //using A for B:
    // using will attach library of A to B
    // using SafeMathChainlink for uint256;    //it will not allow to overflow , if you want to learn more about overflow go to Overflow.sol

    mapping(address=>uint256) public addressToAmountFunded;

    address public owner;
    //constructor
    constructor() public{
      owner=msg.sender;
    }

    function fund() public payable{

        //we want to make threshold i.e $50
        uint256 minUSD=50*10*18;
        require(getConversionRate(msg.value)>=minUSD,"You need to spend more eth");
        addressToAmountFunded[msg.sender] +=msg.value;
        //msg.sender : function call by the sender
        //msg.value: how much they funded

        // What is ETH to USD conversion rate
        //Oracle is deteministic system which connect to real world
        

    }


    //modifier:
    // A modifier is used to change the behaviour of a function in a declarative way.
    // modifier onlyOwner{
    //   require(msg.sender==owner);
    //   _;
    // }

    // function withdraw() payable onlyOwner public{
    //   //we dont want whole balence
    //   // but we need a constructor for whenever this contract deploy we get 
    //   //require msg.sender =owner
    //   //we made constructor above
    //   // require(msg.sender==owner);

    //   msg.sender.transfer(address(this).balance);   //this: refer to contract currently in  here address(this)  contract address
      


    // }

    function getVersion() public view returns(uint256){
        // AggregatorV3Interface is a type just like struct etc.

        //address of where the contract is located (Finding Price Feed Address) etherum price feed chainlink documentation
        //Go to Rinkbey
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        //the above line says we have a smart contract AggregatorV3Interface located in 0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
        return priceFeed.version();

    }

    function getPrice() public view returns(uint256){
        AggregatorV3Interface priceFeed=AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        )=priceFeed.latestRoundData();
        return uint256(answer *10000000000);
        //2038.16222739
    }


    //converting 1GWei = 1000000000 wei
    function getConversionRate(uint256 ethAmount) public view returns(uint256){     //ethAmount in wei
      uint256 ethPrice=getPrice();
      uint256 ethInUSD=(ethPrice*ethAmount)/1000000000000000000;
      return ethInUSD;
      //2029293583600 => 0.000002029293583600 1GweiInUSD
    }
}

// We have to deploy this smart contract on test net because the address we used is at actual network