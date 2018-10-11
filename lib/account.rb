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
    raise "Please enter a valid number" if amount_input.positive?
    transact(date_input, amount_input, transaction_class)
  end

  def deposit(date_input, amount_input, transaction_class: Transaction)
    raise "Please enter a valid number" if !amount_input.positive?
    transact(date_input, amount_input, transaction_class)
  end

  def statement
    puts headers
    @transactions.reverse_each do |transaction|
      puts [
        prettify_date(transaction.date).ljust(10, " "),
        format_number(transaction.credit).rjust(12, " "),
        format_number(transaction.debit).rjust(12, " "),
        format_number(transaction.balance).rjust(12, " ")
      ].join(" ||")
    end
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

  def prettify_date(date)
    date.strftime("%d/%m/%Y")
  end

  def format_number(number)
    "%.2f" % number.abs
  end

  def headers
    "date       || credit      || debit       || balance    "
  end
end
