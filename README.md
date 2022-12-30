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

Deploy the smart contract on the Goerli network!

---
### E3 Part 2
---
Extend your smart contract to implement the following function too:

``` solidity
function winnersAndNumberOfWinningVotes() view public returns(address[] memory, uint);
```

Deploy the smart contract on the Goerli network!

## Exercise 4: Ethereum ERC20 Token
---
### E4 Part 1
---
Follow the instructions on [https://docs.openzeppelin.com/contracts/4.x/erc20](https://docs.openzeppelin.com/contracts/4.x/erc20) and implement your ERC20 token with an initial supply that results in **1000** units being minted.

Deploy the token in the Görli network!

---
### E4 Part 2
---
Add your ERC20 token as asset to MetaMask and send 10.25 units to the Görli address **0x15433DA387451F9dE4565280C85506CB71aF9376**.

---
### E4 Part 3
---
Rewrite your ERC20 token so that it requires accounts to be whitelisted by token holders to become valid recipients. The account receiving the initial supply should be whitelisted in the constructor.

Deploy your contract on the Görli network and transfer 10.25 units of your ERC20 token to the address f.

## Exercise 5: Ethereum ERC712 NFT
---
### E5 Part 1
---
Follow the instructions on [https://docs.openzeppelin.com/contracts/4.x/erc721](https://docs.openzeppelin.com/contracts/4.x/erc721) and implement your ERC721 token. Make the contract Ownable and let only the owner mint NFTs and set the URI.

Deploy the token in the Görli network and enter its address!
As the contract owner, mint an NFT with the tokenId 1234 to yourself. 

---
### E5 Part 2
---
Create a JSON metadata file for the minted NFT and host it online.

You can host it wherever you want. [Github pages](https://pages.github.com/) is a free option. If you are already familiar with IPFS, your can use it too.

As the contract owner, set the URI of the ERC721 contract to point to the location where you host the JSON file. 

Enter the content of the JSON file of the NFT with the tokenId 1234!

---
### E5 Part 3
---
Add your ERC721 token to MetaMask and send your NFT with the tokenId 1234 to the Görli address **0x15433DA387451F9dE4565280C85506CB71aF9376**.
