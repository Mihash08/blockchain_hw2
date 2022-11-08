require("@nomiclabs/hardhat-ethers")
require("@nomiclabs/hardhat-waffle")

require("dotenv").config();

const pKey = process.env.PRIVATE_KEY;
const end_url = process.env.URL;
const api = process.env.API;

module.exports = {
  solidity: {
    version: "0.8.8"
  },
  networks: {
    goerli: { 
      url: `${end_url}${api}`,
      account: [pKey]
    }
  }
}