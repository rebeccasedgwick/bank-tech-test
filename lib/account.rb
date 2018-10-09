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
    @transactions << Transaction.new.debit(date, amount, @balance)
  end

  def deposit(date, amount)
    date = date_formatter(date)
    @balance = @balance + amount.abs
    @transactions << [date, amount.abs]
  end

  def date_formatter(date)
    date = date.split("-").reverse!.join("-")
    Date.strptime(date).strftime("%d/%m/%Y")
  end
end
