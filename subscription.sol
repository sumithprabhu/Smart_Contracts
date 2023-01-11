// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract Subscription {
    address public owner;
    mapping(address=> uint256) WhiteListed;
    mapping(address=> uint256) amount;
    mapping(uint256=> address) addressindex;
    
    uint256 public subscriptionCount=1;

    constructor(){
        owner = msg.sender;
        WhiteListed[owner]=1;
        addressindex[0]=owner;
        amount[owner]=0;  
    }

    // A function to add subscription
    function add_subscription(address add1) public payable{
        require(WhiteListed[add1]==0,"Subscription already present");
        bool sent = deposit();
        require(sent, "Failed to send Ether");
        WhiteListed[add1]=1;
        uint256 amount1= (msg.value)/subscriptionCount;
        for(uint8 i=0; i<= subscriptionCount; i++){
            uint256 initamount=amount[addressindex[i]];
            amount[addressindex[i]]=initamount+amount1; 
        }
        addressindex[subscriptionCount]=add1;
        amount[add1]=0;
        subscriptionCount++;
    }

    // A function to show outstanding amount
    function showAmount() public view returns(uint256){
        return amount[msg.sender];
    }

    // A function to withdraw outstanding amount
    function Withdraw() public payable{
        payable(msg.sender).transfer(amount[msg.sender]);
        amount[msg.sender]=0; 
    }

    // A function to accept subscription fees
    function deposit() payable public returns(bool){
        require(msg.value >= 1 ether,"Value is less than 1 ether");
        return true;   
    }
}