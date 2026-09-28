import hre from "hardhat";

async function main() {
  console.log("Deploying MockUSDC...");
  
  // Type assertion use karke viem ko access karo
  const viem = (hre as any).viem;
  const mockUSDC = await viem.deployContract("MockUSDC");

  console.log(`MockUSDC deployed to: ${mockUSDC.address}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});