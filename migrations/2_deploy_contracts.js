var EtherBank = artifacts.require("./EtherBank");

module.exports = function(deployer) {
  deployer.deploy(EtherBank);
};