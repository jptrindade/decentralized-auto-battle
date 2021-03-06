// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.10;

import "ds-test/test.sol";
import "src/UnitHelper.sol";
import "src/lib/Unit.sol";
import "hardhat/console.sol";

contract UnitHelperTest is DSTest {
    UnitHelper unitHelper;

    function setUp() public {
        unitHelper = new UnitHelper();
    }

    function testCreateUnit() public {
        unitHelper.createUnit("warrior", 100, 100, 3);
        UnitLibrary.Unit[] memory units = unitHelper.getUnits();
        UnitLibrary.Unit memory unit = units[0];
        assertTrue(unit.hp == 100);
    }

    function testFailCreateUnitInvalidPoints() public {
        unitHelper.createUnit("warrior", 100, 100, 0);
    }

    function testFailCreateUnitInvalidName() public {
        unitHelper.createUnit("warrior", 100, 100, 3);
        unitHelper.createUnit("warrior", 100, 100, 3);
    }

    function testValidTeam() public {
        unitHelper.createUnit("mage", 100, 100, 3);
        unitHelper.createUnit("tank", 100, 100, 2);
        uint8[] memory team = new uint8[](2);
        team[0] = 0;
        team[1] = 1;
        assert(unitHelper.validTeam(team, 50));
    }

    function testFailValidTeamPoints() public {
        unitHelper.createUnit("mage", 100, 100, 3);
        unitHelper.createUnit("tank", 100, 100, 2);
        uint8[] memory team = new uint8[](2);
        team[0] = 0;
        team[1] = 1;
        assert(unitHelper.validTeam(team, 4));
    }

    function testFailValidTeamMember() public {
        unitHelper.createUnit("mage", 100, 100, 3);
        unitHelper.createUnit("tank", 100, 100, 2);
        uint8[] memory team = new uint8[](2);
        team[0] = 0;
        team[1] = 2;
        assert(unitHelper.validTeam(team, 50));
    }
}
