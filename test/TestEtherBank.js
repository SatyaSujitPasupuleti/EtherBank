var EtherBank = artifacts.require("./EtherBank");
contract("Etherbank", async(accounts)=>{
    it("should store 10 Ether from Ganache into account" , async() =>{
        let instance = await EtherBank.deployed();
        
       let balance = await instance.store.call(10,{from:accounts[0],gas:"220000"}); //account does not have any ether to transfer which is why the requires failed
       assert.equal(balance.valueOf(),10);
        

    })
});