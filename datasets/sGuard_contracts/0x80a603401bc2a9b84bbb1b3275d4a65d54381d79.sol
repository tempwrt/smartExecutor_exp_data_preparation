pragma solidity 0.5.17;


contract IERC20 {
    string public name;
    uint8 public decimals;
    string public symbol;
    function totalSupply() public view returns (uint256);
    function balanceOf(address _who) public view returns (uint256);
    function allowance(address _owner, address _spender) public view returns (uint256);
    function approve(address _spender, uint256 _value) public returns (bool);
    function transfer(address _to, uint256 _value) public returns (bool);
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}


contract Context {
    
    
    constructor () internal { }
    

    function _msgSender() internal view returns (address payable) {
        return msg.sender;
    }

    function _msgData() internal view returns (bytes memory) {
        this; 
        return msg.data;
    }
}


contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    
    constructor () internal {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    
    function owner() public view returns (address) {
        return _owner;
    }

    
    modifier onlyOwner() {
        require(isOwner(), "unauthorized");
        _;
    }

    
    function isOwner() public view returns (bool) {
        return _msgSender() == _owner;
    }

    
    function transferOwnership(address newOwner) public onlyOwner {
        _transferOwnership(newOwner);
    }

    
    function _transferOwnership(address newOwner) internal {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}


library SafeMath {
    
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        
        
        
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        
        require(b > 0, errorMessage);
        uint256 c = a / b;
        

        return c;
    }

    
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }

    function min256(uint256 _a, uint256 _b) internal pure returns (uint256) {
        return _a < _b ? _a : _b;
    }
}

interface iETHBuyBackV1 {
    function transferOwnership(
        address _newOwner)
        external;

    function setWhitelist(
        address[] calldata addrs,
        uint256[] calldata amounts)
        external;

    function whitelist(
        address _buyer)
        external
        view
        returns (uint256);

    function iETHSold()
        external
        view
        returns (uint256);

    function vBZRXBought()
        external
        view
        returns (uint256);
}

contract iETHBuyBackV2 is Ownable {
    using SafeMath for uint256;

    IERC20 public constant iETH = IERC20(0x77f973FCaF871459aa58cd81881Ce453759281bC);
    IERC20 public constant vBZRX = IERC20(0xB72B31907C1C95F3650b64b2469e08EdACeE5e8F);
    iETHBuyBackV1 internal constant v1 = iETHBuyBackV1(0x85A25f18ba56163450d597E521c7A79F552c93d2);

    uint256 public iETHSwapRate;
    uint256 public iETHSwapRateWL;

    bool public isActive = true;
    uint256 public iETHSold;
    uint256 public vBZRXBought;

    constructor(
        uint256 _iETHSwapRate,
        uint256 _iETHSwapRateWL,
        address _newOwner)
        public
    {
        iETHSwapRate = _iETHSwapRate;
        iETHSwapRateWL = _iETHSwapRateWL;

        if (msg.sender != _newOwner) {
            transferOwnership(_newOwner);
        }

        iETHSold = v1.iETHSold();
        vBZRXBought = v1.vBZRXBought();
    }

    function convert(
        uint256 _tokenAmount)
        public
    {
        uint256 whitelistAmount = whitelist(msg.sender);
        bool isWhiteListed = whitelistAmount != 0;

        uint256 swapRate;
        if (isWhiteListed) {
            if (_tokenAmount > whitelistAmount) {
                _tokenAmount = whitelistAmount;
            }
            swapRate = iETHSwapRateWL;
        } else {
            swapRate = iETHSwapRate;
        }

        require(swapRate != 0 && _tokenAmount != 0 && isActive, "swap not allowed");

        uint256 buyAmount = _tokenAmount
            .mul(10**18)
            .div(swapRate);

        iETH.transferFrom(
            msg.sender,
            address(this),
            _tokenAmount
        );

        vBZRX.transfer(
            msg.sender,
            buyAmount
        );

        
        iETHSold += _tokenAmount;
        vBZRXBought += buyAmount;

        if (isWhiteListed) {
            address[] memory addrs = new address[](1);
            addrs[0] = msg.sender;

            uint256[] memory amounts = new uint256[](1);
            amounts[0] = whitelistAmount - _tokenAmount;

            v1.setWhitelist(
                addrs,
                amounts
            );
        }
    }

    function setWhitelist(
        address[] memory addrs,
        uint256[] memory amounts)
        public
        onlyOwner
    {
        v1.setWhitelist(
            addrs,
            amounts
        );
    }

    function transferV1Ownership(
        address _newOwner)
        public
        onlyOwner
    {
        v1.transferOwnership(_newOwner);
    }

    function setActive(
        bool _isActive)
        public
        onlyOwner
    {
        isActive = _isActive;
    }

    function withdrawVBZRX(
        uint256 _amount)
        public
        onlyOwner
    {
        uint256 balance = vBZRX.balanceOf(address(this));
        if (_amount > balance) {
            _amount = balance;
        }

        if (_amount != 0) {
            vBZRX.transfer(
                msg.sender,
                _amount
            );
        }
    }

    function withdrawIETH(
        uint256 _amount)
        public
        onlyOwner
    {
        uint256 balance = iETH.balanceOf(address(this));
        if (_amount > balance) {
            _amount = balance;
        }

        if (_amount != 0) {
            iETH.transfer(
                msg.sender,
                _amount
            );
        }
    }

    function setiETHSwapRates(
        uint256 _newRate,
        uint256 _newRateWL)
        external
        onlyOwner
    {
        iETHSwapRate = _newRate;
        iETHSwapRateWL = _newRateWL;
    }

    function iETHSwapRateWithCheck(
        address _buyer)
        public
        view
        returns (uint256)
    {
        if (whitelist(_buyer) != 0) {
            return iETHSwapRateWL;
        } else {
            return iETHSwapRate;
        }
    }

    function whitelist(
        address _buyer)
        public
        view
        returns (uint256)
    {
        return v1.whitelist(_buyer);
    }
}