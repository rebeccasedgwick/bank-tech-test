class Transaction
  attr_reader :date, :debit, :credit, :balance

  def initialize(date, credit, debit, balance)
    @date = date
    @credit = credit
    @debit = debit
    @balance = balance
  end
end
