const { network } = require('hardhat');
const { developmentChains } = require('../helper-hardhat-config');
const { verify } = require('../utils/verify');

module.exports = async ({ getNamedAccounts, deployments }) => {
    const { deploy, log } = deployments;
    const { deployer } = await getNamedAccounts();

    log('----------------------------------------------------');
    arguments = [];
    const priceRelatedNFT = await deploy('BasicNft', {
        from: deployer,
        args: arguments,
        log: true,
        waitConfirmations: network.config.blockConfirmations || 1,
    });

    // Verify the deployment
    if (
        !developmentChains.includes(network.name) &&
        process.env.BSCSCAN_API_KEY
    ) {
        log('Verifying...');
        await verify(priceRelatedNFT.address, arguments);
    }
};

module.exports.tags = ['all', 'priceRelatedNFT', 'main'];
