// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

library Indexer {
    function indexOf(uint[] calldata self, uint value) internal pure returns (uint) {
        for (uint i = 0; i < self.length; i++) {
            if (self[i] == value) {
                return i;
            }
        }
        revert("Value not found");
    }
}