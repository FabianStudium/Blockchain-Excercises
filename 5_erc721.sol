// contracts/FabianNFT.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract TratesNFT is ERC721URIStorage, Ownable {

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("Character Trate NFTs", "CTNFT") {}

    function totalSupply() public view returns (uint256) {
        return _tokenIds.current();
    }

    function awardItem(address character, string memory tokenURI)
        public onlyOwner returns (uint256) {

        // @dev check if _tokenIds == 1234 and increment beforehand

        uint256 newItemId = _tokenIds.current();
        _mint(character, newItemId);
        _setTokenURI(newItemId, tokenURI);

        _tokenIds.increment();
        return newItemId;
    }

    function mintItem1234(address minter, string memory tokenURI)
        public onlyOwner returns (uint256) {

        uint256 itemId = 1234;
        _mint(minter, itemId);
        _setTokenURI(itemId, tokenURI);
        return itemId;
    }
}
