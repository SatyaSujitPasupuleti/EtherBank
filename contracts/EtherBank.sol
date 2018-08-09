pragma solidity ^0.4.23;
contract EtherBank{
    mapping (address => uint) balances;
    uint totalBalances;
    mapping(address => uint) loans;
    uint totalLoans;
    mapping(address=>uint) statusOfCustomers; //three statuses, 1=loaned 2=stored 3=both
    address owner;

    constructor() public{
        totalBalances = 0;
        totalLoans = 0;
        owner = msg.sender;


    }
    function store(uint _amount) public payable {
      //  require(_amount > 0); //prevents people from creating accounts of 0
        //if they have no account
        //implicitly stores ether into contract
     //   require(msg.value == _amount);
        if(statusOfCustomers[msg.sender] == 0){
            balances[msg.sender] = _amount;
            totalBalances = totalBalances + _amount;
            statusOfCustomers[msg.sender] = 2;
        }else{ //if they have an account
            balances[msg.sender] = balances[msg.sender] + _amount;
            totalBalances = totalBalances + _amount;
            if(statusOfCustomers[msg.sender] == 1) //set the status of the address to both stored and loaned
            {
                statusOfCustomers[msg.sender] = 3;
            }

        }
    }
    function withdraw(uint _amount) public payable{
      //  require(balances[msg.sender] != 0); //make sure they have and account and that account has balance
      //  require(_amount > 0);
      //  require(_amount <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender] - _amount;
        totalBalances = totalBalances - _amount;
        msg.sender.transfer(address(this).balance);
    }
    
    function loan(uint _amount) public payable { //some logic needs to be fixed here
       // require(totalBalances > 0);
      //  require(msg.value == _amount);
        if(statusOfCustomers[msg.sender] == 0){
            loans[msg.sender] = _amount;
            totalLoans = totalLoans + _amount;
            statusOfCustomers[msg.sender] = 1;
            totalBalances = totalBalances-_amount;
            msg.sender.transfer(address(this).balance);

        }else{
            loans[msg.sender] = loans[msg.sender] + _amount;
            totalLoans = totalLoans + _amount;
            msg.sender.transfer(address(this).balance);
            if(statusOfCustomers[msg.sender] == 2)
            {
                statusOfCustomers[msg.sender] = 3;
            }

        }

    } 
    function returnLoan(uint _amount) public payable{ //payable allows for implicit transactions
      //  require(loans[msg.sender] != 0); //making sure they have a loan
      //  require(msg.value == _amount); //make sure the value sent 
        loans[msg.sender] = loans[msg.sender] - _amount;
        totalLoans = totalLoans - _amount;
        totalBalances = totalBalances + _amount;
        //ether implicitly gets put into vault after loan is repaid

    }
    function balanceOf(address _holder) public view returns(uint) {
        return balances[_holder];

    }

   






}