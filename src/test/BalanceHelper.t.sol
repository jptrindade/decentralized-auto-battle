// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.10;

import "src/test/BaseTest.sol";
import "src/BalanceHelper.sol";
import "src/lib/Result.sol";
import "hardhat/console.sol";

contract BalanceHelperTest is BaseTest {
    function setUp() public {
        createTestData();
    }

    function testResetStats() public {
        balanceHelper.resetStats(address(unitHelper));
        assert(balanceHelper.getStats().length == 3);

        unitHelper.createUnit("thief", 70, 50, 1);
        balanceHelper.resetStats(address(unitHelper));
        assert(balanceHelper.getStats().length == 4);
    }
}
