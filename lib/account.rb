class Account
  attr_reader :transactions, :balance

  def initialize
    @transactions = []
    @balance = 0.00
  end

  def withdraw(amount)
    @balance = @balance - (amount.abs)
  end
end
