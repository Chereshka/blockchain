// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract ERC721Collection is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    struct Image {
        string name;
        string metadata;
        string ipfsHash;
    }
    
    Image[] private images; 

    mapping(address => uint[]) public ownerToImages;

    constructor() ERC721("MyERC721Collection", "MEC") {}

    function mint(string memory name, string memory metadata, string memory ipfsHash) public {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();

        images[newItemId] = Image(name, metadata, ipfsHash);

        _safeMint(msg.sender, newItemId);
    }

    function addImageToAddress(uint256 _tokenId, address  _to) public {
            
        bool found = false;
        for (uint256 i = 0; i < ownerToImages[_to].length; i++) {
        if (ownerToImages[_to][i] == _tokenId) {
            found = true;
            break;
            }
        }
        require(found == false, "Address already owns the image");
        _transfer(msg.sender, _to, _tokenId);
        ownerToImages[_to].push(_tokenId);
            
    }

    function getImagesByOwner(address _owner) public view returns (uint256[] memory) {
        uint256[] memory result = new uint256[](ownerToImages[_owner].length);
        uint256 counter = 0;
        for (uint256 i = 0; i < images.length; i++) {
            for (uint256 j = 0; j < ownerToImages[_owner].length; j++) {
                if (ownerToImages[_owner][j] == i) {
                    result[counter] = i;
                    counter++;
                    break;
                }
            }
        }
        return result;
    }
    

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        return string(abi.encodePacked("ipfs://", images[tokenId].ipfsHash));
    }

    function getMyImageName(uint256 tokenId) public view returns (string memory) {
        return images[tokenId].name;
    }

}
