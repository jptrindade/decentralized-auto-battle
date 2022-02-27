// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.9;
import "openzeppelin-contracts/contracts/access/Ownable.sol";
import "openzeppelin-contracts/contracts/utils/math/SafeMath.sol";
import "hardhat/console.sol";
import "./lib/Unit.sol";
import "./lib/SafeMath.sol";
import "./lib/Result.sol";
import "./UnitHelper.sol";

contract CombatHelper is Ownable {
    using SafeMath16 for uint16;
    using SafeMath8 for uint8;

    function executeAttackOnTarget(uint16 power, UnitLibrary.Unit memory target)
        internal
        pure
        returns (UnitLibrary.Unit memory)
    {
        if (power > target.hp) {
            target.hp = 0;
        } else {
            target.hp = target.hp.sub(power);
        }
        return target;
    }

    function _isAlive(UnitLibrary.Unit memory unit)
        internal
        pure
        returns (bool)
    {
        return unit.hp > 0;
    }

    function _confirmWinner(
        UnitLibrary.Unit[] memory _team1,
        UnitLibrary.Unit[] memory _team2
    ) internal pure returns (ResultLibrary.Result) {
        uint256 _teamSize1 = _team1.length;
        uint256 _teamSize2 = _team2.length;
        bool team1Alive = false;
        bool team2Alive = false;

        for (uint256 i = 0; i < _teamSize1; i++) {
            if (_isAlive(_team1[i])) {
                team1Alive = true;
            }
        }

        for (uint256 i = 0; i < _teamSize2; i++) {
            if (_isAlive(_team2[i])) {
                team2Alive = true;
            }
        }

        if (team1Alive == team2Alive) {
            return ResultLibrary.Result.DRAW;
        }
        if (team1Alive) {
            return ResultLibrary.Result.TEAM1VICTORY;
        }
        return ResultLibrary.Result.TEAM2VICTORY;
    }

    function _teamBattle(
        UnitLibrary.Unit[] memory _team1,
        UnitLibrary.Unit[] memory _team2
    )
        internal
        pure
        returns (UnitLibrary.Unit[] memory, UnitLibrary.Unit[] memory)
    {
        uint8 p1 = 0;
        uint256 _teamSize1 = _team1.length;
        uint8 p2 = 0;
        uint256 _teamSize2 = _team2.length;

        while (p1 < _teamSize1 && p2 < _teamSize2) {
            UnitLibrary.Unit memory unit1 = _team1[p1];
            UnitLibrary.Unit memory unit2 = _team2[p2];

            unit2 = executeAttackOnTarget(unit1.attack, unit2);
            unit1 = executeAttackOnTarget(unit2.attack, unit1);

            if (_isAlive(unit1)) {
                p1 = p1.add(1);
            }
            if (_isAlive(unit2)) {
                p2 = p2.add(1);
            }
        }
        return (_team1, _team2);
    }

    function _executeMatch(
        address _unitHelperAddress,
        uint8[] memory _team1,
        uint8[] memory _team2,
        uint8 points
    ) external view returns (ResultLibrary.Result) {
        UnitLibrary.Unit[] memory team1 = UnitHelper(_unitHelperAddress)
            ._initializeTeam(_team1, points);
        UnitLibrary.Unit[] memory team2 = UnitHelper(_unitHelperAddress)
            ._initializeTeam(_team2, points);

        (team1, team2) = _teamBattle(team1, team2);

        return _confirmWinner(team1, team2);
    }
}
