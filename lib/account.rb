class Account
  attr_reader :transactions, :balance

  def initialize
    @transactions = []
    @balance = 0.00
  end

  def withdraw(amount)
    @balance = @balance - (amount.abs)
  end

  def deposit(amount)
    @balance = @balance + (amount.abs)
  end
  ## NOTE: Currently keeping the #.abs method on #deposit in case deposit / withdraw are renamed to credit / debit, which can be confused easily depending on whether you're considering this from the customer of bank's point of view.
end
