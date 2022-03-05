// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.10;

import "src/test/BaseTest.sol";
import "src/UnitHelper.sol";
import "src/CombatHelper.sol";
import "src/lib/Result.sol";
import "hardhat/console.sol";

contract CombatHelperTest is BaseTest {
    function setUp() public {
        createTestData();
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
