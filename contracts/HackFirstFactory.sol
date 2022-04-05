//SPDX-License-Identifier: MIT
pragma solidity 0.8.13;


import "@openzeppelin/contracts/proxy/Clones.sol";
import "./HackFirst.sol";

contract HackFirstFactory {
        
    address public immutable hats;
    address public immutable implementation;

    event NewHackFirstContract(address indexed _instance, address indexed _hacker, address indexed _committee);

    constructor(address _implementation, address _hats) {
        implementation = _implementation;
        hats = _hats;
    }

    function createHackFirstContract(address _hacker, address _committee) external {
        address hacker = _hacker;
        if (hacker == address(0)) hacker = msg.sender;
        address payable newContract = payable(Clones.clone(implementation));
        HackFirst(newContract).initialize(hacker, _committee, hats);

        emit NewHackFirstContract(address(newContract), hacker, _committee);
    }
}
 