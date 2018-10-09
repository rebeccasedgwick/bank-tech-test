require_relative "account"
class Statement
  def initialize(account)
    @account = account
  end

  def show
    @account.transactions
  end




end
