class Transaction
  attr_reader :date, :debit, :credit, :balance

  def initialize
    @date = nil
    @credit = nil
    @debit = nil
    @balance = 0.00
  end

  def debit(date, amount, balance)
    @date = date
    @debit = amount
    @balance = balance
    self
  end
end
