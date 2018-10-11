class Statement
  HEADERS = "date       || credit      || debit       || balance    "

  def initialize(account = Account.new)
    @account = account
  end

  def show
    puts HEADERS
    @account.transactions.reverse_each do |transaction|
      puts [
        prettify_date(transaction.date).ljust(10, " "),
        format_number(transaction.credit).rjust(12, " "),
        format_number(transaction.debit).rjust(12, " "),
        format_number(transaction.balance).rjust(12, " ")
      ].join(" ||")
    end
  end

  private
  def prettify_date(date)
    date.strftime("%d/%m/%Y")
  end

  def format_number(number)
    "%.2f" % number.abs
  end
end
