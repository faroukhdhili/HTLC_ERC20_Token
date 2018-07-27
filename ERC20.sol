pragma solidity ^0.4.16;

     //here we declare the function that we need for the token swap as an interface 

      contract ERC20 {
      
     function balanceOf(address _who )public view returns (uint256 balance);
      function transfer(address _to, uint256 _value) public;
         
    
    
}