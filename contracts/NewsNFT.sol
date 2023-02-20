// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

import "./structs/NewsDetails.sol";

contract NewsNFT is ERC721, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    mapping(uint => NewsDetails) public tokenIdToNews;

    // Optional mapping for token URIs
    mapping(uint256 => string) private _tokenURIs;

    uint[] public newsIds;

    constructor() ERC721("NewsNFT", "NWS") {}

    function safeMint(address to, string calldata ipfsImage, string calldata ipfsTitle, string calldata ipfsDescription, string calldata ipfsArticle) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, ipfsImage);

        tokenIdToNews[tokenId] = NewsDetails(msg.sender, block.timestamp, ipfsImage, ipfsTitle, ipfsDescription, ipfsArticle);
        newsIds.push(tokenId);
    }

    function deleteNews(uint256 index) public onlyOwner {
        uint tokenId = newsIds[index];

        newsIds[index] = newsIds[newsIds.length - 1];
        newsIds.pop();
        
        _burn(tokenId);
        
        delete tokenIdToNews[tokenId];
    }

    function editNewsImage(uint256 index, string calldata ipfsImage) public onlyOwner {
        uint tokenId = newsIds[index];

        _setTokenURI(tokenId, ipfsImage);
        tokenIdToNews[tokenId].ipfsImage = ipfsImage;
    }

    function editNewsTitle(uint256 index, string calldata ipfsTitle) public onlyOwner {
        uint tokenId = newsIds[index];

        tokenIdToNews[tokenId].ipfsTitle = ipfsTitle;
    }

    function editNewsDescription(uint256 index, string calldata ipfsDescription) public onlyOwner {
        uint tokenId = newsIds[index];

        tokenIdToNews[tokenId].ipfsDescription = ipfsDescription;
    }

    function editNewsArticle(uint256 index, string calldata ipfsArticle) public onlyOwner {
        uint tokenId = newsIds[index];

        tokenIdToNews[tokenId].ipfsArticle = ipfsArticle;
    }

    /**
     * @dev See {IERC721Metadata-tokenURI}.
     */
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        _requireMinted(tokenId);

        string memory _tokenURI = _tokenURIs[tokenId];
        string memory base = _baseURI();

        // If there is no base URI, return the token URI.
        if (bytes(base).length == 0) {
            return _tokenURI;
        }
        // If both are set, concatenate the baseURI and tokenURI (via abi.encodePacked).
        if (bytes(_tokenURI).length > 0) {
            return string(abi.encodePacked(base, _tokenURI));
        }
    }

    /**
     * @dev Sets `_tokenURI` as the tokenURI of `tokenId`.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function _setTokenURI(uint256 tokenId, string memory _tokenURI) internal virtual {
        require(_exists(tokenId), "ERC721URIStorage: URI set of nonexistent token");
        _tokenURIs[tokenId] = _tokenURI;
    }
    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId) internal override(ERC721) {
        super._burn(tokenId);
        
        if (bytes(_tokenURIs[tokenId]).length != 0) {
            delete _tokenURIs[tokenId];
        }
    }
}