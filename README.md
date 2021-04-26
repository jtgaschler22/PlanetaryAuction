# Planetary Auction
Simple auction contracts revolving around a fictitious space auction

This repository is designed for minting ERC721 tokens and using a simple marketplaces with functions to facilitate hosting an auction. The theme behind these contracts is a planetary auction for planets within our solar system but could be extrapolated out into the the universe as well. In the future, perhaps nations or other government/private organizations will bid for the ownership rights to other planets. Since Elon seems to have Mars claimed already, he'd better win this auction!

### Instructions
For the purpose of this coding example I did not include any front end JavaScript scripts to deploy to the mainnet or testnet via CLI. Instead, I recommend using Remix to sample these contracts. 
  1. First, deploy the PlanetMarket contract. 
  2. Use the PlanetMarkets's contract address as the beneficiary to deploy the PlanetAuction.
  3. Back in PlanetMarket, call the registerPlanet function with a planet's URI

  ![Register planet](/images/registerplanet.PNG)
  
  4. Start the auction by calling the initiateAuction function using the newly created token ID (in this case, 1)

  ![Initiate auction](/images/initiate.PNG)

  5. Submit a bid by calling the "bid" function using the token ID as the input, along with adding a message value to the call

  ![Submit a bid](/images/bid.PNG)
  
  
The remaining functions laregely deal with ending an auction or transfering ownership of the token_ids to the new owners. This code can be modified for an auction with a different theme as well. 
  
  
  
  
  
  
  
  
