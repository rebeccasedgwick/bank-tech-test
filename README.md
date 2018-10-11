# Bank tech test
A tech test to practice OO and TDD skills.

## To use

Clone this repo to your local machine. Run `bundle install` to ensure that all dependencies are added

In your terminal, run IRB and require the `account` file:
`$ load 'account.rb'`

Start off by creating your account:
`$ my_account = Account.new`

You can then add transactions (deposits or withdrawals) as demonstrated below. The date is take in the dd-mm-YYYY format as a string, followed by the number to withdraw or deposit.  

```
$ my_account.deposit("10-01-2012", 1000)
$ my_account.deposit("13-01-2012", 2000)
$ my_account.withdraw("14-01-2012", 500)

```

To view your account statement, run:
```
$ my_account.statement
```

This will then display your transactions in the console:
```
date       || credit     || debit      || balance
14/01/2012 ||        0.0 ||        500 ||     2500.0
13/01/2012 ||       2000 ||        0.0 ||     3000.0
10/01/2012 ||       1000 ||        0.0 ||     1000.0
```

To run the tests:

```
$ rspec
```

This will also give you test coverage percentage.


## Specification

### Requirements

* You should be able to interact with your code via a REPL like IRB.  
* You don't need to implement a command line interface that takes input from STDIN.
* Deposits, withdrawal.
* Account statement (date, amount, balance) printing.
* Data can be kept in memory (it doesn't need to be stored to a database or anything).

### Acceptance criteria

**Given** a client makes a deposit of 1000 on 10-01-2012  
**And** a deposit of 2000 on 13-01-2012  
**And** a withdrawal of 500 on 14-01-2012  
**When** she prints her bank statement  
**Then** she would see

```
date       || credit  || debit  || balance
14/01/2012 ||         || 500.00 || 2500.00
13/01/2012 || 2000.00 ||        || 3000.00
10/01/2012 || 1000.00 ||        || 1000.00
```

## Approach

### Design decisions

There are three classes:
- **Account** - this is responsible for deposits and withdrawals; and making sure the user's input values are converted into the right objects (bigdecimal / date).
- **Statment** - this is responsible for formatting the data given to give the required aesthetic output (e.g. separating dates with "/" rather than "-", and showing currency values to 2 decimal places)
- **Transaction** - responsible for holding transactions; if different types of transaction (e.g. cash withdrawal, cheque, bank transfer etc.) existed, this could be extended.
