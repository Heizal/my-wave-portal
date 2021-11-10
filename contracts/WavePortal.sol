// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;

    /*
     * We will be using this below to help generate a random number
     */
    uint256 private seed;

    event NewWave(address indexed from, uint256 timestamp, string message);

    struct Wave {
        address waver;
        string message;
        uint256 timestamp;
    }

    Wave[] waves;

    /*
     * This is an address => uint mapping, meaning I can associate an address with a number!
     * In this case, I'll be storing the address with the last time the user waved at us.
     */
    mapping(address => uint256) public lastWavedAt;

    constructor() payable {
        console.log("We have been constructed!");
        /*
         * Set the initial seed
         */
        seed = (block.timestamp + block.difficulty) % 100;
    }

    function wave(string memory _message) public {
         /*
         * We need to make sure the current timestamp is at least 15-minutes bigger than the last timestamp we stored
         */
         require(lastWavedAt[msg.sender] + 30 seconds < block.timestamp, "Must wait 30 seconds before waving again.");
         //this is our cooldown and I guess everyones cooldown
       

        /*
         * Update the current timestamp we have for the user
         */
        lastWavedAt[msg.sender] = block.timestamp;

        totalWaves += 1;
        console.log("%s has waved!", msg.sender);

        waves.push(Wave(msg.sender, _message, block.timestamp));

        /*
         * Generate a new seed for the next user that sends a wave
         */
        seed = (block.difficulty + block.timestamp + seed) % 100;

        /*
         * Give a 50% chance that the user wins the prize.
         */
        if (seed <= 50) {
            console.log("%s won!", msg.sender);

            /*
             * The same code we had before to send the prize.
             */
            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than the contract has."
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        }

        emit NewWave(msg.sender, block.timestamp, _message);
    }

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        return totalWaves;
    }
}





// pragma solidity ^0.8.0;
// import "hardhat/console.sol";

// contract WavePortal{
//     uint256 totalWaves; //run totalwaves variable thats automatically initialised at 0
//     //its a state variable and its stored permanently in our contract storage

//      /*
//      * A little magic, Google what events are in Solidity!
//      */
//     event NewWave(address indexed from, uint256 timestamp, string message); //This is how the event is declared using the event keyword

//     /*
//      * I created a struct here named Wave.
//      * A struct is basically a custom datatype where we can customize what we want to hold inside it.
//      */
//     struct Wave {
//         address waver; // The address of the user who waved.
//         string message; // The message the user sent.
//         uint256 timestamp; // The timestamp when the user waved.
//     }

//     /*
//      * I declare a variable waves that lets me store an array of structs.
//      * This is what lets me hold all the waves anyone ever sends to me!
//      */
//     Wave[] waves;

//     constructor() payable {
//         console.log("I am a smart contract");

//         /*
//          * Sets the initial seed
//          */
//         seed= (block.timestamp + block.difficulty)% 100; //block difficulty tells miners how hard the block will be to be mined based on the transatcions of the block
//         //a block will get hrader to be mined when there are more transactions in the block
//         //block timestamp is the Unix timestamp that the block is being processed
//         //since block timstamp and block difficulty can still be attacked, we add a variable of seed that changes every time the user sends a new wave. Therfore when all a combined with genrate a new random seed everytime
//         //the 100% will ensure that the number is btn 0-100
//     }


//     /*
//      * You'll notice I changed the wave function a little here as well and
//      * now it requires a string called _message. This is the message our user
//      * sends us from the frontend!
//      */
//     function wave(string memory _message) public {
//         totalWaves += 1;
//         console.log("%s has waved!", msg.sender); //msg.sender is the wallet address of the person that call the function

//          /*
//          * This is where I actually store the wave data in the array.
//          */
//         waves.push(Wave(msg.sender, _message, block.timestamp));

//         /*
//          * Generate a new seed for the next user that sends a wave
//          */
//         seed = (block.difficulty + block.timestamp + seed) % 100;

//         /*
//          * Give a 50% chance that the user wins the prize.
//          */
//             if (seed <= 50) { //this one just says that a user has a 50% chance of winning some eth
//                 console.log("%s won!", msg.sender);

//             uint256 prizeAmount = 0.0001 ether; //initialised the prize amount
//             require( //require which basically checks to see that some condition is true. If it's not true, it will quit the function and cancel the transaction. 
//                 prizeAmount <= address(this).balance,  //adrress(this).balance is the balance of the contract itself
//                 "Trying to withdraw more money than the contract has." //t lets us make sure that the balance of the contract is bigger than the prize amount, and if it is, we can move forward with giving the prize! If it isn't require will essentially kill the transaction and be like, "Yo, this contract can't even pay you out!".
//             );
//             (bool success, ) = (msg.sender).call{value: prizeAmount}(""); //this is the magic line where we send the money
//             require(success, "Failed to withdraw money from contract."); //this is where we know its a success and if its not it throws an error
//         }
//         /*
//          * When the event above emits,it stores the arguments passed in transaction logs.
//             These logs are stored on blockchain and are accessible using address of the contract till the contract is present on the blockchain.
//          */
//         emit NewWave(msg.sender, block.timestamp, _message);
//     }

//      /*
//      * I added a function getAllWaves which will return the struct array, waves, to us.
//      * This will make it easy to retrieve the waves from our website!
//      */
//     function getAllWaves() public view returns (Wave[] memory) {
//         return waves;
//     }

//     function getTotalWaves() public view returns(uint256){
//         console.log("We have %d total waves!", totalWaves);
//         return totalWaves;
//     }
// }
