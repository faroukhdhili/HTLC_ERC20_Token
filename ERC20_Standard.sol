pragma solidity ^0.4.16;

interface tokenRecipient { function receiveApproval(address _from, uint256 _value, address _token, bytes _extraData) external; }

contract TokenERC20 {
  
    string public name;
    string public symbol;
    uint8 public decimals = 18;
  
    uint256 _totalSupply;

    mapping (address => uint256)  balances;
    mapping (address => mapping (address => uint256)) public allowance;

    event Transfer(address indexed from, address indexed to, uint256 value);

  

   
     function TokenERC20(
     uint256 Intialsupply,
     string Token_Name,
     string _symbol
       
    ) public {
        _totalSupply = Intialsupply * 10 ** uint256(decimals);  // Update total supply with the decimal amount
        balances[msg.sender] = _totalSupply;                // Give the creator all initial tokens
        name = Token_Name;                                   // Set the name for display purposes
        symbol = _symbol;                               // Set the symbol for display purposes
    }

   function totalSupply() external view returns (uint) {
        return _totalSupply;
    }
    
     function balanceOf(address _who )public view returns (uint256 balance){
         
         return balances[_who];
         
     }
     
   function transfer(address _to, uint256 _value) public returns (bool success) {
  
        if (balances[msg.sender] >= _value && _value > 0) {
            balances[msg.sender] -= _value;
            balances[_to] += _value;
            Transfer(msg.sender, _to, _value);
            return true;
        } else { return false; }
    }
  


    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {
     
        if (balances[_from] >= _value && allowance[_from][msg.sender] >= _value && _value > 0) {
            balances[_to] += _value;
            balances[_from] -= _value;
            allowance[_from][msg.sender] -= _value;
            Transfer(_from, _to, _value);
            return true;
        } else { return false; }
    }

   
    function approve(address _spender, uint256 _value) public
        returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        return true;
    }

  

   
}


