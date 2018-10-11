class Statement
  def initialize(account = Account)
    @account = account
  end

  def show
    puts @account.transactions
  end
end
