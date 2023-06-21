pragma solidity ^0.5.10;

















library SafeMath {
    function add(uint a, uint b) internal pure returns(uint c) {
        c = a + b;
        require(c >= a);
    }
    function sub(uint a, uint b) internal pure returns(uint c) {
        require(b <= a);
        c = a - b;
    }
    function mul(uint a, uint b) internal pure returns(uint c) {
        c = a * b;
        require(a == 0 || c / a == b);
    }
    function div(uint a, uint b) internal pure returns(uint c) {
        require(b > 0);
        c = a / b;
    }
}


contract ERC20Interface {
    function totalSupply() public view returns(uint);
    function balanceOf(address tokenOwner) public view returns(uint balance);
    function allowance(address tokenOwner, address spender) public view returns(uint remaining);
    function transfer(address to, uint tokens) public returns(bool success);
    function approve(address spender, uint tokens) public returns(bool success);
    function transferFrom(address from, address to, uint tokens) public returns(bool success);
    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}

contract LockMyTokens {

    using SafeMath for uint;
    
    address constant tokenContract = 0xE6DC77fA9886e12774CB2c4ECd3dcc6E66750a45;
    uint constant PRECISION = 1000000000000000000;
    uint constant timeUntilUnlocked = 365 days;         
    uint constant maxWithdrawalAmount = 1 * PRECISION;  
    uint constant timeBetweenWithdrawals = 7 days;
    uint unfreezeDate;

	mapping (address => uint) balance;
	mapping (address => uint) lastWithdrawal;

    event TokensFrozen (
        address indexed addr,
        uint256 amt,
        uint256 time
	);

    event TokensUnfrozen (
        address indexed addr,
        uint256 amt,
        uint256 time
	);

    constructor() public {
        unfreezeDate = now + timeUntilUnlocked;
    }

    function withdraw(uint _amount) public {
        require(balance[msg.sender] >= _amount, "You do not have enough tokens!");
        require(now >= unfreezeDate, "Tokens are locked!");
        require(_amount <= maxWithdrawalAmount, "Trying to withdraw too much at once!");
        require(now >= lastWithdrawal[msg.sender] + timeBetweenWithdrawals, "Trying to withdraw too frequently!");
        require(ERC20Interface(tokenContract).transfer(msg.sender, _amount), "Could not withdraw tokens!");

        balance[msg.sender] -= _amount;
        lastWithdrawal[msg.sender] = now;
        emit TokensUnfrozen(msg.sender, _amount, now);
    }

    function getBalance(address _addr) public view returns (uint256 _balance) {
        return balance[_addr];
    }
    
    function getLastWithdrawal(address _addr) public view returns (uint256 _lastWithdrawal) {
        return lastWithdrawal[_addr];
    }
   
    function getTimeLeft() public view returns (uint256 _timeLeft) {
        require(unfreezeDate > now, "The future is here!");
        return unfreezeDate - now;
    } 
    
    function onApprovalReceived(address _sender, uint256 _value, bytes memory _extraData) public returns(bytes4) {
        require(msg.sender == tokenContract, "Can only deposit GRT into this contract!");
        require(ERC20Interface(tokenContract).transferFrom(_sender, address(this), _value), "Could not transfer GRT to Time Lock contract address.");

        balance[_sender] += _value;
        emit TokensFrozen(_sender, _value, now);
        return 0x7b04a2d0;
    }
    
    function onTransferReceived(address _operator, address _sender, uint256 _value, bytes memory _extraData) public returns(bytes4) {
        require(msg.sender == tokenContract, "Can only deposit GRT into this contract!");

        balance[_sender] += _value;
        emit TokensFrozen(_sender, _value, now);
        return 0x88a7ca5c;
    }
}