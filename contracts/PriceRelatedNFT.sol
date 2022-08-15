// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import '@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol';
import '@openzeppelin/contracts/access/Ownable.sol';
import '../interfaces/IERC721NFTMarketV1.sol';

contract PriceRelatedNFT is ERC721Enumerable, Ownable {
    uint256 public priceLimit;
    uint256 private s_tokenCounter;
    uint256 public maxMintAmount;
    uint256 public maxSupply;
    uint256 public cost;
    bool public paused = false;
    string public constant TOKEN_URI =
        'ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json';
    address private ERC721NFTMarketV1addr =
        0x17539cCa21C7933Df5c980172d22659B8C345C5A;

    modifier priceLevel(uint256 tokenId) {
        IERC721NFTMarketV1 nftMarket = IERC721NFTMarketV1(
            ERC721NFTMarketV1addr
        );
        uint256[] memory tokenIds = new uint256[](1);
        tokenIds[0] = tokenId;
        AskLib.Ask[] memory askInfo = new AskLib.Ask[](1);
        (, askInfo) = nftMarket.viewAsksByCollectionAndTokenIds(
            address(this),
            tokenIds
        );
        require(askInfo[0].price > priceLimit);
        _;
    }

    constructor(
        uint256 _priceLimit,
        uint256 _maxMintAmount,
        uint256 _maxSupply,
        uint256 _cost
    ) ERC721('Dogie', 'DOG') {
        s_tokenCounter = 0;
        priceLimit = _priceLimit;
        maxMintAmount = _maxMintAmount;
        maxSupply = _maxSupply;
        cost = _cost;
    }

    function mintNFT(uint256 _mintAmount) public payable returns (uint256) {
        require(!paused);
        require(_mintAmount > 0);
        require(_mintAmount <= maxMintAmount);
        require(s_tokenCounter + _mintAmount <= maxSupply);

        if (msg.sender != owner()) {
            require(msg.value >= cost * _mintAmount);
        }

        for (uint256 i = 1; i <= _mintAmount; i++) {
            _safeMint(msg.sender, s_tokenCounter + i);
            s_tokenCounter = s_tokenCounter + 1;
        }

        return s_tokenCounter;
    }

    function setCost(uint256 _newCost)
        public
        onlyOwner
        returns (uint256 updatedCost)
    {
        cost = _newCost;
        return cost;
    }

    function setmaxMintAmount(uint256 _newmaxMintAmount)
        public
        onlyOwner
        returns (uint256 updatedMaxMintAmount)
    {
        maxMintAmount = _newmaxMintAmount;
        return maxMintAmount;
    }

    // Pancakeswap nft market contract address
    function setERC721NFTMarketV1addr(address newERC721NFTMarketV1addr)
        public
        onlyOwner
        returns (address updatedERC721NFTMarketV1addr)
    {
        ERC721NFTMarketV1addr = newERC721NFTMarketV1addr;
        return ERC721NFTMarketV1addr;
    }

    function setPriceLimit(uint256 newPriceLimit)
        public
        onlyOwner
        returns (uint256 updatedPriceLimit)
    {
        priceLimit = newPriceLimit;
        return priceLimit;
    }

    function pause(bool _state) public onlyOwner returns (bool updatedPaused) {
        paused = _state;
        return paused;
    }

    function withdraw() external payable onlyOwner {
        uint256 bal = address(this).balance;
        (bool os, ) = payable(owner()).call{ value: bal }('');
        require(os);
    }

    function getTokenCounter() public view returns (uint256) {
        return s_tokenCounter;
    }
}
