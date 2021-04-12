pragma solidity ^0.5.5;

contract PlanetAuction {
    address deployer;
    address payable public beneficiary;
    
    // Initialize current auction state variables
    address public highestBidder;
    uint public highestBid;
    
    // Mapping for the withdrawals of prior bids
    mapping(address => uint) pendingReturns;
    
    // Initialize auction ended state variable, initialive false by default
    bool public ended;
    
    // Set events for auction updates
    event newHighBid(address bidder, uint amount);
    event AuctionOver(address winner, uint amount);
    
    /// Create a simple auction with _biddingTime seconds bidding time
    /// on behalf of the beneficiary address _beneficiary
    constructor(address payable _beneficiary) public {
        deployer = msg.sender; // set this address to PlanetMarket
        beneficiary = _beneficiary;
    }
    
    /// Bid on the auction with the value sent together with the transaction.
    /// The value will be refunded if you lose the auction 
    function submitBid(address payable sender) public payable {
        // require bid to be highest
        require(msg.value > highestBid, "There is a higher bid. Please bid again!");
        require(!ended, "The auction has ended.");
        
        if (highestBid !=0) {
            pendingReturns[highestBidder] += highestBid;
        }
        highestBidder = sender;
        highestBid = msg.value;
        emit newHighBid(sender, msg.value);
    }
    
    // Withdraw a bid that was outbid
    function withdrawBid() public returns (bool) {
        uint amount = pendingReturns[msg.sender];
        if (amount > 0) {
            // set to zero to prevent multiple calls 
            pendingReturns[msg.sender] = 0;
            
            if (!msg.sender.send(amount)) {
                pendingReturns[msg.sender] = amount;
                return false;
            }
        }
        return true;
    }
    
    function pendingReturn(address sender) public view returns (uint) {
        return pendingReturns[sender];
    }
    
    /// Ended the auction and send the highest bid to the beneficiary 
    function auctionClosed() public {
        // Conditions
        require(!ended, "auctionClosed already called");
        require(msg.sender == deployer, "You did not deploy the auction");
        
        // Effects
        ended = true;
        emit AuctionOver(highestBidder, highestBid);
        
        // Award beneficiary the highest bid
        beneficiary.transfer(highestBid);
    } 
 
}