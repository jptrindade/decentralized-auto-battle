// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.10;

import "ds-test/test.sol";
import "src/UnitHelper.sol";
import "src/CombatHelper.sol";
import "src/BalanceHelper.sol";
import "src/lib/Result.sol";
import "hardhat/console.sol";

contract BaseTest is DSTest {
    UnitHelper unitHelper;
    CombatHelper combatHelper;
    BalanceHelper balanceHelper;

    function createTestData() public {
        unitHelper = new UnitHelper();
        unitHelper._createUnit("warrior", 100, 100, 3);
        unitHelper._createUnit("mage", 50, 50, 2);
        unitHelper._createUnit("tank", 200, 50, 3);

        combatHelper = new CombatHelper();

        balanceHelper = new BalanceHelper();
    }
}
