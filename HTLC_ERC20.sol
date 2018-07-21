/*
 Hashed time lock Contract ERC20 Token        
*/
pragma solidity ^0.4.18;

//here we import the token interface 
import "./ERC20.sol";

contract HTLC_ERC20_Token {
          
  uint public timeLock = now + 200;     //here we set the time lock (using Unix timestamp)
  address owner = msg.sender;           //owner of the contract                  
  bytes32 public sha256_hashed_secret = 0x...; //hashed secret

  ERC20 Your_token= ERC20(0x.....Your ERC20Token adress);  /* here we create an instance 
                                                            of the token using its adress to be able 
                                                            to interact with the contract and call its functions
                                                         */
                                                        

  //here we make sure that only the owner can refund his tokens
  modifier onlyOwner{require(msg.sender == owner); _; }


  //here you claim the tokens
    function claim(string _secret) public returns(bool result) {

       require(sha256_hashed_secret == sha256(_secret)); //secret verification
       require(msg.sender!=owner);                //verify that the claimer isn't the owner                 
       uint256 allbalance=Your_token.getBalanceOf(address(this));// get the tokens that are locked in this HTLC
       Your_token.transfer(msg.sender,allbalance);//transfer the tokens to the claimer 
       selfdestruct(owner);
       return true;
      
       }
    
    
    
       //here the owner can refound the token when the timeout is expired 
        function refund() onlyOwner public returns(bool result) {
        require(now >= timeLock);
        uint256 allbalance=Your_token.getBalanceOf(address(this)); 
        Your_token.transfer(owner,allbalance);
        selfdestruct(owner);
     
        return true;
      
        }
     
    
}
