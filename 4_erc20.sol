// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract PlatinTokenPrivate is ERC20 
{
    /*
    @dev rewrite to mapping ... works fine with an array but "looks" better with a map
    */
    address[] whitelisted; // array of "whitelisted" recipients, can only be added to by accounts holding PLT

    constructor() ERC20("PlatinPrivate", "PLTP") 
    {
        uint supply = 1000000000000000000000; // total supply 1000 units with 18 dezimals (000000000000000000)
        
        // set total supply of tokens to $supply
        _mint(msg.sender, supply);
        
        // whitelist contract creator
        whitelisted.push(msg.sender);
    }

    function whitelist(address recipient) public
    {
        /*
         * @error: msg.sender == recipient ... und nicht die addresse, die die Funk tatsaechlich ausfuehrt
         */
        require(balanceOf(msg.sender) > 0, "Only token holders can whitelist recipients.");
        
        /*
        @dev check if address is right format: 20 byte hex
        */

        bool alreadyWhitelisted = false;

        for(uint i = whitelisted.length; i > 0; i--)
        {
            if(whitelisted[i-1] == recipient)
            {
                alreadyWhitelisted = true;
            }
        }

        require(!alreadyWhitelisted, "Address already whitelisted.")

        if(!alreadyWhitelisted)
        {
            whitelisted.push(recipient);
        }
    }

    function transfer(address to, uint256 amount) public virtual override returns (bool) 
    {    
        /*
        @dev "vulnerability" bc only the address of a token holder is currently needed. Token holder does not need to execute the function
        ... how do i find out who executes the function? According to debugger: msg.sender == to 
        */
        require(addressIsWhitelisted(to), "Recipient must be validated by token holder before receicing tokens.");

        address owner = _msgSender();
        _transfer(owner, to, amount);
        return true;
    } 

    function transferFrom(address from, address to, uint256 amount) public virtual override returns (bool) 
    {    
        require(addressIsWhitelisted(to), "Recipient must be validated by token holder before receicing tokens.");
        
        address spender = _msgSender();
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount);
        return true;
    }

    function addressIsWhitelisted(address to) private view returns (bool)
    {
        bool toIsWhitelisted = false;
        
        for(uint i = whitelisted.length; i > 0; i--)
        {
            if(whitelisted[i-1] == to)
            {
                toIsWhitelisted = true;
            }
        }

        return toIsWhitelisted;
    }
}
