require "date"
require "bigdecimal"
require_relative "transaction"
require_relative "statement"

class Account
  attr_reader :transactions, :balance

  def initialize
    @transactions = []
    @balance = 0
  end

  def withdraw(date_input, amount_input, transaction_class: Transaction)
    raise "Please enter a valid number" if amount_input.positive?
    transact(date_input, amount_input, transaction_class)
  end

  def deposit(date_input, amount_input, transaction_class: Transaction)
    raise "Please enter a valid number" if !amount_input.positive?
    transact(date_input, amount_input, transaction_class)
  end

  private
  def transact(date_input, amount_input, transaction_class)
    amount = convert_amount_input(amount_input)
    date = convert_date_input(date_input)
    update_balance(amount)
    @transactions << transaction_class.new(date, amount, @balance)
  end

  def update_balance(amount)
    @balance += amount
  end

  def convert_date_input(date_input)
    Date.strptime(date_input, "%d-%m-%Y")
  end

  def convert_amount_input(amount_input)
    BigDecimal(amount_input.to_s)
  end
end
