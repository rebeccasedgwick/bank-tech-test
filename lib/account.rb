require "date"
require "bigdecimal"
require_relative "transaction"

class Account
  attr_reader :transactions, :balance

  def initialize
    @transactions = []
    @balance = 0
  end

  def withdraw(date_input, amount_input, transaction_class: Transaction)
    amount = convert_amount_input(amount_input)
    raise "Please enter a valid number" if amount.positive?
    date = convert_date_input(date_input)
    balance_update(amount)
    @transactions << transaction_class.new(date, amount, @balance)
  end

  def deposit(date_input, amount_input, transaction_class: Transaction)
    amount = convert_amount_input(amount_input)
    raise "Please enter a valid number" if !amount.positive?
    date = convert_date_input(date_input)
    balance_update(amount)
    @transactions << transaction_class.new(date, amount, @balance)
  end

  def statement
    puts headers
    @transactions.reverse_each do |transaction|
      puts [
        date_prettify(transaction.date).ljust(10, " "),
        num_formatter(transaction.credit).rjust(12, " "),
        num_formatter(transaction.debit).rjust(12, " "),
        num_formatter(transaction.balance).rjust(12, " ")
      ].join(" ||")
    end
  end

  private
  def balance_update(amount)
    @balance += amount
  end

  def convert_date_input(date_input)
    Date.strptime(date_input, "%d-%m-%Y")
  end

  def convert_amount_input(amount_input)
    BigDecimal(amount_input.to_s)
  end

  def date_prettify(date)
    date.strftime("%d/%m/%Y")
  end

  def num_formatter(num)
    "%.2f" % num.abs
  end

  def headers
    "date       || credit      || debit       || balance    "
  end
end
