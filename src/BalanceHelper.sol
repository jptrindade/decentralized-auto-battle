// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.9;
import "openzeppelin-contracts/contracts/access/Ownable.sol";
import "openzeppelin-contracts/contracts/utils/math/SafeMath.sol";
import "hardhat/console.sol";
import "./lib/Unit.sol";
import "./UnitHelper.sol";

contract BalanceHelper is Ownable {
    using SafeMath for uint256;

    struct Stats {
        uint256 matches;
        uint256 matchesWon;
        uint256 loveVotes;
        uint256 hateVotes;
    }

    Stats[] public _stats;

    function resetStats(address _unitHelper) external onlyOwner {
        delete _stats;
        UnitHelper unitHelper = UnitHelper(_unitHelper);
        uint256 unitCount = unitHelper.getUnitCount();

        for (uint256 i = 0; i < unitCount; i++) {
            _stats.push(Stats(0, 0, 0, 0));
        }
    }

    function getStats() external view returns (Stats[] memory stats) {
        return _stats;
    }
}
