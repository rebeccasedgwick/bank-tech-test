require "date"
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
    date = date_formatter(date)
    @balance = @balance + amount.abs
    @transactions << Transaction.new.deposit(date, amount, @balance)
  end

  def date_formatter(date)
    date = date.split("-").reverse!.join("-")
    Date.strptime(date).strftime("%d/%m/%Y")
  end

  def statement
    puts headers
    @transactions.each do |transaction|
      puts "#{transaction.date.ljust(10, " ")} || #{transaction.credit.to_s.rjust(10, " ")} || #{transaction.debit.to_s.rjust(10, " ")} || #{transaction.balance.to_s.rjust(10, " ")}"
    end
  end

  private
  def headers
    "date       || credit     || debit      || balance   "
  end
end
