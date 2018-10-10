require "account"

def create_account
  @account = Account.new
end

def make_deposit
  transaction_date = "12-02-2012"
  @account.deposit(transaction_date, 100.00)
end

def make_withdrawal
  transaction_date = "13-03-2013"
  @account.withdraw(transaction_date, -50.00)
end

def account_balance_increases
  expect(@account.balance).to eq(100.00)
end

def account_balance_decreases
  expect(@account.balance).to eq(50.00)
end

def displays_statement
  expect(STDOUT).to receive(:puts).with("date       || credit      || debit       || balance    ")
  expect(STDOUT).to receive(:puts).with("13/03/2013 ||        0.00 ||       50.00 ||       50.00")
  expect(STDOUT).to receive(:puts).with("12/02/2012 ||      100.00 ||        0.00 ||      100.00")

  @account.statement
end
