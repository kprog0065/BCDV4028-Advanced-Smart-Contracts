const TimeLockedContract = artifacts.require("TimeLockedContract");
const { timeTravel } = require("ganache-time-traveller");

contract("TimeLockedContract", (accounts) => {
    it("should unlock the feature after the specified time", async () => {
        const contractInstance = await TimeLockedContract.deployed();
        const owner = accounts[0];

        // Get the current timestamp
        const initialTimestamp = await web3.eth.getBlock("latest").timestamp;

        // Deploy the contract with a 5-minute lock time
        await contractInstance.constructor(5, { from: owner });

        // Advance time by 10 minutes
        await timeTravel(10 * 60); // 10 minutes in seconds

        // Try to unlock the feature
        await contractInstance.unlockFeature({ from: owner });

        // Check if the feature is unlocked
        const featureUnlocked = await contractInstance.featureUnlocked();
        assert.equal(featureUnlocked, true, "Feature should be unlocked");
    });
});
