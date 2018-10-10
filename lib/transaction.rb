class Transaction
  attr_reader :date, :debit, :credit, :balance

  def initialize(date, amount, balance)
    @date = date
    if amount.positive?
      @debit = 0
      @credit = amount
    else
      @debit = amount
      @credit = 0
    end
    @balance = balance
  end
end
