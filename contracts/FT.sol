import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract FT is ERC20 {	contract FT is ERC20 {
    constructor(string memory name, string memory symbol) ERC20(name, symbol) {	    address _owner = msg.sender; 
    constructor(string memory name, string memory symbol) ERC20(name, symbol) { 
    }	    }


    // TODO 实现mint的权限控制，只有owner可以mint	    // TODO 实现mint的权限控制，只有owner可以mint
    function mint(address account, uint256 amount) external {	    function mint(address account, uint256 amount) external {

        require(account != address(0),"mint to zero address");
        require(account == msg.sender,"mint can't be created");
        _mint(account, amount);
    }	    }


    // TODO 用户只能燃烧自己的token	    // TODO 用户只能燃烧自己的token
    function burn(uint256 amount) external {	    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }
    bool isStopped = false;
    modifier stopped {
        require(!isStopped);
        _;
    }
    modifier onlyAuthorized {
        require(msg.sender == _owner);
        _;
    }


    function stopTransFer() public onlyAuthorized {
        isStopped = true;
    }	    }


    // TODO 加分项：实现transfer可以暂停的逻辑	    function resumeTransFer() public onlyAuthorized {
        isStopped = false;
    }

    function transfer(address to, uint256 amount) public virtual override stopped returns (bool){
        address owner = msg.sender;
        _transfer(owner, to, amount);
        return true;
    }
}	}