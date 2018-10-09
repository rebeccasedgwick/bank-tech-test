require "date"

class Account
  attr_reader :transactions, :balance

  def initialize
    @transactions = []
    @balance = 0.00
  end

  def withdraw(date, amount)
    date = date_formatter(date)
    @balance = @balance - amount.abs
    @transactions << [date, -(amount.abs)]
  end

  def deposit(date, amount)
    date = date_formatter(date)
    @balance = @balance + amount.abs
    @transactions << [date, amount.abs]
  end
  ## NOTE: Currently keeping the #.abs method on #deposit in case deposit / withdraw are renamed to credit / debit, which can be confused easily depending on whether you're considering this from the customer of bank's point of view.

  def date_formatter(date)
    Date.strptime(date).strftime("%d/%m/%Y")
  end
end
