// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "./structs/NewsDetails.sol";

contract News {
    address public owner;
    uint private _newsId;

    mapping(uint => NewsDetails) public newsIdToNews;
    // index to newsId mapping

    mapping(uint => address) public _creators;

    uint[] public newsIds;

    constructor() {
        owner = msg.sender;
    }

    function createNews(string calldata ipfsImage, string calldata ipfsTitle, string calldata ipfsDescription, string calldata ipfsArticle) public onlyOwner {
        uint256 newsId = _newsId;
        ++_newsId;

        newsIdToNews[newsId] = NewsDetails(msg.sender, block.timestamp, ipfsImage, ipfsTitle, ipfsDescription, ipfsArticle);
        _creators[newsId] = msg.sender;

        newsIds.push(newsId);
    }

    function creatorOf(uint256 newsId) public view returns (address) {
        address creator = _creators[newsId];
        require(creator != address(0), "Invalid token newsId");
        return creator;
    }
    
    function deleteNews(uint256 index) public onlyOwner {
        uint newsId = newsIds[index];

        newsIds[index] = newsIds[newsIds.length - 1];
        newsIds.pop();
    
        delete newsIdToNews[newsId];
    }

    function editNews(uint index, string calldata ipfsImage, string calldata ipfsTitle, string calldata ipfsDescription, string calldata ipfsArticle) public onlyOwner {
        uint newsId = newsIds[index];

        newsIdToNews[newsId] = NewsDetails(msg.sender, block.timestamp, ipfsImage, ipfsTitle, ipfsDescription, ipfsArticle);
        newsIds.push(newsId);
    }

    function editNewsImage(uint256 index, string calldata ipfsImage) public onlyOwner {
        uint newsId = newsIds[index];

        newsIdToNews[newsId].ipfsImage = ipfsImage;
    }

    function editNewsTitle(uint256 index, string calldata ipfsTitle) public onlyOwner {
        uint newsId = newsIds[index];

        newsIdToNews[newsId].ipfsTitle = ipfsTitle;
    }

    function editNewsDescription(uint256 index, string calldata ipfsDescription) public onlyOwner {
        uint newsId = newsIds[index];

        newsIdToNews[newsId].ipfsDescription = ipfsDescription;
    }

    function editNewsArticle(uint256 index, string calldata ipfsArticle) public onlyOwner {
        uint newsId = newsIds[index];
        
        newsIdToNews[newsId].ipfsArticle = ipfsArticle;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function.");
        _;
    }

    // function beforeTransaction(address issuer, uint newsId) internal {
    //     require(issuer == _creators[newsId], "Only creator of this news can call this function.");
    // }
}