// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  const [owner, otherAccount] = await ethers.getSigners();

  const W3s = await hre.ethers.getContractFactory("W3s");
  const w3s = await W3s.deploy();

  await w3s.deployed();
  console.log("contract address:", w3s.address);
  // console.log("start mint=======================");

  // const m = await w3s.connect(otherAccount).publicMint("cid111", '{"name":"asdasd"}', { value: ethers.utils.parseEther('0.01') });
  // console.log(await w3s.connect(otherAccount).tokenURI(0));
  // const balance = await w3s.connect(otherAccount).balanceOf(otherAccount.address);
  // console.log(balance);
  // const tokenURI = await w3s.connect(otherAccount).getTokenURI();
  // console.log(tokenURI);
  // await w3s.transfer("0xB315fBA4A6514100BdceA5C438E89dd9dd9F216F", ethers.utils.parseEther('1'))

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
