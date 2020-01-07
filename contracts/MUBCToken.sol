pragma solidity >=0.4.0 < 0.7.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.4.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.4.0/contracts/token/ERC20/ERC20Detailed.sol";

contract Token is ERC20, ERC20Detailed {

    constructor () public
    ERC20Detailed("MUBCToken", "MUBC", 18) {
        _mint(msg.sender,10000 * (10 ** uint256(decimals())));
    }
}

contract Bossman {
    
    address owner = msg.sender;
    bool ifmember;
    mapping(address => bool) members;
    mapping(address => Bounty) bounties;

    modifier bountyDeclaration {
    require(msg.sender == owner || members[msg.sender] == true);
    _;
    }

function addMember(address _address) public bountyDeclaration {
    members[_address] = true;
}

function createBounty(bytes32 reward) public bountyDeclaration
        returns (Bounty bountyAddress)
    {
        // Create a new `Token` contract and return its address.
        // From the JavaScript side, the return type
        // of this function is `address`, as this is
        // the closest type available in the ABI.
        return new Bounty(reward);
    }
}
    

contract Bounty {

address bossman;
bytes32 reward;
bool completed;

constructor(bytes32 _reward) public {

        bossman = msg.sender;
        reward = _reward;
    }
    
function completeBounty() internal
{
    if(msg.sender != bossman)
    return;
    
    completed = true;
}
}
