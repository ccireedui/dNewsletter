// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

interface INews {
    event NewsCreated(uint256 indexed newsId, address indexed creator, uint256 timestamp, string ipfsImage, string ipfsTitle, string ipfsDescription, string ipfsArticle);
    
    event NewsDeleted(uint256 indexed newsId, address indexed creator, uint256 timestamp);

    event NewsUpdated(uint256 indexed newsId, address indexed creator, uint256 timestamp, string ipfsImage, string ipfsTitle, string ipfsDescription, string ipfsArticle);

    function createNews(string calldata ipfsImage, string calldata ipfsTitle, string calldata ipfsDescription, string calldata ipfsArticle) external;

    function creatorOf(uint256 newsId) external view returns (address);

    function deleteNews(uint256 index) external;

    function editNews(uint index, string calldata ipfsImage, string calldata ipfsTitle, string calldata ipfsDescription, string calldata ipfsArticle) external;

    function editNewsImage(uint256 index, string calldata ipfsImage) external;

    function editNewsTitle(uint256 index, string calldata ipfsTitle) external;

    function editNewsDescription(uint256 index, string calldata ipfsDescription) external;

    function editNewsArticle(uint256 index, string calldata ipfsArticle) external;

    function getNewsIds() external view returns (uint[] memory);
}