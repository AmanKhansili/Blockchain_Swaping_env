import { network } from "hardhat";

async function main() {
  console.log("Deploying MockUSDC...");

  // Network connection create karke viem instance nikalein
  const { viem } = await network.create();
  
  const mockUSDC = await viem.deployContract("MockUSDC");

  console.log(`MockUSDC deployed to: ${mockUSDC.address}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});