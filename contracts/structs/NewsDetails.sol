// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

struct NewsDetails {
    address creator;
    uint createdAt;
    string ipfsImage;
    string ipfsTitle;
    string ipfsDescription;
    string ipfsArticle;
}