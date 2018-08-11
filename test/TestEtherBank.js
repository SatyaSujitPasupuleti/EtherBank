var EtherBank = artifacts.require("./EtherBank");
contract("Etherbank", async(accounts)=>{
    it("should store 10 Ether from Ganache into account" , async() =>{
        let instance = await EtherBank.deployed();
        //how 
        var accountx = await web3.eth.accounts;
        
        await console.log(web3.fromWei(web3.eth.getBalance(web3.eth.accounts[0]).toNumber()));
       await instance.store.call(10,{from:web3.eth.accounts[0],value: web3.toWei(10, 'ether')}); 
      // assert.equal(await balance.valueOf(),10);
      await console.log(web3.fromWei(web3.eth.getBalance(web3.eth.accounts[0]).toNumber()));
      //await console.log(web3.eth.getBalance(contract.options.address));
      
      //displays contract balance
      var testBalance=instance.contractBalance();
      testBalance.then(function(result){
          console.log(web3.fromWei(result.toNumber(), "ether" ));

      })
    

    })
});