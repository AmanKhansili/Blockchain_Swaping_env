# Local MockUSDC demo

This is for local Hardhat testing only. The token is not real USDC and this is not a DEX swap.
The demo contract receives ETH and mints the quoted amount of mock USDC; the ETH stays in the contract.

## Start fresh
1. Stop any running Hardhat node with Ctrl+C.
2. If `ignition/deployments` exists from an older deployment, delete that folder so the updated contract is deployed.
3. In this folder run `npm install`.
4. Terminal 1: `npx hardhat node --hostname 0.0.0.0`
5. Terminal 2: `npx hardhat compile`
6. Terminal 2: `npx hardhat ignition deploy ignition/modules/MockUSDC.ts --network localhost`
7. Copy the printed MockUSDC address into `src/services/cryptoService.ts` at `TOKENS_CONFIG` -> USDC -> `contractAddress` and keep the same address in the transaction service only if your source still has a hard-coded address (the supplied fixed source reads it from TOKENS_CONFIG).

The app RPC URL must be the computer's reachable LAN IPv4 address, port 8545. The supplied source uses `http://10.60.222.200:8545`; change it if your LAN IP changes.

For the swap transaction, the app's saved private key must match its connected address and be a funded Hardhat test account (e.g. Account #0/#1/#2 from the node output). Never use Hardhat demo keys or this contract with real funds.
