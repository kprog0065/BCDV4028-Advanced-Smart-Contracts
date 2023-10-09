const BridgeContract1 = artifacts.require("BridgeContract1");
const TokenContract1 = artifacts.require("TokenContract1");

contract("BridgeContract1", (accounts) => {
    let bridgeContract1;
    let tokenContract1;
    const owner = accounts[0];
    const user = accounts[1];

    beforeEach(async () => {
        tokenContract1 = await TokenContract1.new({ from: owner });
        bridgeContract1 = await BridgeContract1.new(tokenContract1.address, owner, { from: owner });
    });

    it("should lock and unlock tokens", async () => {
        const amount = 100;
        await tokenContract1.transfer(user, amount, { from: owner });
        await tokenContract1.approve(bridgeContract1.address, amount, { from: user });

        await bridgeContract1.lockTokens(amount, { from: user });

        const lockedBalance = await tokenContract1.balanceOf(bridgeContract1.address);
        assert.equal(lockedBalance.toString(), amount.toString(), "Tokens were not locked");

        await bridgeContract1.unlockTokens(user, amount, { from: owner });

        const userBalance = await tokenContract1.balanceOf(user);
        assert.equal(userBalance.toString(), amount.toString(), "Tokens were not unlocked");
    });
});
