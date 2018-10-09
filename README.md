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

_Previously:_
Initially planned to have transactions held in instance var array in Account class; each element would be a sub-arr of `[[date, amount], balance]`.  

However, this is difficult to extract info from. Also, there is no distinction between credit and debits, other than one is recorded as a positive and the other as negative. Although the current figures could could be sorted to show negatives in debit column etc, it would be better to store that property (credit or debit) with the amount itself, rather than working it out when it gets to making the statement (it's not the responsibility of the statement to work out if something is a credit or a debit).  

Therefore, I plan to refactor out transaction items into a separate class (e.g. "Transaction" or "TransactionItem"). Instances of this class can be created and given key-value properties (for ease of reading / naming / distinction between credit & debit) and will be stored in the `@transactions` array of Account.

Thinking more broadly, this would also be more scaleable as if additional properties were to be added to the transaction (e.g. type: cheque, cash, direct debit) as they could be assigned on creation of the transaction item, rather than part of the Account's responsibilities to assign.

---
_Summary:_
I had originally designed a Statement class which would handle the formatting of the account's transactions for display. However, this was unnecessary, as the transaction objects were relatively tidy and easy to pull information from. The statement can be accessed directly from the Account object.

### Limitations
Floats to 2dp. I should've included these from the beginning; with time permitting I would've refactored these in.
