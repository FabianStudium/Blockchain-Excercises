// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

abstract contract IVoting {
    function register() public virtual;

    function voteFor(address) public virtual;

    function numberOfVotesReceivedFor(address)
        public
        view
        virtual
        returns (uint256);

    function winnersAndNumberOfWinningVotes()
        public
        view
        virtual
        returns (address[] memory, uint256);
}

/**
 * @title Voting
 * @dev Implements voting process
 */

contract Voting is IVoting {
    struct Voter {
        bool _voted; // if true, that person already voted
        // bytes32 _name; // short name (up to 32 bytes) ... zb 0x1000000000000000000000000000000000000000000000000000000000000000
        bool _registered; // if false, that person is not registered
        uint256 _voteCount; // number of accumulated votes
        address _votedFor; // index of the voted candidate
        address _address; // Holds a 20 byte value (size of an Ethereum address)
    }

    struct Winners {
        uint256 _highestVote;
        address[] _addresses; // doesn't allow memory?
    }

    Winners _winners;
    mapping(address => Voter) voters;

    /*
     * List if Candidate (addresses) get initialised and registered.
     */
    constructor(
        // bytes32[] memory _candidateNames,
        address[] memory _candidateAdresses
    ) {
        for (uint256 i = 0; i < _candidateAdresses.length; i++) {
            voters[_candidateAdresses[i]]._voted = false;
            voters[_candidateAdresses[i]]._registered = true;
            voters[_candidateAdresses[i]]._voteCount = 0;
            voters[_candidateAdresses[i]]._votedFor = address(
                0x0000000000000000000000000000000000000000 // null address bc not voted yet
            );
            voters[_candidateAdresses[i]]._address = _candidateAdresses[i];
        }
    }

    /*
     * Function to register a new user. User then can vote or receive votes from other users.
     */
    function register() public override { // should be with address ad param to prevent code duplication
        require(!voters[msg.sender]._registered, "Already registered.");

        voters[msg.sender]._voted = false;
        voters[msg.sender]._registered = true;
        voters[msg.sender]._voteCount = 0;
        voters[msg.sender]._votedFor = address(
            0x0000000000000000000000000000000000000000 // null address bc not voted yet
        );
        voters[msg.sender]._address = msg.sender;
    }

    /*
     * Function to vote for another candidate.
     */
    function voteFor(address _candidate) public override {
        /*
         * errorhandling
         */
        require(
            voters[msg.sender]._registered,
            "The voter has not registered as voter yet."
        );
        require(
            !voters[msg.sender]._voted, 
            "Voter already voted."
        );
        require(
            voters[msg.sender]._address != _candidate,
            "Voter can't vote for him/herself"
        );
        require(
            voters[_candidate]._registered,
            "Candidate doesn't exist yet. Needs to be registered first."
        );

        voters[msg.sender]._votedFor = _candidate; // safe voters choice
        voters[_candidate]._voteCount++; // add vote
        voters[msg.sender]._voted = true;

        calculateWinners(_candidate); // calculate winner(s)
    }

    /*
     * Function
     */
    function numberOfVotesReceivedFor(address _candidate)
        public
        view
        override
        returns (uint256)
    {
        require(
            voters[msg.sender]._registered,
            "Person has not registered as voter yet."
        );

        require(
            voters[_candidate]._registered,
            "Candidate doesn't exist yet. Needs to be registered first."
        );

        return voters[_candidate]._voteCount;
    }

    function winnersAndNumberOfWinningVotes()
        public
        view
        override
        returns (address[] memory, uint256)
    {
        require(
            _winners._highestVote > 0, 
            "No votes have taken place yet."
        );
        require(
            voters[msg.sender]._voted,
            "You first have to vote before seeing the results."
        );

        return (_winners._addresses, _winners._highestVote);
    }

    function calculateWinners(address _candidate) private {
        if (voters[_candidate]._voteCount > _winners._highestVote) {
            _winners._highestVote = voters[_candidate]._voteCount;
            _winners._addresses.push(voters[_candidate]._address);
        } else if (voters[_candidate]._voteCount == _winners._highestVote) {
            _winners._addresses.push(voters[_candidate]._address);
        }
    }
}
