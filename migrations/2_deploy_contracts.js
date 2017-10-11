
var Hub = artifacts.require("./Hub.sol");

module.exports = function(deployer, network, accounts) {
  deployer.deploy(Hub)
  .then(tx => {
  	return Hub.deployed();
  })
  .then(function(instance) {
  	return instance.createNewFunPark(accounts[1]);
  })
  .then(function(tx) {
    console.log(tx);
  })
  .catch(err=>{
  	console.log("Error deploying Regulator contract")
  })
};