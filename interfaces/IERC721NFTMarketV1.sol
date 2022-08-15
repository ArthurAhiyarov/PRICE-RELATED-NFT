// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library AskLib {
    struct Ask {
        address seller;
        uint256 price;
    }
}

interface IERC721NFTMarketV1 {
    function viewAsksByCollectionAndTokenIds(
        address collection,
        uint256[] calldata tokenIds
    )
        external
        view
        returns (bool[] memory statuses, AskLib.Ask[] memory askInfo);
}
