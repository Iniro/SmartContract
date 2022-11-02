// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "../interfaces/IERC721.sol";
import "../interfaces/IERC721TokenReceiver.sol";
import "../interfaces/IERC165.sol";

contract test is IERC721 {

    address private TokenOwner;
    address private TokenApproval;
    uint256 private TokenId;

    constructor (uint256 Id) {
        TokenOwner =  msg.sender;
        TokenId = Id;
        //TokenApproval = address(0);
    }

function balanceOf(address _owner) external view returns (uint256) {
    require(_owner != address(0));
    if (_owner == TokenOwner) {
        return 1;
    }
    else {
        return 0;
    }

}

function ownerOf(uint256 ) public view returns (address) {
    return TokenOwner;
}

function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes memory ) public {
    require((_to != address(0)) && (_tokenId != 0));
        if ((_from == TokenOwner) || (_from == TokenApproval)){
            TokenOwner = _to; 
            emit Transfer(_from, _to, _tokenId);
            approve(address(0), _tokenId);
        }
}

function safeTransferFrom(address _from, address _to, uint256 _tokenId) public {
    safeTransferFrom(_from, _to, _tokenId, "");
}

function transferFrom(address _from, address _to, uint256 _tokenId) public {
    TokenOwner = _to;
    emit Transfer(_from, _to, _tokenId);
    approve(address(0), _tokenId);
} 

function approve(address _approved, uint256 _tokenId) public {
    require(_tokenId != 0);
        emit Approval(ownerOf(_tokenId), _approved, 0);
}

function setApprovalForAll(address _operator, bool _approved) public{
    require(TokenOwner != _operator);
        emit ApprovalForAll(TokenOwner, _operator, _approved);
}

function getApproved(uint256 ) public view returns (address){
    return TokenApproval;
}

function isApprovedForAll(address , address _operator) public view returns (bool){
    return (TokenApproval == _operator);
}

function supportsInterface(bytes4 interfaceId) external pure returns (bool) {
    return interfaceId == (type(IERC721).interfaceId) || interfaceId == (type(IERC165).interfaceId);
}

}
