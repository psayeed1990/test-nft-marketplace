// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

//@params from to create contract
//* name, symbol, maxsupply, tokenURI

//! @ ERC721 Non-Fungible Token Standard, v1.0
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
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Pausable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Royalty.sol";

//implement 2. create an NFT smart contract
contract NFT is ERC721URIStorage, Ownable {
    uint256 public mintPrice = 0.001 ether;
    uint256 public totalSupply;
    uint256 public maxSupply;
    bool public isMintEnabled;
    bool public isWhitelistEnabled;
    bool public isFrozen;
    bool public isPaused;
    mapping(address => uint256) public mintedWallets;

    struct tokenMetaData {
        uint256 tokenId;
        uint256 timeStamp;
        string tokenURI;
    }

    constructor() payable ERC721("SMAX", "SMX") {
        maxSupply = 1000;
    }

    //? Only Owner implement toggle mint enable or disable
    function toggleIsMintEnabled() external onlyOwner {
        isMintEnabled = !isMintEnabled;
    }

    //? Only Owner  set max supply
    function setMaxSupply(uint256 _maxSupply) external onlyOwner {
        maxSupply = _maxSupply;
    }

    //? Only Owner  set mint price
    function setMintPrice(uint256 _mintPrice) external onlyOwner {
        mintPrice = _mintPrice;
    }

    //* mint token to address
    function mint(address _to, uint256 _tokenId) external {
        require(isMintEnabled, "Minting not enabled");
        require(!isFrozen, "Token is frozen");
        require(!isPaused, "Token is paused");
        require(mintedWallets[msg.sender] >= mintPrice, "Not enough balance");
        //! uncomment this if each wallet can't mint more than 1 token
        // require(totalSupply < 1, "Each waller can mint only one");
        require(balanceOf(msg.sender) >= mintPrice, "Not enough balance");

        mintedWallets[msg.sender]++;
        totalSupply++;
        // uint256 tokenId = totalSupply;
        _safeMint(_to, _tokenId);
    }
}
