# Blockchain-Excercises Angaben

## Exercise 3: Ethereum Smart Contract
---
### E3 Part 1
---
Go to the online [IDE](https://remix.ethereum.org/), select "Injected Web3" and connect to your account selected in MetaMask.

Implement a voting smart contract that fulfills the following requirements:

* users must register before they can cast a vote
* registered users can only cast votes for other registered users
* registered users can only cast one vote and can not change it

The resulting smart contract should be derived from the following smart contract and implement the following specified functions:

```solidity
abstract contract Test {
    function register() public virtual;
    function voteFor(address) public virtual;
    function numberOfVotesReceivedFor(address) view public virtual returns(uint);
}
```

Attach the .sol file containing the source code of the smart contract, deploy the smart contract on the Goerli network and enter its address!

---
### E3 Part 2
---
Extend your smart contract to implement the following function too:

``` solidity
function winnersAndNumberOfWinningVotes() view public returns(address[] memory, uint);
```

Attach the .sol file containing the source code of the smart contract, deploy the smart contract on the Goerli network and enter its address!

## Exercise 4: Ethereum ERC20 Token
---
### E4 Part 1
---
Follow the instructions on [https://docs.openzeppelin.com/contracts/4.x/erc20](https://docs.openzeppelin.com/contracts/4.x/erc20) and implement your ERC20 token with an initial supply that results in **1000** units being minted.

Deploy the token in the Görli network and enter its address!

---
### E4 Part 2
---
Add your ERC20 token as asset to MetaMask and send 10.25 units to the Görli address **0x15433DA387451F9dE4565280C85506CB71aF9376**.

Enter the hash / id of the transaction!

---
### E4 Part 3
---
Rewrite your ERC20 token so that it requires accounts to be whitelisted by token holders to become valid recipients. The account receiving the initial supply should be whitelisted in the constructor.

Deploy your contract on the Görli network and transfer 10.25 units of your ERC20 token to the address f.

Enter the address of the ERC20 token contract and attach its source code file!
