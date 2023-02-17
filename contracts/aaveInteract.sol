// license : MIT

pragma solidity ^0.6.0;

import "./IExerciceSolution.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./IPool.sol";

contract aaveUser is IExerciceSolution {
    ERC20 public aDAI;
    ERC20 public DAI;
    ERC20 public USDC;
    IPool public aaveProxy;


    constructor() public {
        aaveProxy = IPool(0x7b5C526B7F8dfdff278b4a3e045083FBA4028790);
        aDAI = ERC20(0xADD98B0342e4094Ec32f3b67Ccfd3242C876ff7a); 
        DAI = ERC20(0xBa8DCeD3512925e52FE67b1b5329187589072A55);
        USDC = ERC20(0x65aFADD39029741B3b8f0756952C74678c9cEC93);
    }
    


    function depositSomeTokens() external override {
        DAI.approve(address(aaveProxy), 1000*10**18);
        // call deposit function on aaveProxy
        aaveProxy.supply(0xBa8DCeD3512925e52FE67b1b5329187589072A55, 1000*10**18, address(this), 0);        
    }

    function borrowSomeTokens() external override {
        aaveProxy.borrow(0x65aFADD39029741B3b8f0756952C74678c9cEC93, 400*10**6, 2, 0, address(this));
    }
    
    function repaySomeTokens() external override {
        USDC.approve(address(aaveProxy), 401*10**6);
        aaveProxy.repay(0x65aFADD39029741B3b8f0756952C74678c9cEC93, 401*10**6, 2, address(this));
    }

	function withdrawSomeTokens() external override {
        aaveProxy.withdraw(0xBa8DCeD3512925e52FE67b1b5329187589072A55, 1000*10**18, address(this));
    }

	function doAFlashLoan() external override {
        uint256 a = 1;
    }

	function repayFlashLoan() external override {
        uint256 a = 1;
    }

    function withdrawDai() external {
        DAI.transfer(msg.sender, DAI.balanceOf(address(this)));
    }
}
