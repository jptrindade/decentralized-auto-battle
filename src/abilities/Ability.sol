// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.9;

contract Ability {
    string description;
    uint8 activationRate;

    function executeAbility() external {}

    function changeActivationRate(uint8 ratio, bool nerf) external {}
}
