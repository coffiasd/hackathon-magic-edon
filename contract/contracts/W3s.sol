// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

/// @custom:security-contact coiiasd88@gmail.com
contract W3s is ERC721, ERC721URIStorage, Pausable, Ownable {
    uint256 public _publicMintPrice;
    // Mapping owner address to tokenID
    mapping(address => uint256) private ownerToTokenID;

    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("w3s", "w3s") {
        _publicMintPrice = 0.01 ether;
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function getMataDataFromCid(
        string memory cid,
        string memory config,
        uint256 tokenID
    ) internal pure returns (string memory) {
        string memory image = string(
            abi.encodePacked("https://", cid, ".ipfs.w3s.link/avatar.png")
        );

        return
            string(
                abi.encodePacked(
                    '{"name": "w3s#',
                    Strings.toString(tokenID),
                    '","description": "A nft hackathon project from ayden lee",',
                    '"image":"',
                    image,
                    '",'
                    '"attributes":',
                    config,
                    "}"
                )
            );
    }

    function publicMint(string memory cid, string memory config)
        public
        payable
    {
        //check mint price
        require(msg.value >= _publicMintPrice, "don't have enough token");

        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(msg.sender, tokenId);
        //get metadata
        string memory tempTokenURI = getMataDataFromCid(cid, config, tokenId);
        //set token URI
        _setTokenURI(tokenId, tempTokenURI);
        //set owner of token ID
        ownerToTokenID[msg.sender] = tokenId;
    }

    function getTokenURI() public view returns (uint256) {
        //require not claimed
        require(ownerToTokenID[msg.sender] >= 0, "You not already claimed!");
        return ownerToTokenID[msg.sender];
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override whenNotPaused {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId)
        internal
        override(ERC721, ERC721URIStorage)
    {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        // return super.tokenURI(tokenId);
        string memory json = Base64.encode(
            bytes(string(abi.encodePacked(super.tokenURI(tokenId))))
        );
        return string(abi.encodePacked("data:application/json;base64,", json));
    }
}
