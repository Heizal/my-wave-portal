const main = async () => {
    const [owner, randomPerson] = await hre.ethers.getSigners(); //grabbed the wallet address of a the contract owner and a random wallet address
    const waveContractFactory = await hre.ethers.getContractFactory('WavePortal'); //this compiles our contract and generates the necessary file we need to work with under the artifacts directory
    const waveContract = await waveContractFactory.deploy(); //with this, hardhat creates a local eth network for us that is built and destroyed and then built again verytime we run a contract. Its great for debugging errors
    await waveContract.deployed(); //we wait until our contract is deployed to our local blockchain

    console.log("Contract deployed to:", waveContract.address); //the waveContract.address will give us the address of the deployed contract
    console.log("Contract deployed by:", owner.address); //the owners address the one deploting our contract

    let waveCount;
    waveCount = await waveContract.getTotalWaves(); //this function grabs the toatl waves
    
    let waveTxn = await waveContract.wave(); //then we do the wave
    await waveTxn.wait();

    waveCount = await waveContract.getTotalWaves(); //then we grab the wave count again to see if it has changed

    waveTxn = await waveContract.connect(randomPerson).wave(); //allows a wave from a random person
    await waveTxn.wait();

    waveCount = await waveContract.getTotalWaves(); //grabs the total waves again to see if anything has changed
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