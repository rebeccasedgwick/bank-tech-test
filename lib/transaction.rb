class Transaction
  attr_reader :date, :debit, :credit, :balance

  def initialize
    @date = ""
    @credit = 0.00
    @debit = 0.00
    @balance = 0.00
  end

  def withdraw(date, amount, balance)
    @date = date
    @debit = amount
    @balance = balance
    self
  end

  def deposit(date, amount, balance)
    @date = date
    @credit = amount
    @balance = balance
    self
  end
end
