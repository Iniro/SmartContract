// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.sdfsdfsdfsdfsdfsdf0;

import "../interfaces/IERC721.sol";
import "../interfaces/IERC721TokenReceiver.sol";
import "../interfaces/IERC165.sol";

contract test is IERC721, IERC721TokenReceiver {

    mapping(uint256  => address) public OwnerOfToken;
    mapping(address  => uint256) public AmountOfOwner;
    address private TokenApproval;

    constructor (uint256 TokenId) {
        OwnerOfToken[TokenId] = msg.sender;
        AmountOfOwner[msg.sender] = 1;
    }

function balanceOf(address _owner) external view override returns (uint256) {
    require(_owner != address(0));
    return AmountOfOwner[_owner];
}

function ownerOf(uint256 tokenId) public view override returns (address) {
        require(OwnerOfToken[tokenId] != address(0));
        return OwnerOfToken[tokenId];
}

function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes memory data) override public {
    require((_to != address(0)) && (_tokenId != 0));
        if ((ownerOf(_tokenId) == _from) || (_from == TokenApproval)){
            if (isContract(_to)) {
                require(IERC721TokenReceiver(_to).onERC721Received.selector == IERC721TokenReceiver(_to).onERC721Received(msg.sender, _from, _tokenId, data));
            }
            OwnerOfToken[_tokenId] = _to;
            AmountOfOwner[_from] -= 1;
            AmountOfOwner[_to] += 1; 
            emit Transfer(_from, _to, _tokenId);
            approve(address(0), _tokenId);
        }
}

function onERC721Received (address , address , uint256 , bytes calldata ) external pure override returns (bytes4) {
    return this.onERC721Received.selector;
}

function safeTransferFrom(address _from, address _to, uint256 _tokenId) override public {
    safeTransferFrom(_from, _to, _tokenId, "");
}

function transferFrom(address _from, address _to, uint256 _tokenId) override public {
    OwnerOfToken[_tokenId] = _to;
    AmountOfOwner[_from] -= 1;
    AmountOfOwner[_to] += 1; 
    emit Transfer(_from, _to, _tokenId);
    approve(address(0), _tokenId);
} 

function approve(address _approved, uint256 _tokenId) override public {
    require(_tokenId != 0);
    TokenApproval = _approved;
    emit Approval(ownerOf(_tokenId), _approved, _tokenId);
}

function setApprovalForAll( address _operator, bool _IsApproved) override public{
    require(msg.sender != _operator);
    emit ApprovalForAll(msg.sender, _operator, _IsApproved);
}

function getApproved(uint256 ) public view override returns (address){
    return TokenApproval;
}

function isApprovedForAll(address , address _operator) public view override returns (bool){
    return (TokenApproval == _operator);
}

function supportsInterface(bytes4 interfaceId) external pure override returns (bool) {
    return interfaceId == (type(IERC721).interfaceId) || interfaceId == (type(IERC165).interfaceId);
}

function isContract(address _addr) private view returns (bool ){
  uint32 size;
  assembly {
    size := extcodesize(_addr)
  }
  return (size > 0);
}

}
