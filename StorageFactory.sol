// SPDX Licence_Identifier : MIT

pragma solidity >=0.6.0 <0.9.0;

//to import SimpleStorage.sol

import "./SimpleStorage.sol";  //like copy of code in simplestorage here

contract StorageFactory is SimpleStorage{        //is: for inheritance (it will have all functions,array,mapping of SimpleStorage)

    //track of all different simplestorage contracts that we deployed
    SimpleStorage[] public simplestorageArray;
    //to deploy SimpleStorage contract
    function createSimpleStorageContract() public{
        SimpleStorage simplestorage=new SimpleStorage();
        simplestorageArray.push(simplestorage);
    }

    function sfStore(uint256 _simpleStorageIndex,uint256 _simpleStorageNumber) public {
        //for interacting with contracts we need 1.Address 2.ABI
        //ABI=Application Binary Interface
        SimpleStorage simplestorage = SimpleStorage(address(simplestorageArray[_simpleStorageIndex]));
        simplestorage.store(_simpleStorageNumber);
    }

    function sfRetrieve(uint256 _simpleStorageIndex) public view returns(uint256 _simpleStorageNumber) {
        SimpleStorage simplestorage = SimpleStorage(address(simplestorageArray[_simpleStorageIndex]));
        _simpleStorageNumber=simplestorage.retrieve();
        return _simpleStorageNumber;
    }
}