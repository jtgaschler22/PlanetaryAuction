pragma solidity ^0.5.5;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC721/ERC721Full.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/ownership/Ownable.sol";
import "./PlanetAuction.sol";

contract PlanetMarket is ERC721Full, Ownable {

    constructor() ERC721Full("PlanetMarket", "PLTM") public {}

    using Counters for Counters.Counter;
    Counters.Counter token_ids;

    address payable planetary_broker_address = msg.sender;

    mapping(uint => PlanetAuction) public auctions;

    modifier planetRegistered(uint token_id) {
        require(_exists(token_id), "Planet not yet registered");
        _;
    }

    function initiateAuction(uint token_id) public onlyOwner {
        auctions[token_id] = new PlanetAuction(planetary_broker_address);
    }

    function registerPlanet(string memory uri) public payable onlyOwner {
        token_ids.increment();
        uint token_id = token_ids.current();
        _mint(planetary_broker_address, token_id);
        _setTokenURI(token_id, uri);
        createAuction(token_id);
    }

    function endAuction(uint token_id) public onlyOwner planetRegistered(token_id) {
        PlanetAuction auction = auctions[token_id];
        auction.auctionEnd();
        safeTransferFrom(owner(), auction.highestBidder(), token_id);
    }
    
    function auctionClosed(uint token_id) public view returns (bool) {
        PlanetAuction auction = auctions[token_id];
        return auction.ended();
    }
    
    function highestBid(uint token_id) public view planetRegistered(token_id) returns (uint) {
        PlanetAuction auction = auctions[token_id];
        return auction.highestBid();
    }
    
    function pendingReturn(uint token_id, address sender) public view planetRegistered(token_id) returns (uint) {
        PlanetAuction auction = auctions[token_id];
        return auction.pendingReturn(sender);
    }
    
    function bid(uint token_id) public payable planetRegistered(token_id) {
        PlanetAuction auction = auctions[token_id];
        auction.bid.value(msg.value)(msg.sender);
    }

