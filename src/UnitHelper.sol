// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.9;
import "openzeppelin-contracts/contracts/access/Ownable.sol";
import "openzeppelin-contracts/contracts/utils/math/SafeMath.sol";
import "hardhat/console.sol";
import "./lib/Unit.sol";

contract UnitHelper is Ownable {
    using SafeMath for uint256;

    struct Ability {
        string description;
        uint8 ratio;
    }

    UnitLibrary.Unit[] public units;
    mapping(uint16 => Ability) public unitToAbility;

    function _availableName(string memory _name) internal view returns (bool) {
        uint256 unitsLength = units.length;
        for (uint256 i = 0; i < unitsLength; i++) {
            if (keccak256(bytes(units[i].name)) == keccak256(bytes(_name))) {
                return false;
            }
        }
        return true;
    }

    function _createUnit(
        string memory _name,
        uint16 _hp,
        uint16 _attack,
        uint16 _points
    ) external onlyOwner {
        require(_availableName(_name), "A unit already has that name");
        require(_points > 0, "A unit needs to have points");
        units.push(UnitLibrary.Unit(_name, _hp, _attack, _points));
    }

    function _createAbility(
        string memory _description,
        uint8 _ratio,
        uint16 _unitId
    ) external onlyOwner {
        Ability memory ability = Ability(_description, _ratio);
        unitToAbility[_unitId] = ability;
    }

    function _validTeam(uint8[] memory team, uint8 points)
        public
        view
        returns (bool)
    {
        uint256 counter = 0;
        uint256 teamLength = team.length;
        uint256 unitsLength = units.length;
        for (uint256 i = 0; i < teamLength; i++) {
            uint8 unitId = team[i];
            require(unitId < unitsLength, "Invalid unit in team");
            counter = counter.add(units[unitId].points);
            require(counter > 0, "Counter not positive");
            require(counter <= points, "Point limit exceeded");
        }
        return true;
    }

    function _initializeUnit(uint8 _unitId)
        internal
        view
        returns (UnitLibrary.Unit memory)
    {
        UnitLibrary.Unit memory unit = units[_unitId];
        return UnitLibrary.Unit(unit.name, unit.hp, unit.attack, unit.points);
    }

    function _initializeTeam(uint8[] memory _team, uint8 points)
        external
        view
        returns (UnitLibrary.Unit[] memory)
    {
        require(_validTeam(_team, points));
        uint256 teamLength = _team.length;
        UnitLibrary.Unit[] memory team = new UnitLibrary.Unit[](teamLength);
        for (uint256 i = 0; i < teamLength; i++) {
            team[i] = _initializeUnit(_team[i]);
        }
        return team;
    }

    function getUnits() external view returns (UnitLibrary.Unit[] memory) {
        return units;
    }
}
