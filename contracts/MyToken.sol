pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
// TODO Попробуй оставить Token, потом поменяй на MyToken
contract MyToken is IERC20 {

    uint256 public totalSupply;

    string private tokenName;

    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public allowed;

    using SafeMath for uint256;

    constructor(uint256 initialAmount, string memory _tokenName) {
        balances[msg.sender] = initialAmount;
        totalSupply = initialAmount; 
        tokenName = _tokenName;
        require(1==1, tokenName);
    }

    function getTotalSupply() external view returns (uint256) {
        return totalSupply;
    }

    function balanceOf(address tokenOwner) external view returns (uint256) {
        return balances[tokenOwner];
    }

    function name() public view returns (string memory) {
        return tokenName;
    }

    function transfer(address to, uint256 amount) external enoughBalance(msg.sender, amount) returns (bool success) {
        balances[msg.sender] = balances[msg.sender].subtract(amount);
        balances[to] = balances[to].add(amount);
        emit Transfer(msg.sender, to, amount);
        return true;
    }

    function transferFrom( address from, address to, uint256 amount) 
    external enoughBalance(from, amount) enoughAllowance(from, amount) returns (bool) {
        balances[from] = balances[from].subtract(amount);
        balances[to] = balances[to].add(amount);
        allowed[from][msg.sender] = allowed[from][msg.sender].subtract(amount);
        emit Transfer(from, to, amount);
        return true;
    }

    function approve(address spender, uint256 amount) public returns (bool) {
        allowed[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function allowance(address owner, address spender) external view returns (uint256) {
        return allowed[owner][spender];
    }

    modifier enoughBalance(address from, uint256 amount) {
        require(
            balances[from] >= amount, "token balance is lower than the amount"
        );
        _;
    }

    modifier enoughAllowance(address from, uint256 amount) {
        require(
            allowed[from][msg.sender] >= amount, "allowance is lower than the amount"
        );
        _;
    }
}

library SafeMath {
    function subtract(uint256 a, uint256 b) internal pure returns (uint256) {
        assert(b <= a);
        return a - b;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }
}