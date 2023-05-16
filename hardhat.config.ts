import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const config: HardhatUserConfig = {
  solidity: "0.8.9",
  networks: {
    bscTestNet: {
      url: "https://data-seed-prebsc-1-s1.binance.org:8545",
      accounts: [
        "663cf342fd38e5a7684ed62ad34e1ca6ea8f7a7cd95ae5ee184c304516a6bb9e"
      ]
    }
  },
  etherscan: {
    apiKey: {
      bscTestnet: "KMEIHA8TP44N2GBE3GBIHCKGDU6747TGB8",
    },
  },
};

export default config;
