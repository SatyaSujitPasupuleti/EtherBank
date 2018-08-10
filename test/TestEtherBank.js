var EtherBank = artifacts.require("./EtherBank");
contract("Etherbank", async(accounts)=>{
    it("should store 10 Ether from Ganache into account" , async() =>{
        let instance = await EtherBank.deployed();
        //how 
        var accountx = await web3.eth.accounts;
        
        await console.log(web3.fromWei(web3.eth.getBalance(web3.eth.accounts[0]).toNumber()));
      let balance = await instance.store.call(10,{from:web3.eth.accounts[0],value: web3.toWei(50000000, 'ether')}); //account does not have any ether to transfer which is why the requires failed
      // assert.equal(await balance.valueOf(),10);
      await console.log(web3.fromWei(web3.eth.getBalance(web3.eth.accounts[0]).toNumber()));
      

    })
});