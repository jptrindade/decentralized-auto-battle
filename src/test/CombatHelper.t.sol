// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.10;

import "ds-test/test.sol";
import "src/UnitHelper.sol";

import "hardhat/console.sol";

contract CombatHelperTest is DSTest {
    UnitHelper unitHelper;

    function setUp() public {
        unitHelper = new UnitHelper();
        unitHelper._createUnit("warrior", 100, 100, 3);
        unitHelper._createUnit("mage", 50, 50, 2);
        unitHelper._createUnit("tank", 50, 200, 3);
    }

    function testCreateUnit() public {
        unitHelper._createUnit("testUnit", 100, 100, 3);
        UnitHelper.Unit[] memory units = unitHelper.getUnits();
        UnitHelper.Unit memory unit = units[0];
        assertTrue(unit.hp == 100);
    }
}
