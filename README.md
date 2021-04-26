# Planetary Auction
Simple auction contracts revolving around a fictitious space auction

This repository is designed for minting ERC721 tokens and using a simple marketplaces with functions to facilitate hosting an auction. The theme behind these contracts is a planetary auction for planets within our solar system but could be extrapolated out into the the universe as well. In the future, perhaps nations or other government/private organizations will bid for the ownership rights to other planets. Since Elon seems to have Mars claimed already, he'd better win this auction!

### Instructions
For the purpose of this coding example I did not include any front end JavaScript scripts to deploy to the mainnet or testnet via CLI. Instead, I recommend using Remix to sample these contracts. 
  1. First, deploy the PlanetMarket contract. 
  2. Use the PlanetMarkets's contract address as the beneficiary to deploy the PlanetAuction. 

  ![Register planet](/images/registerplanet.PNG)

  4. Back in PlanetMarket, call the registerPlanet function with a planet's URI
 
  ![Submit a Bid](/images/submitbid.PNG)
  
  3. To submit a bid within PlanetAuction, paste in the sender's address in the submitBid function and add a value to your message that you would like to bid. 
    - Once your bid is submitted you can use the highestBid and highestBidder functions to retrieve your bid info, or to see if you've been outbid
  
