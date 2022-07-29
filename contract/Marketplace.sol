pragma solidity ^0.8.2;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract Marketplace is ReentrancyGuard {
    using Counters for Counters.Counter;
    Counters.Counter private _itemIds;
    Counters.Counter private _itemsSold;
    Counters.Counter private _itemsUnSold;
    address payable public _owner;
    uint256 private _feePercentage;
    mapping(address => uint256) private _feeContracts;
    mapping(address => address payable) private _addressContracts;

    modifier onlyOwner() {
        require(_owner == msg.sender);
        _;
    }

    function getItemSold() public view returns (uint256 count) {
        return _itemsSold.current();
    }

    function setFeeContracts(
        address contractAddress,
        uint256 fees,
        address payable ownerAddress
    ) public onlyOwner {
        _feeContracts[contractAddress] = fees;
        _addressContracts[contractAddress] = ownerAddress;
    }

    function replaceOwner(address account) public onlyOwner {
        _owner = payable(account);
    }

    function setFeePercentage(uint256 newFeePercentage) public onlyOwner {
        _feePercentage = newFeePercentage;
    }

    constructor() {
        _owner = payable(msg.sender);
        _feePercentage = 2;
    }

    struct MarketItem {
        uint256 itemId;
        address nftContract;
        uint256 tokenId;
        address payable seller;
        address payable owner;
        uint256 price;
    }

    mapping(uint256 => MarketItem) private idToMarketItem;

    event MarketItemCreated(
        uint256 indexed itemId,
        address indexed nftContract,
        uint256 indexed tokenId,
        address seller,
        address owner,
        uint256 price
    );

    event MarketItemSell(
        uint256 indexed itemId,
        address indexed nftContract,
        uint256 indexed tokenId,
        address seller,
        address owner,
        uint256 price
    );

    event MarketItemRemove(
        uint256 indexed itemId,
        address indexed nftContract,
        uint256 indexed tokenId,
        address seller,
        address owner
    );

    function getMarketItem(uint256 marketItemId)
        public
        view
        returns (MarketItem memory)
    {
        return idToMarketItem[marketItemId];
    }

    function createMarketItem(
        address nftContract,
        uint256 tokenId,
        uint256 price
    ) public payable nonReentrant {
        require(price > 0, "Price must be at least 1 wei");
        require(
            _addressContracts[nftContract] != address(0),
            "Can not sell this collection"
        );

        _itemIds.increment();
        uint256 itemId = _itemIds.current();

        idToMarketItem[itemId] = MarketItem(
            itemId,
            nftContract,
            tokenId,
            payable(msg.sender),
            payable(address(0)),
            price
        );

        IERC721(nftContract).transferFrom(msg.sender, address(this), tokenId);

        emit MarketItemCreated(
            itemId,
            nftContract,
            tokenId,
            msg.sender,
            address(0),
            price
        );
    }

    function forceDeleteAllMarket() public onlyOwner {
        uint256 itemCount = _itemIds.current();
        uint256 unsoldItemCount = _itemIds.current() -
            _itemsSold.current() -
            _itemsUnSold.current();
        for (uint256 i = 0; i < itemCount; i++) {
            if (idToMarketItem[i + 1].owner == address(0)) {
                uint256 currentId = idToMarketItem[i + 1].itemId;
                MarketItem storage currentItem = idToMarketItem[currentId];
                IERC721(currentItem.nftContract).transferFrom(
                    address(this),
                    msg.sender,
                    currentId
                );
                idToMarketItem[currentId].owner = payable(
                    idToMarketItem[currentId].seller
                );
                _itemsUnSold.increment();
            }
        }
    }

    function deleteMarketItem(address nftContract, uint256 itemId) public {
        uint256 tokenId = idToMarketItem[itemId].tokenId;
        address seller = idToMarketItem[itemId].seller;
        address owner = idToMarketItem[itemId].owner;
        require(msg.sender == seller, "You are not seller");
        require(owner == address(0), "Not in selling");
        IERC721(nftContract).transferFrom(address(this), msg.sender, tokenId);
        idToMarketItem[itemId].owner = payable(msg.sender);
        _itemsUnSold.increment();
        emit MarketItemRemove(
            itemId,
            nftContract,
            tokenId,
            msg.sender,
            address(0)
        );
    }

    function createMarketSale(address nftContract, uint256 itemId)
        public
        payable
        nonReentrant
    {
        uint256 price = idToMarketItem[itemId].price;
        uint256 tokenId = idToMarketItem[itemId].tokenId;
        require(
            msg.value == price,
            "Please submit the asking price in order to complete the purchase"
        );

        uint256 fee = (msg.value * _feePercentage) / 100;
        address payable ownerContract = _addressContracts[nftContract];
        uint256 feeOwner = (msg.value * _feeContracts[nftContract]) / 100;
        uint256 finalPrice = msg.value - fee - feeOwner;
        idToMarketItem[itemId].seller.transfer(finalPrice);
        _owner.transfer(fee);
        ownerContract.transfer(feeOwner);
        IERC721(nftContract).transferFrom(address(this), msg.sender, tokenId);
        idToMarketItem[itemId].owner = payable(msg.sender);
        _itemsSold.increment();

        emit MarketItemSell(
            itemId,
            nftContract,
            tokenId,
            idToMarketItem[itemId].seller,
            msg.sender,
            price
        );
    }

    function fetchMarketItem(uint256 itemId)
        public
        view
        returns (MarketItem memory)
    {
        MarketItem memory item = idToMarketItem[itemId];
        return item;
    }

    function fetchMarketItems() public view returns (MarketItem[] memory) {
        uint256 itemCount = _itemIds.current();
        uint256 unsoldItemCount = _itemIds.current() -
            _itemsSold.current() -
            _itemsUnSold.current();
        uint256 currentIndex = 0;

        MarketItem[] memory items = new MarketItem[](unsoldItemCount);
        for (uint256 i = 0; i < itemCount; i++) {
            if (idToMarketItem[i + 1].owner == address(0)) {
                uint256 currentId = idToMarketItem[i + 1].itemId;
                MarketItem storage currentItem = idToMarketItem[currentId];
                items[currentIndex] = currentItem;
                currentIndex += 1;
            }
        }

        return items;
    }

    function fetchMyNFTs() public view returns (MarketItem[] memory) {
        uint256 totalItemCount = _itemIds.current();
        uint256 itemCount = 0;
        uint256 currentIndex = 0;

        for (uint256 i = 0; i < totalItemCount; i++) {
            if (idToMarketItem[i + 1].seller == msg.sender) {
                itemCount += 1;
            }
        }

        MarketItem[] memory items = new MarketItem[](itemCount);
        for (uint256 i = 0; i < totalItemCount; i++) {
            if (idToMarketItem[i + 1].seller == msg.sender) {
                uint256 currentId = idToMarketItem[i + 1].itemId;
                MarketItem storage currentItem = idToMarketItem[currentId];
                items[currentIndex] = currentItem;
                currentIndex += 1;
            }
        }

        return items;
    }
}
