// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/// @notice Local Hardhat demo token. NOT real USDC and NOT for production.
contract MockUSDC is ERC20 {
    constructor() ERC20("USD Coin", "USDC") {
        _mint(msg.sender, 10000 * 10 ** decimals());
    }

    /// @notice Demo ETH -> mock USDC conversion.
    /// @dev ETH is held by this contract; no DEX or oracle is used.
    function swapEthForUSDC(
        address recipient,
        uint256 usdcAmount
    ) external payable {
        require(recipient != address(0), "Invalid recipient");
        require(msg.value > 0, "ETH amount must be greater than zero");
        require(usdcAmount > 0, "USDC amount must be greater than zero");

        _mint(recipient, usdcAmount);
    }

    /// @notice Demo mock USDC -> ETH conversion.
    /// @dev Caller specifies the ETH payout; payout is limited by contract liquidity.
    function swapUSDCForETH(
        address payable recipient,
        uint256 usdcAmount,
        uint256 ethAmount
    ) external {
        require(recipient != address(0), "Invalid recipient");
        require(usdcAmount > 0, "USDC amount must be greater than zero");
        require(ethAmount > 0, "ETH amount must be greater than zero");
        require(address(this).balance >= ethAmount, "Insufficient ETH liquidity");

        // Burn the caller's mock USDC.
        _burn(msg.sender, usdcAmount);

        // Pay ETH from this contract's existing balance.
        (bool success, ) = recipient.call{value: ethAmount}("");
        require(success, "ETH transfer failed");
    }

    /// @notice Test helper; anyone can mint in this local demo.
    function mint(address to, uint256 amount) public {
        require(to != address(0), "Invalid recipient");
        _mint(to, amount);
    }

    /// @notice Allow the local demo contract to be funded with ETH.
    receive() external payable {}
}