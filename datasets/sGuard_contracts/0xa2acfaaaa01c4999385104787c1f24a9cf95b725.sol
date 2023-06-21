pragma solidity ^0.5.5;


library Address {
    
    function isContract(address account) internal view returns (bool) {
        
        
        
        bytes32 codehash;


            bytes32 accountHash
         = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
        
        assembly {
            codehash := extcodehash(account)
        }
        return (codehash != accountHash && codehash != 0x0);
    }

    
    function toPayable(address account)
        internal
        pure
        returns (address payable)
    {
        return address(uint160(account));
    }

    
    function sendValue(address payable recipient, uint256 amount) internal {
        require(
            address(this).balance >= amount,
            "Address: insufficient balance"
        );

        
        (bool success, ) = recipient.call.value(amount)("");
        require(
            success,
            "Address: unable to send value, recipient may have reverted"
        );
    }
}




interface IERC20 {
    
    function totalSupply() external view returns (uint256);

    
    function balanceOf(address account) external view returns (uint256);

    
    function transfer(address recipient, uint256 amount)
        external
        returns (bool);

    
    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

    
    function approve(address spender, uint256 amount) external returns (bool);

    
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    
    event Transfer(address indexed from, address indexed to, uint256 value);

    
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}




contract Context {
    
    
    constructor() internal {}

    

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

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    
    constructor() internal {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    
    function owner() public view returns (address) {
        return _owner;
    }

    
    modifier onlyOwner() {
        require(isOwner(), "Ownable: caller is not the owner");
        _;
    }

    
    function isOwner() public view returns (bool) {
        return _msgSender() == _owner;
    }

    
    function renounceOwnership() public onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    
    function transferOwnership(address newOwner) public onlyOwner {
        _transferOwnership(newOwner);
    }

    
    function _transferOwnership(address newOwner) internal {
        require(
            newOwner != address(0),
            "Ownable: new owner is the zero address"
        );
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}




contract ReentrancyGuard {
    bool private _notEntered;

    constructor() internal {
        
        
        
        
        
        
        _notEntered = true;
    }

    
    modifier nonReentrant() {
        
        require(_notEntered, "ReentrancyGuard: reentrant call");

        
        _notEntered = false;

        _;

        
        
        _notEntered = true;
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

    
    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
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

    
    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        
        require(b > 0, errorMessage);
        uint256 c = a / b;
        

        return c;
    }

    
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    
    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

interface IBFactory {
    function isBPool(address b) external view returns (bool);
}

interface IBPool {
    function joinswapExternAmountIn(
        address tokenIn,
        uint256 tokenAmountIn,
        uint256 minPoolAmountOut
    ) external payable returns (uint256 poolAmountOut);

    function isBound(address t) external view returns (bool);

    function getFinalTokens() external view returns (address[] memory tokens);

    function totalSupply() external view returns (uint256);

    function getDenormalizedWeight(address token)
        external
        view
        returns (uint256);

    function getTotalDenormalizedWeight() external view returns (uint256);

    function getSwapFee() external view returns (uint256);

    function calcPoolOutGivenSingleIn(
        uint256 tokenBalanceIn,
        uint256 tokenWeightIn,
        uint256 poolSupply,
        uint256 totalWeight,
        uint256 tokenAmountIn,
        uint256 swapFee
    ) external pure returns (uint256 poolAmountOut);

    function getBalance(address token) external view returns (uint256);
}

interface IWETH {
    function deposit() external payable;

    function transfer(address to, uint256 value) external returns (bool);

    function withdraw(uint256) external;
}

library TransferHelper {
    function safeApprove(
        address token,
        address to,
        uint256 value
    ) internal {
        
        (bool success, bytes memory data) = token.call(
            abi.encodeWithSelector(0x095ea7b3, to, value)
        );
        require(
            success && (data.length == 0 || abi.decode(data, (bool))),
            "TransferHelper: APPROVE_FAILED"
        );
    }

    function safeTransfer(
        address token,
        address to,
        uint256 value
    ) internal {
        
        (bool success, bytes memory data) = token.call(
            abi.encodeWithSelector(0xa9059cbb, to, value)
        );
        require(
            success && (data.length == 0 || abi.decode(data, (bool))),
            "TransferHelper: TRANSFER_FAILED"
        );
    }

    function safeTransferFrom(
        address token,
        address from,
        address to,
        uint256 value
    ) internal {
        
        (bool success, bytes memory data) = token.call(
            abi.encodeWithSelector(0x23b872dd, from, to, value)
        );
        require(
            success && (data.length == 0 || abi.decode(data, (bool))),
            "TransferHelper: TRANSFER_FROM_FAILED"
        );
    }
}

interface IUniswapV2Factory {
    function getPair(address tokenA, address tokenB)
        external
        view
        returns (address);
}

interface IUniswapRouter02 {
    
    function getAmountsOut(uint256 amountIn, address[] calldata path)
        external
        view
        returns (uint256[] memory amounts);

    function getAmountsIn(uint256 amountOut, address[] calldata path)
        external
        view
        returns (uint256[] memory amounts);

    
    function swapExactTokensForTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapTokensForExactTokens(
        uint256 amountOut,
        uint256 amountInMax,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    
    function swapExactETHForTokens(
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable returns (uint256[] memory amounts);

    function swapETHForExactTokens(
        uint256 amountOut,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable returns (uint256[] memory amounts);

    
    function swapTokensForExactETH(
        uint256 amountOut,
        uint256 amountInMax,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapExactTokensForETH(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);
}

contract Balancer_ZapIn_General_V2_5 is ReentrancyGuard, Ownable {
    using SafeMath for uint256;
    using Address for address;
    bool public stopped = false;
    uint16 public goodwill;

    IBFactory BalancerFactory = IBFactory(
        0x9424B1412450D0f8Fc2255FAf6046b98213B76Bd
    );
    IUniswapV2Factory
        private constant UniSwapV2FactoryAddress = IUniswapV2Factory(
        0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f
    );
    IUniswapRouter02 private constant uniswapRouter = IUniswapRouter02(
        0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D
    );

    address
        private constant wethTokenAddress = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    address
        private constant dzgoodwillAddress = 0xE737b6AfEC2320f616297e59445b60a11e3eF75F;

    uint256
        private constant deadline = 0xf000000000000000000000000000000000000000000000000000000000000000;

    event Zapin(
        address _toWhomToIssue,
        address _toBalancerPoolAddress,
        uint256 _OutgoingBPT
    );

    constructor(uint16 _goodwill) public {
        goodwill = _goodwill;
    }

    
    modifier stopInEmergency {
        if (stopped) {
            revert("Temporarily Paused");
        } else {
            _;
        }
    }

    
    function EasyZapIn(
        address _FromTokenContractAddress,
        address _ToBalancerPoolAddress,
        uint256 _amount,
        uint256 _minPoolTokens
    )
        public
        payable
        nonReentrant
        stopInEmergency
        returns (uint256 tokensBought)
    {
        require(
            BalancerFactory.isBPool(_ToBalancerPoolAddress),
            "Invalid Balancer Pool"
        );

        if (_FromTokenContractAddress == address(0)) {
            require(msg.value > 0, "ERR: No ETH sent");

            address _IntermediateToken = _getBestDeal(
                _ToBalancerPoolAddress,
                msg.value,
                _FromTokenContractAddress
            );

            tokensBought = _performZapIn(
                msg.sender,
                _FromTokenContractAddress,
                _ToBalancerPoolAddress,
                msg.value,
                _IntermediateToken,
                _minPoolTokens
            );

            return tokensBought;
        }

        require(_amount > 0, "ERR: No ERC sent");
        require(msg.value == 0, "ERR: ETH sent with tokens");

        
        TransferHelper.safeTransferFrom(
            _FromTokenContractAddress,
            msg.sender,
            address(this),
            _amount
        );

        address _IntermediateToken = _getBestDeal(
            _ToBalancerPoolAddress,
            _amount,
            _FromTokenContractAddress
        );

        tokensBought = _performZapIn(
            msg.sender,
            _FromTokenContractAddress,
            _ToBalancerPoolAddress,
            _amount,
            _IntermediateToken,
            _minPoolTokens
        );
    }

    
    function _performZapIn(
        address _toWhomToIssue,
        address _FromTokenContractAddress,
        address _ToBalancerPoolAddress,
        uint256 _amount,
        address _IntermediateToken,
        uint256 _minPoolTokens
    ) internal returns (uint256 tokensBought) {
        
        bool isBound = IBPool(_ToBalancerPoolAddress).isBound(
            _FromTokenContractAddress
        );

        uint256 balancerTokens;

        if (isBound) {
            balancerTokens = _enter2Balancer(
                _ToBalancerPoolAddress,
                _FromTokenContractAddress,
                _amount,
                _minPoolTokens
            );
        } else {
            
            uint256 tokenBought;
            if (_FromTokenContractAddress == address(0)) {
                tokenBought = _eth2Token(_IntermediateToken);
            } else {
                tokenBought = _token2Token(
                    _FromTokenContractAddress,
                    _IntermediateToken,
                    _amount
                );
            }

            
            balancerTokens = _enter2Balancer(
                _ToBalancerPoolAddress,
                _IntermediateToken,
                tokenBought,
                _minPoolTokens
            );
        }

        
        uint256 goodwillPortion = _transferGoodwill(
            _ToBalancerPoolAddress,
            balancerTokens
        );

        emit Zapin(
            _toWhomToIssue,
            _ToBalancerPoolAddress,
            SafeMath.sub(balancerTokens, goodwillPortion)
        );

        
        TransferHelper.safeTransfer(
            _ToBalancerPoolAddress,
            _toWhomToIssue,
            SafeMath.sub(balancerTokens, goodwillPortion)
        );
        return SafeMath.sub(balancerTokens, goodwillPortion);
    }

    
    function _enter2Balancer(
        address _ToBalancerPoolAddress,
        address _FromTokenContractAddress,
        uint256 tokens2Trade,
        uint256 _minPoolTokens
    ) internal returns (uint256 poolTokensOut) {
        require(
            IBPool(_ToBalancerPoolAddress).isBound(_FromTokenContractAddress),
            "Token not bound"
        );

        uint256 allowance = IERC20(_FromTokenContractAddress).allowance(
            address(this),
            _ToBalancerPoolAddress
        );

        if (allowance < tokens2Trade) {
            TransferHelper.safeApprove(
                _FromTokenContractAddress,
                _ToBalancerPoolAddress,
                uint256(-1)
            );
        }

        poolTokensOut = IBPool(_ToBalancerPoolAddress).joinswapExternAmountIn(
            _FromTokenContractAddress,
            tokens2Trade,
            _minPoolTokens
        );

        require(poolTokensOut > 0, "Error in entering balancer pool");
    }

    
    function _getBestDeal(
        address _ToBalancerPoolAddress,
        uint256 _amount,
        address _FromTokenContractAddress
    ) internal view returns (address _token) {
        
        if (
            _FromTokenContractAddress != address(0) &&
            _FromTokenContractAddress != wethTokenAddress
        ) {
            
            bool isBound = IBPool(_ToBalancerPoolAddress).isBound(
                _FromTokenContractAddress
            );
            if (isBound) return _FromTokenContractAddress;
        }

        bool wethIsBound = IBPool(_ToBalancerPoolAddress).isBound(
            wethTokenAddress
        );
        if (wethIsBound) return wethTokenAddress;

        
        address[] memory tokens = IBPool(_ToBalancerPoolAddress)
            .getFinalTokens();

        uint256 amount = _amount;
        address[] memory path = new address[](2);

        if (
            _FromTokenContractAddress != address(0) &&
            _FromTokenContractAddress != wethTokenAddress
        ) {
            path[0] = _FromTokenContractAddress;
            path[1] = wethTokenAddress;
            
            amount = uniswapRouter.getAmountsOut(_amount, path)[1];
        }

        uint256 maxBPT;
        path[0] = wethTokenAddress;

        for (uint256 index = 0; index < tokens.length; index++) {
            uint256 expectedBPT;

            if (tokens[index] != wethTokenAddress) {
                if (
                    UniSwapV2FactoryAddress.getPair(
                        tokens[index],
                        wethTokenAddress
                    ) == address(0)
                ) {
                    continue;
                }

                
                path[1] = tokens[index];
                uint256 expectedTokens = uniswapRouter.getAmountsOut(
                    amount,
                    path
                )[1];

                
                expectedBPT = getToken2BPT(
                    _ToBalancerPoolAddress,
                    expectedTokens,
                    tokens[index]
                );

                
                if (maxBPT < expectedBPT) {
                    maxBPT = expectedBPT;
                    _token = tokens[index];
                }
            } else {
                
                expectedBPT = getToken2BPT(
                    _ToBalancerPoolAddress,
                    amount,
                    tokens[index]
                );
            }

            
            if (maxBPT < expectedBPT) {
                maxBPT = expectedBPT;
                _token = tokens[index];
            }
        }
    }

    
    function getToken2BPT(
        address _ToBalancerPoolAddress,
        uint256 _IncomingERC,
        address _FromToken
    ) internal view returns (uint256 tokensReturned) {
        uint256 totalSupply = IBPool(_ToBalancerPoolAddress).totalSupply();
        uint256 swapFee = IBPool(_ToBalancerPoolAddress).getSwapFee();
        uint256 totalWeight = IBPool(_ToBalancerPoolAddress)
            .getTotalDenormalizedWeight();
        uint256 balance = IBPool(_ToBalancerPoolAddress).getBalance(_FromToken);
        uint256 denorm = IBPool(_ToBalancerPoolAddress).getDenormalizedWeight(
            _FromToken
        );

        tokensReturned = IBPool(_ToBalancerPoolAddress)
            .calcPoolOutGivenSingleIn(
            balance,
            denorm,
            totalSupply,
            totalWeight,
            _IncomingERC,
            swapFee
        );
    }

    
    function _eth2Token(address _tokenContractAddress)
        internal
        returns (uint256 tokenBought)
    {
        if (_tokenContractAddress == wethTokenAddress) {
            IWETH(wethTokenAddress).deposit.value(msg.value)();
            return msg.value;
        }

        address[] memory path = new address[](2);
        path[0] = wethTokenAddress;
        path[1] = _tokenContractAddress;
        tokenBought = uniswapRouter.swapExactETHForTokens.value(msg.value)(
            1,
            path,
            address(this),
            deadline
        )[path.length - 1];
    }

    
    function _token2Token(
        address _FromTokenContractAddress,
        address _ToTokenContractAddress,
        uint256 tokens2Trade
    ) public returns (uint256 tokenBought) {
        TransferHelper.safeApprove(
            _FromTokenContractAddress,
            address(uniswapRouter),
            tokens2Trade
        );

        if (_FromTokenContractAddress != wethTokenAddress) {
            if (_ToTokenContractAddress != wethTokenAddress) {
                address[] memory path = new address[](3);
                path[0] = _FromTokenContractAddress;
                path[1] = wethTokenAddress;
                path[2] = _ToTokenContractAddress;
                tokenBought = uniswapRouter.swapExactTokensForTokens(
                    tokens2Trade,
                    1,
                    path,
                    address(this),
                    deadline
                )[path.length - 1];
            } else {
                address[] memory path = new address[](2);
                path[0] = _FromTokenContractAddress;
                path[1] = wethTokenAddress;

                tokenBought = uniswapRouter.swapExactTokensForTokens(
                    tokens2Trade,
                    1,
                    path,
                    address(this),
                    deadline
                )[path.length - 1];
            }
        } else {
            address[] memory path = new address[](2);
            path[0] = wethTokenAddress;
            path[1] = _ToTokenContractAddress;
            tokenBought = uniswapRouter.swapExactTokensForTokens(
                tokens2Trade,
                1,
                path,
                address(this),
                deadline
            )[path.length - 1];
        }

        require(tokenBought > 0, "Error in swapping ERC: 1");
    }

    
    function _transferGoodwill(
        address _tokenContractAddress,
        uint256 tokens2Trade
    ) internal returns (uint256 goodwillPortion) {
        goodwillPortion = SafeMath.div(
            SafeMath.mul(tokens2Trade, goodwill),
            10000
        );

        if (goodwillPortion == 0) {
            return 0;
        }

        TransferHelper.safeTransfer(
            _tokenContractAddress,
            dzgoodwillAddress,
            goodwillPortion
        );
    }

    function set_new_goodwill(uint16 _new_goodwill) public onlyOwner {
        require(
            _new_goodwill >= 0 && _new_goodwill < 10000,
            "GoodWill Value not allowed"
        );
        goodwill = _new_goodwill;
    }

    function inCaseTokengetsStuck(IERC20 _TokenAddress) public onlyOwner {
        uint256 qty = _TokenAddress.balanceOf(address(this));
        TransferHelper.safeTransfer(address(_TokenAddress), owner(), qty);
    }

    
    function toggleContractActive() public onlyOwner {
        stopped = !stopped;
    }

    
    function withdraw() public onlyOwner {
        uint256 contractBalance = address(this).balance;
        address payable _to = owner().toPayable();
        _to.transfer(contractBalance);
    }

    function() external payable {}
}