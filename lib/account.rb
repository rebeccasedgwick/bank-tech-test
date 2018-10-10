require "date"
require "bigdecimal"
require_relative "transaction"

class Account
  attr_reader :transactions, :balance

  def initialize
    @transactions = []
    @balance = 0.00
  end

  def withdraw(date_input, amount, transaction_class: Transaction)
    raise "Please enter a valid number" if amount.positive?
    date = convert_date_input(date_input)
    balance_update(amount)
    @transactions << transaction_class.new(date, amount, @balance)
  end

  def deposit(date_input, amount, transaction_class: Transaction)
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
    @balance = balance + amount
  end

  def convert_date_input(date)
    # date = date.split("-").reverse!.join("-")
    Date.strptime(date, "%d-%m-%Y")
  end

  def date_prettify(date)
    date.strftime("%d/%m/%Y")
  end

  def num_formatter(num)
    "%.2f" % (BigDecimal(num.to_f.abs, 2))
  end

  def headers
    "date       || credit      || debit       || balance    "
  end
end
