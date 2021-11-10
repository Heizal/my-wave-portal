const main = async () => {
        const waveContractFactory = await hre.ethers.getContractFactory('WavePortal');
        const waveContract = await waveContractFactory.deploy({
        value: hre.ethers.utils.parseEther('0.1'),
        });
        await waveContract.deployed();
        console.log('Contract addy:', waveContract.address);
    
        let contractBalance = await hre.ethers.provider.getBalance(
        waveContract.address
        );
        console.log(
        'Contract balance:',
        hre.ethers.utils.formatEther(contractBalance)
        );
    
        /** Let's try two waves now
        */
        const waveTxn = await waveContract.wave('This is wave #1');
        await waveTxn.wait();
    
        const waveTxn2 = await waveContract.wave('This is wave #2');
        await waveTxn2.wait();
    
        contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
        console.log(
        'Contract balance:',
        hre.ethers.utils.formatEther(contractBalance)
        );
    
        let allWaves = await waveContract.getAllWaves();
        console.log(allWaves);
    };
    
    const runMain = async () => {
        try {
        await main();
        process.exit(0);
        } catch (error) {
        console.log(error);
        process.exit(1);
        }
    };
    
    runMain();







//     const main = async () => {
//         const waveContractFactory = await hre.ethers.getContractFactory('WavePortal'); //this compiles our contract and generates the necessary file we need to work with under the artifacts directory
//         const waveContract = await waveContractFactory.deploy({
//             value: hre.ethers.utils.parseEther('0.1'), //this is where we go to deploy our contract and it funds the 0.1 eth
//         }); //with this, hardhat creates a local eth network for us that is built and destroyed and then built again verytime we run a contract. Its great for debugging errors
//         await waveContract.deployed(); //we wait until our contract is deployed to our local blockchain
//         console.log('Contract addy:', waveContract.address);

//         /**Get Contract balance * /
//         let contractBalance = await hre.ethers.provider.getBalance( 
//             waveContract.address
//         );
//         console.log(
//             'Contract balance:',
//             hre.ethers.utils.formatEther(contractBalance) //here I test out if my contrcat has the 0.1 balance 
//         );

//          /** Send Wave*/
//         let waveTxn = await waveContract.wave('A message!');
//         await waveTxn.wait();

//         /*
//         * Get Contract balance to see what happened!
//         */
//         contractBalance = await hre.ethers.provider.getBalance(waveContract.address); //we use the getBalance funtion to pass our contract addy
//         console.log(
//             'Contract balance:',
//             hre.ethers.utils.formatEther(contractBalance)
//         );

//         let allWaves = await waveContract.getAllWaves();
//         console.log(allWaves);
// };

//         const runMain = async () => {
//         try {
//             await main();
//             process.exit(0);
//         } catch (error) {
//             console.log(error);
//             process.exit(1);
//         }
//         };

// runMain();

    //     let waveCount;
    //     waveCount = await waveContract.getTotalWaves(); //this function grabs the toatl waves
    //     console.log(waveCount.toNumber());

    //     /** * Let's send a few waves!*/   
    //     let waveTxn = await waveContract.wave('A message!'); //then we do the wave
    //     await waveTxn.wait(); //waits for the transaction to be mined

    //     const [_, randomPerson] = await hre.ethers.getSigners(); //grabs the message and the persons address
    //     waveTxn = await waveContract.connect(randomPerson).wave('Another message!'); //allows a wave from a random person
    //     await waveTxn.wait();

    //     let allWaves = await waveContract.getAllWaves(); //grabs all the waves again and sees if anything has changed and updates
    //     console.log(allWaves);
    // };
    
    // const runMain = async () => {
    //     try {
    //     await main();
    //     process.exit(0);
    //     } catch (error) {
    //     console.log(error);
    //     process.exit(1);
    //     }
    // };
    
    // runMain();