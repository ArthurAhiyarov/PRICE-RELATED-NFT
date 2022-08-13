// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import '../interfaces/IPancakeRouter01.sol';

contract PriceRelatedNFT is ERC721 {
    uint256 requiredPrice;
    string public constant TOKEN_URI =
        'ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json';
    uint256 private s_tokenCounter;
    address private routerV2addr = 0x10ED43C718714eb63d5aA57B78B54704E256024E;

    constructor(uint256 _requiredPrice) ERC721('Dogie', 'DOG') {
        s_tokenCounter = 0;
        requiredPrice = _requiredPrice;
    }

    modifier priceLevel() {
        IPancakeRouter01 exchangeRate = IPancakeRouter01(routerV2addr);
        // Here we should get the exchange rate of our token to USDC on BSC
        // exchangeRate.getAmountsOut();

        ERC721NFTMarketV1 nftMarket = ERC721NFTMarketV1(
            0x17539cCa21C7933Df5c980172d22659B8C345C5A
        );
        // (, Ask[] memory askInfo) = viewAsksByCollectionAndTokenIds(address collection, uint256[] calldata tokenIds)
        require(askInfo[0].price > requiredPrice);
    }
}
