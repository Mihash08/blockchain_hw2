const { ethers } = require("hardhat");

const main = async () => {
  const initialSupply = ethers.utils.parseEther("100000");
  const [deployer] = await ethers.getSigners();
  console.log(`Address deploying the contract --> ${deployer.address}`);
  const tokenFactory = await ethers.getContractFactory("MyToken");
  const contract = await tokenFactory.deploy(initialSupply, "MyToken");

  console.log(`Token Contract address --> ${contract.address}`);
};
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });