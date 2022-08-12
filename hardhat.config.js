require('@nomiclabs/hardhat-waffle');
require('hardhat-gas-reporter');
require('@nomiclabs/hardhat-etherscan');
require('dotenv').config();
require('solidity-coverage');
require('hardhat-deploy');
// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more
/**
 * @type import('hardhat/config').HardhatUserConfig
 */

const RINKEBY_RPC_URL =
    process.env.RINKEBY_RPC_URL ||
    'https://eth-rinkeby.alchemyapi.io/v2/your-api-key';
const RINKEBY_PRIVATE_KEY = process.env.RINKEBY_PRIVATE_KEY || '';
const BSCTEST_PRIVATE_KEY = process.env.BSCTEST_PRIVATE_KEY || '';
const BSC_PRIVATE_KEY = process.env.BSC_PRIVATE_KEY || '';
const BSCSCAN_API_KEY = process.env.ETHERSCAN_API_KEY || '';

module.exports = {
    defaultNetwork: 'hardhat',
    networks: {
        hardhat: {
            chainId: 31337,
            // gasPrice: 130000000000,
        },
        rinkeby: {
            url: RINKEBY_RPC_URL,
            accounts: [RINKEBY_PRIVATE_KEY],
            chainId: 4,
            blockConfirmations: 6,
        },
        bsc: {
            url: 'https://bsc-dataseed.binance.org/',
            chainId: 56,
            gasPrice: 1000000000,
            accounts: [BSC_PRIVATE_KEY],
        },
        bsctestnet: {
            url: 'https://data-seed-prebsc-2-s3.binance.org:8545/',
            chainId: 97,
            accounts: [BSCTEST_PRIVATE_KEY],
        },
    },
    solidity: {
        compilers: [
            {
                version: '0.8.8',
            },
            {
                version: '0.6.6',
            },
        ],
    },
    etherscan: {
        apiKey: BSCSCAN_API_KEY,
    },
    gasReporter: {
        enabled: true,
        currency: 'USD',
        outputFile: 'gas-report.txt',
        noColors: true,
    },
    namedAccounts: {
        deployer: {
            default: 0, // here this will by default take the first account as deployer
            1: 0, // similarly on mainnet it will take the first account as deployer. Note though that depending on how hardhat network are configured, the account 0 on one network can be different than on another
        },
    },
    mocha: {
        timeout: 200000, // 200 seconds max for running tests
    },
};
