// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

// 1. import openzeppelin
// 2. create an NFT smart contract
// 3. Token features
//      basic features
//          i. NFT Storage
//          ii. Nft counter
//          iii. Nft data staructure
//          iv. Mint to address
//          v. Change token owner

//      a. Freeze metadata
//      b. Update metadata if frozen
//      c. Own token,
//      d. Public mint
//      e. Mint token by wallet and id {wallet: [id1, id2]}
//      f. Mint Multiple tokens for one address
//      g. Mint multiple by batch {address: [token1, token2]}
//      h. Mint all tokens to the owner
//      i. Mint all tokens to the owner when creating a contract
//      j. Transferrable a token by the owner
//      k. burn/delete token {ids: [1, 2, 3]}
//      l. Burn all token
//      m. Royalty wallets, percentage - Opensea incompatible
//      n. Pay royalty on each transfer
//      o. Whitelist by token id
//      p. Whitelist for any token
//      q. Remove from whitelist

//implement 1. import openzeppelin
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

//implement 2. create an NFT smart contract
contract NFT is ERC721, Ownable, ERC721URIStorage {
    uint256 public mintPrice = 0.001 ether;
    uint256 public totalSupply;
    uint256 public maxSupply;
    bool public isMintEnabled;
    mapping(address => uint256) public mintedWallets;

    constructor() payable ERC721("SMAX", "SMX") {
        maxSupply = 1000;
    }

    function toggleIsMintEnabled() external onlyOwner {
        isMintEnabled = !isMintEnabled;
    }
}
