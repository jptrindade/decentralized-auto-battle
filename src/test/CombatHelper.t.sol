// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.10;

import "ds-test/test.sol";
import "src/UnitHelper.sol";
import "src/CombatHelper.sol";
import "src/lib/Result.sol";
import "hardhat/console.sol";

contract CombatHelperTest is DSTest {
    UnitHelper unitHelper;
    CombatHelper combatHelper;

    function setUp() public {
        unitHelper = new UnitHelper();
        unitHelper._createUnit("warrior", 100, 100, 3);
        unitHelper._createUnit("mage", 50, 50, 2);
        unitHelper._createUnit("tank", 200, 50, 3);

        combatHelper = new CombatHelper();
    }

    function testExecuteMatch() public {
        uint8[] memory team1 = new uint8[](2);
        uint8[] memory team2 = new uint8[](2);
        team1[0] = 0;
        team1[1] = 2;
        team2[0] = 0;
        team2[1] = 1;
        ResultLibrary.Result result = combatHelper._executeMatch(
            address(unitHelper),
            team1,
            team2,
            10
        );

        assert(result == ResultLibrary.Result.TEAM1VICTORY);
    }
}
