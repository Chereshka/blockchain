import { ethers } from "hardhat";
import { run } from "hardhat";

import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";


import { ERC721Collection__factory } from "../typechain-types";

async function main() {
  let owner: SignerWithAddress

  [owner] = await ethers.getSigners();

  const ercContract = await new ERC721Collection__factory(owner).deploy();
  await ercContract.deployed();
  await ercContract.deployTransaction.wait();

  console.log("ERC721Collection.address:", ercContract.address)

  await run("verify:verify", {
    address: ercContract.address,
    constructorArguments: [],
  });
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
