// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Voting {
    address owner;
    uint256 deadline;
    uint256 deployDate;
    struct Candidates {
        string candidateName;
        address candidateAccountAddress;
        uint256 candidateAge;
    }
    Candidates[] public registeredCandidates;
    mapping(address => Candidates) public verifiedCandidates;
    mapping(address => uint256) public votes;
    address[] public verifiedAccounts;

    constructor() {
        owner = msg.sender;
        deployDate = block.timestamp;
    }

    modifier checkAge(uint256 _candidateAge) {
        require(_candidateAge > 18, "You are under age");
        _;
    }

    event candidateRegistered(
        string _candidateName,
        address _candidateAccountAddress,
        uint256 _candidateAge
    );

    function registerCandidates(
        string memory _candidateName,
        uint256 _candidateAge
    ) public checkAge(_candidateAge) {
        require(
            block.timestamp < deployDate + 7 days,
            "Registration time has ended"
        );
        Candidates storage newCandidate = registeredCandidates.push();
        newCandidate.candidateName = _candidateName;
        newCandidate.candidateAccountAddress = msg.sender;
        newCandidate.candidateAge = _candidateAge;
        emit candidateRegistered(_candidateName, msg.sender, _candidateAge);
    }

    function addVerifiedCandidate(
        string memory _candidateName,
        uint256 _candidateAge,
        address _candidateAccountAddress
    ) public {
        verifiedCandidates[_candidateAccountAddress]
            .candidateName = _candidateName;
        verifiedCandidates[_candidateAccountAddress]
            .candidateAccountAddress = _candidateAccountAddress;
        verifiedCandidates[_candidateAccountAddress]
            .candidateAge = _candidateAge;
        verifiedAccounts.push(_candidateAccountAddress);
    }

    function getAllRegisteredCandidates()
        public
        view
        returns (Candidates[] memory)
    {
        return registeredCandidates;
    }

    //Return addresses of verified candidates and then we will have to use verifiedCandidates mappings to see other details
    function getAllVerifiedAddresses() public view returns (address[] memory) {
        return verifiedAccounts;
    }

    function giveVote(address _candidateAccountAddress) public {
        require(
            block.timestamp > deployDate + 15 days,
            "Voting period has not started"
        );
        votes[_candidateAccountAddress]++;
    }
}
