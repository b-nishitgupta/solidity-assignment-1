// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract Election {
    // Model a Candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }
    address user;
    constructor(){
        user = msg.sender;
    }
    
    mapping(address => bool) public voters;
    
    mapping(uint => Candidate) public candidates;
    
    uint public candidatesCount;

    
    event votedEvent (
        uint indexed _candidateId
    );

    function election (string memory _name) public {
       require(user==msg.sender, "we can not add you");
       addCandidate(_name);
    }

    function addCandidate (string memory _name) private {
        Candidate memory c = Candidate(candidatesCount,_name,0);
        candidates[candidatesCount] = c;
        candidatesCount++;
    }

    function vote (uint _candidateId) public {
        // require that they haven't voted before
        require(voters[msg.sender] == false, "You have already voted");

        

        // require a valid candidate
        require(_candidateId<candidatesCount,"Not a valid candidate");

        // record that voter has voted
        voters[msg.sender] = true;

        // update candidate vote Count
        candidates[_candidateId].voteCount = candidates[_candidateId].voteCount + 1;

        // trigger voted event
        emit votedEvent(_candidateId);
    }
}
