class Account
  attr_reader :transactions, :balance

  def initialize
    @transactions = []
    @balance = 0.00
  end

  def withdraw(amount)
    amount = amount.abs
    @balance = @balance - amount
  end
end
