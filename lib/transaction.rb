class Transaction
  attr_reader :date, :debit, :credit, :balance

  def initialize(date, amount, balance)
    @date = date
    if amount.positive?
      @credit = amount
    else
      @debit = amount
    end
    @balance = balance
  end
end
