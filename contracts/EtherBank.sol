pragma solidity ^0.4.23;
contract EtherBank{
    mapping (address => uint) balances;
    uint totalBalances;
    mapping(address => uint) loans;
    uint totalLoans;
    mapping(address=>uint) statusOfCustomers; //three statuses, 1=loaned 2=stored 3=both
    address public owner = msg.sender;

    constructor() public{
        totalBalances = 0;
        totalLoans = 0;


    }
    function store(uint _amount) public{
        require(_amount > 0); //prevents people from creating accounts of 0
        //if they have no account
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
    function withdraw(uint _amount) public{
        require(balances[msg.sender] != 0); //make sure they have and account and that account has balance
        require(_amount > 0);
        balances[msg.sender] = balances[msg.sender] - _amount;
        totalBalances = totalBalances - _amount;
    }
    function loan(uint _amount) public{ //some logic needs to be fixed here
        if(statusOfCustomers[msg.sender] == 0){
            loans[msg.sender] = _amount;
            totalLoans = totalLoans + _amount;
            statusOfCustomers[msg.sender] = 1;

        }else{
            loans[msg.sender] = loans[msg.sender] + _amount;
            totalLoans = totalLoans + _amount;
            if(statusOfCustomers[msg.sender] == 2)
            {
                statusOfCustomers[msg.sender] = 3;
            }

        }

    }
    function returnLoan(uint _amount) public{
        require(loans[msg.sender] != 0); //making sure they have a loan
        loans[msg.sender] = loans[msg.sender] - _amount;
        totalLoans = totalLoans - _amount;
    }
    function getInterest() public{ //call this function once every month to calculate interest
        require(msg.sender == owner);
        //calculate interest given total loans and all the people who stored money;
        //50% of interest goes to people who stored their money
    }




}