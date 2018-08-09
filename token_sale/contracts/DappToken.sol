pragma solidity ^0.4.23;

contract DappToken {

	string public name = "DApp Token";
	string public symbol = "DAPP";
	string public standard = "DApp Token v1.0";
	uint256 public totalSupply;

	// transfer event
	event Transfer(
		address indexed _from,
		address indexed _to,
		uint256 _value
	);

	// approve event
	event Approval(
		address indexed _owner,
		address indexed _spender,
		uint256 _value
	);

	// balanceOf
	mapping(address => uint256) public balanceOf;
	// allow
	mapping(address => mapping(address => uint256)) public allowance;
	
	// constructor
	function DappToken (uint256 _initialSupply) public {
		balanceOf[msg.sender] = _initialSupply;
		totalSupply = _initialSupply;
	}

	// transfer function
	function transfer(address _to, uint256 _value) public returns (bool success) {
		// Exception if account doesn't have enough
		require(balanceOf[msg.sender] >= _value);
		// Transfer the balance
		balanceOf[msg.sender] -= _value;
		balanceOf[_to] += _value;
		// Transfer Event		
		Transfer(msg.sender, _to, _value);
		// Return a boolem
		return true;
	}

	// approve function
	function approve(address _spender, uint256 _value) public returns (bool success) {
		// allowance
		allowance[msg.sender][_spender] = _value;	
		// Approve event
		Approval(msg.sender, _spender, _value);

		return true;
	}

	//trnasferFrom function
	function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
		// Require _from has enough Token
		require(_value <= balanceOf[_from]);
		// Require allowance is big enough
		require(_value <= allowance[_from][msg.sender]);
		// Change the balance
		balanceOf[_from] -= _value;
		balanceOf[_to] += _value;
		// Update the allowance
		allowance[_from][msg.sender] -= _value;
		// Transfer event
		Transfer(_from, _to, _value);
		// return a boolem
		return true;
	}

}