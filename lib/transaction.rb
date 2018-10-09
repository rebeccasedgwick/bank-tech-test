class Transaction
  attr_reader :date, :debit, :credit, :balance

  def initialize(date, debit, credit, balance)
    @date = date
    @debit = debit
    @credit = credit
    @balance = balance
  end
end
