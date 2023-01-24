// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

contract Payable{

address payable public owner;
constructor () {
// owner address should be payable
    owner = payable(msg.sender);
}
// All ether are deposit in msg.sender Address.
function deposit() external payable{}
// check the balance of msg.sender address
function getBalance() external view returns(uint){
    return address(this).balance;
}
}

