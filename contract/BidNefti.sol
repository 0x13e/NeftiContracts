pragma solidity ^0.8.2;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract BidNefti is ReentrancyGuard {
    /* BID */
    uint256 public index = 0;
    Auction[] private allAuctions;
    struct Auction {
        uint256 index; // Auction Index
        address addressNFTCollection; // Address of the ERC721 NFT Collection contract
        uint256 nftId; // NFT Id
        address creator; // Creator of the Auction
        address payable currentBidOwner; // Address of the highest bider
        uint256 currentBidPrice; // Current highest bid for the auction
        uint256 endAuction; // Timestamp for the end day&time of the auction
        uint256 bidCount; // Number of bid placed on the auction
    }
    uint256 private _feePercentage;
    address payable public _owner;
    mapping(address => uint256) private _feeContracts;
    mapping(address => address payable) private _addressContracts;

    event NewAuction(
        uint256 index,
        address addressNFTCollection,
        uint256 nftId,
        address mintedBy,
        address currentBidOwner,
        uint256 currentBidPrice,
        uint256 endAuction,
        uint256 bidCount
    );

    event NFTClaimed(
        uint256 auctionIndex,
        address indexed _address,
        uint256 tokenId,
        address claimedBy
    );
    event TokensClaimed(
        uint256 auctionIndex,
        address indexed _address,
        uint256 tokenId,
        address claimedBy
    );
    event NFTRefunded(
        uint256 auctionIndex,
        address indexed _address,
        uint256 tokenId,
        address claimedBy
    );
    event NewBidOnAuction(
        uint256 auctionIndex,
        address indexed _address,
        address from,
        uint256 tokenId,
        uint256 endAuction,
        uint256 newBid
    );

    modifier onlyOwner() {
        require(_owner == msg.sender);
        _;
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

    function setFeeContracts(
        address contractAddress,
        uint256 fees,
        address payable ownerAddress
    ) public onlyOwner {
        _feeContracts[contractAddress] = fees;
        _addressContracts[contractAddress] = ownerAddress;
    }

    function isContract(address _addr) private view returns (bool) {
        uint256 size;
        assembly {
            size := extcodesize(_addr)
        }
        return size > 0;
    }

    function createAuction(
        address _addressNFTCollection,
        uint256 _nftId,
        uint256 _initialBid,
        uint256 _endAuction
    ) external returns (uint256) {
        //Check is addresses are valid
        require(
            isContract(_addressNFTCollection),
            "Invalid NFT Collection contract address"
        );
        // Check if the endAuction time is valid
        require(_endAuction > block.timestamp, "Invalid end date for auction");

        // Check if the initial bid price is > 0
        require(_initialBid > 0, "Invalid initial bid price");

        // Get NFT collection contract
        IERC721 nftCollection = IERC721(_addressNFTCollection);

        // Make sure the sender that wants to create a new auction
        // for a specific NFT is the owner of this NFT
        require(
            nftCollection.ownerOf(_nftId) == msg.sender,
            "Caller is not the owner of the NFT"
        );

        // Make sure the owner of the NFT approved that the MarketPlace contract
        // is allowed to change ownership of the NFT
        /* require(
            nftCollection.getApproved(_nftId) == address(this),
            "Require NFT ownership transfer approval"
        );*/

        // Lock NFT in Marketplace contract
        //require(nftCollection.transferNFTFrom(msg.sender, address(this), 0));
        nftCollection.transferFrom(msg.sender, address(this), _nftId);
        //Casting from address to address payable
        address payable currentBidOwner = payable(address(0));
        // Create new Auction object
        Auction memory newAuction = Auction({
            index: index,
            addressNFTCollection: _addressNFTCollection,
            nftId: _nftId,
            creator: msg.sender,
            currentBidOwner: currentBidOwner,
            currentBidPrice: _initialBid,
            endAuction: _endAuction,
            bidCount: 0
        });

        //update list
        allAuctions.push(newAuction);

        // Trigger event and return index of new auction
        emit NewAuction(
            index,
            _addressNFTCollection,
            _nftId,
            msg.sender,
            currentBidOwner,
            _initialBid,
            _endAuction,
            0
        );
        // increment auction sequence
        index++;

        return index;
    }

    /**
     * Check if an auction is open
     * @param _auctionIndex Index of the auction
     */
    function isOpen(uint256 _auctionIndex) public view returns (bool) {
        Auction storage auction = allAuctions[_auctionIndex];
        if (block.timestamp >= auction.endAuction) return false;
        return true;
    }

    function getAuction(uint256 _auctionIndex)
        public
        view
        returns (Auction memory)
    {
        require(_auctionIndex < allAuctions.length, "Invalid auction index");
        return allAuctions[_auctionIndex];
    }

    /**
     * Return the address of the current highest bider
     * for a specific auction
     * @param _auctionIndex Index of the auction
     */
    function getCurrentBidOwner(uint256 _auctionIndex)
        public
        view
        returns (address)
    {
        require(_auctionIndex < allAuctions.length, "Invalid auction index");
        return allAuctions[_auctionIndex].currentBidOwner;
    }

    /**
     * Return the current highest bid price
     * for a specific auction
     * @param _auctionIndex Index of the auction
     */
    function getCurrentBid(uint256 _auctionIndex)
        public
        view
        returns (uint256)
    {
        require(_auctionIndex < allAuctions.length, "Invalid auction index");
        return allAuctions[_auctionIndex].currentBidPrice;
    }

    /**
     * Place new bid on a specific auction
     * @param _auctionIndex Index of auction
     */
    function bid(uint256 _auctionIndex) external payable returns (bool) {
        require(_auctionIndex < allAuctions.length, "Invalid auction index");
        Auction storage auction = allAuctions[_auctionIndex];

        // check if auction is still open
        require(isOpen(_auctionIndex), "Auction is not open");

        // check if new bid price is higher than the current one
        require(
            msg.value > auction.currentBidPrice,
            "New bid price must be higher than the current bid"
        );

        // check if new bider is not the owner
        require(
            msg.sender != auction.creator,
            "Creator of the auction cannot place new bid"
        );

        // new bid is valid so must refund the current bid owner (if there is one!)
        if (auction.bidCount > 0) {
            payable(auction.currentBidOwner).transfer(auction.currentBidPrice);
        }

        // update auction info
        address payable newBidOwner = payable(msg.sender);
        auction.currentBidOwner = newBidOwner;
        auction.currentBidPrice = msg.value;
        auction.bidCount++;

        if (block.timestamp + 70 >= auction.endAuction) {
            auction.endAuction = auction.endAuction + 70;
        }

        // Trigger public event
        emit NewBidOnAuction(
            _auctionIndex,
            auction.addressNFTCollection,
            msg.sender,
            auction.nftId,
            auction.endAuction,
            msg.value
        );

        return true;
    }

    function claimNFT(uint256 _auctionIndex) external {
        require(_auctionIndex < allAuctions.length, "Invalid auction index");

        // Check if the auction is closed
        require(!isOpen(_auctionIndex), "Auction is still open");

        // Get auction
        Auction storage auction = allAuctions[_auctionIndex];

        // Check if the caller is the winner of the auction
        require(
            auction.currentBidOwner == msg.sender,
            "NFT can be claimed only by the current bid owner"
        );

        // Get NFT collection contract
        IERC721 nftCollection = IERC721(auction.addressNFTCollection);

        nftCollection.transferFrom(
            address(this),
            auction.currentBidOwner,
            auction.nftId
        );

        uint256 fee = (auction.currentBidPrice * _feePercentage) / 100;
        address payable ownerContract = _addressContracts[
            auction.addressNFTCollection
        ];
        uint256 feeOwner = (auction.currentBidPrice *
            _feeContracts[auction.addressNFTCollection]) / 100;
        uint256 finalPrice = auction.currentBidPrice - fee - feeOwner;

        payable(auction.creator).transfer(finalPrice);
        _owner.transfer(fee);
        ownerContract.transfer(feeOwner);

        emit NFTClaimed(
            _auctionIndex,
            auction.addressNFTCollection,
            auction.nftId,
            msg.sender
        );
    }

    function claimToken(uint256 _auctionIndex) external {
        require(_auctionIndex < allAuctions.length, "Invalid auction index"); // XXX Optimize

        // Check if the auction is closed
        require(!isOpen(_auctionIndex), "Auction is still open");

        // Get auction
        Auction storage auction = allAuctions[_auctionIndex];

        // Check if the caller is the creator of the auction
        require(
            auction.creator == msg.sender,
            "Tokens can be claimed only by the creator of the auction"
        );

        // Get NFT Collection contract
        IERC721 nftCollection = IERC721(auction.addressNFTCollection);

        // Transfer NFT from marketplace contract
        // to the winned of the auction
        nftCollection.transferFrom(
            address(this),
            auction.currentBidOwner,
            auction.nftId
        );

        uint256 fee = (auction.currentBidPrice * _feePercentage) / 100;
        address payable ownerContract = _addressContracts[
            auction.addressNFTCollection
        ];
        uint256 feeOwner = (auction.currentBidPrice *
            _feeContracts[auction.addressNFTCollection]) / 100;
        uint256 finalPrice = auction.currentBidPrice - fee - feeOwner;

        payable(auction.creator).transfer(finalPrice);
        _owner.transfer(fee);
        ownerContract.transfer(feeOwner);

        emit TokensClaimed(
            _auctionIndex,
            auction.addressNFTCollection,
            auction.nftId,
            msg.sender
        );
    }

    /**
     * Function used by the creator of an auction
     * to get his NFT back in case the auction is closed
     * but there is no bider to make the NFT won't stay locked
     * in the contract
     * @param _auctionIndex Index of the auction
     */
    function refund(uint256 _auctionIndex) external {
        require(_auctionIndex < allAuctions.length, "Invalid auction index");

        // Check if the auction is closed
        require(!isOpen(_auctionIndex), "Auction is still open");

        // Get auction
        Auction storage auction = allAuctions[_auctionIndex];

        // Check if the caller is the creator of the auction
        require(
            auction.creator == msg.sender,
            "Tokens can be claimed only by the creator of the auction"
        );

        require(
            auction.currentBidOwner == address(0),
            "Existing bider for this auction"
        );

        // Get NFT Collection contract
        IERC721 nftCollection = IERC721(auction.addressNFTCollection);
        // Transfer NFT back from marketplace contract
        // to the creator of the auction
        nftCollection.transferFrom(
            address(this),
            auction.creator,
            auction.nftId
        );

        emit NFTRefunded(
            _auctionIndex,
            auction.addressNFTCollection,
            auction.nftId,
            msg.sender
        );
    }
}
