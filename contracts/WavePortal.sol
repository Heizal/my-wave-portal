// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
import "hardhat/console.sol";

contract WavePortal{
    uint256 totalWaves; //run totalwaves variable thats automatically initialised at 0
    //its a state variable and its stored permanently in our contract storage

    constructor(){
        console.log("yo, yo");
    }

    function wave() public {
        totalWaves += 1;
        console.log("%s has waved!", msg.sender); //msg.sender is the wallet address of the person that call the function
    }

    function getTotalWaves() public view returns(uint256){
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }
}
