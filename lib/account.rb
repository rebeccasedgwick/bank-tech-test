require "date"
require "bigdecimal"
require_relative "transaction"

class Account
  attr_reader :transactions, :balance

  def initialize
    @transactions = []
    @balance = 0.00
  end

  def withdraw(date, amount)
    date = date_formatter(date)
    @balance = @balance - amount.abs
    @transactions << Transaction.new.withdraw(date, amount, @balance)
  end

  def deposit(date, amount)
    raise "Please enter a valid number" if !amount.positive?
    date = date_formatter(date)
    @balance = @balance + amount.abs
    @transactions << Transaction.new.deposit(date, amount, @balance)
  end

  def statement
    puts headers
    @transactions.reverse_each do |transaction|
      puts "#{transaction.date.ljust(10, " ")} ||\
      #{num_formatter(transaction.credit).to_s.rjust(6, " ")} ||\
      #{num_formatter(transaction.debit).to_s.rjust(6, " ")} ||\
      #{num_formatter(transaction.balance).to_s.rjust(6, " ")}"
    end
  end

  private
  def date_formatter(date)
    date = date.split("-").reverse!.join("-")
    Date.strptime(date).strftime("%d/%m/%Y")
  end

  def num_formatter(num)
    "%.2f" % (BigDecimal(num, 2))
  end

  def headers
    "date       || credit      || debit       || balance    "
  end
end
