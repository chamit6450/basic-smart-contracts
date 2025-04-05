// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting{
 struct Candidate {
        string name;
        uint voteCount;
    }

 Candidate[] public candidates;
 uint public startTime;
 address owner;
 mapping (address => bool) public votes;

 constructor(uint _startDelay){
    startTime = block.timestamp + _startDelay;
    owner = msg.sender;
 }

 modifier onlyOwner(){
    require(msg.sender == owner,"only owner");
    _;
 }


 function addCandidates(string[] memory names) public onlyOwner {
    require(block.timestamp < startTime, "Election already started");

    for (uint i = 0; i < names.length; i++) {
        candidates.push(Candidate(names[i], 0));
    }
}


 function vote(uint8 candidateId) public returns (string memory){
    if (block.timestamp < startTime ){
        revert("Election has not started yet");
    }

    if(votes[msg.sender] == true ){
        revert("Already Voted");
    }else{
     candidates[candidateId].voteCount++;
     votes[msg.sender] = true;

     return "Vote Casted successfully";
    }
 }

 function getWinner() public view onlyOwner returns(string memory,uint){
         uint max = 0;
         string memory winner;
         for (uint i = 0; i < candidates.length; i++) {
           if (candidates[i].voteCount > max) {
            max = candidates[i].voteCount;
            winner = candidates[i].name;
           }
    }
         return (winner,max);
   }
  
}